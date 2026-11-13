//
//  NutritionParser.swift
//  CSC780_TermProject
//
//  Created by Essa Husary on 11/8/26.
//

import UIKit
import Vision

class NutritionParser {
    
    /// Main entry point: takes a UIImage, runs Vision OCR on a background thread, and returns NutritionFacts.
    static func parse(image: UIImage) async -> NutritionFacts {
        guard let cgImage = image.cgImage else {
            return NutritionFacts()
        }
        
        let orientation = cgImageOrientation(from: image.imageOrientation)
        
        var request = RecognizeTextRequest()
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = false
        
        do {
            let observations = try await request.perform(on: cgImage, orientation: orientation)
            let correctedLines = clusterObservationsIntoRows(observations)
            let extractedNutrients = extractNutrients(from: correctedLines)
            return extractedNutrients
        } catch {
            print("Vision OCR Error: \(error.localizedDescription)")
            return NutritionFacts()
        }
    }
    
    // MARK: - Step 1: Y-Axis Coordinate Clustering
    private static func clusterObservationsIntoRows(_ observations: [RecognizedTextObservation]) -> [String] {
        struct TextBox {
            let text: String
            let minX: CGFloat
            let midY: CGFloat
        }
        
        // Extract top string candidate and bounding box coordinates
        let boxes: [TextBox] = observations.compactMap { obs in
            guard let topCandidate = obs.topCandidates(1).first else { return nil }
            return TextBox(
                text: topCandidate.string,
                minX: obs.boundingBox.cgRect.minX,
                midY: obs.boundingBox.cgRect.midY
            )
        }
        
        // Vision uses a bottom-left origin (0,0 is bottom-left, 1,1 is top-right).
        // Sorting by midY descending orders the text from TOP of the label to BOTTOM.
        let sortedByY = boxes.sorted { $0.midY > $1.midY }
        
        var rows: [[TextBox]] = []
        let yThreshold: CGFloat = 0.018 // ~1.8% of image height tolerance for same row
        
        for box in sortedByY {
            if let lastRowIndex = rows.indices.last,
               let firstInRow = rows[lastRowIndex].first,
               abs(firstInRow.midY - box.midY) < yThreshold {
                // Belongs to the same horizontal line
                rows[lastRowIndex].append(box)
            } else {
                // Start a new horizontal line
                rows.append([box])
            }
        }
        
        // Sort each row left-to-right (ascending minX) and join into a single line string
        return rows.map { row in
            row.sorted { $0.minX < $1.minX }
               .map { $0.text }
               .joined(separator: " ")
        }
    }
    
    // MARK: - Step 2: Regex Nutrient Extraction
    private static func extractNutrients(from lines: [String]) -> NutritionFacts {
        
        var facts = NutritionFacts()
        
//        let caloriesOptional = matchDouble(pattern: #/(?i)calories\D*?(\d{1,4})/#, in: lines)
//        if let calories = caloriesOptional {
//            facts.calories = Int(calories)    // Most nutrition labels worldwide round Calories to the nearest Integer, so this is safe.
//        }
        
        facts.calories = matchDouble(pattern: #/(?i)calories\D*?(\d{1,4})/#, in: lines)
        
        facts.totalFat = matchDouble(pattern: #/(?i)total\s*fat\D*?(\d+(?:\.\d+)?)\s*g/#, in: lines)
        
        facts.totalCarbohydrates = matchDouble(pattern: #/(?i)total\s*carb[a-z.]*\D*?(\d+(?:\.\d+)?)\s*g/#, in: lines)
        
        facts.protein = matchDouble(pattern: #/(?i)protein\D*?(\d+(?:\.\d+)?)\s*g/#, in: lines)
        
        facts.sodium = matchDouble(pattern: #/(?i)sodium\D*?(\d+(?:\.\d+)?)\s*m?g/#, in: lines)
        
        
        return facts
    }
    
    private static func matchDouble(pattern: Regex<(Substring, Substring)>, in lines: [String]) -> Double? {
       
        
        for line in lines {

            
            guard let match = line.firstMatch(of: pattern),
                  let newVal = Double(match.1) else {
                continue
            }
            
            
            return newVal
        }
        
        return nil
        
        
    }
    
    // Maps UIImage orientation so Vision reads vertical portrait photos right-side-up
    private static func cgImageOrientation(from uiOrientation: UIImage.Orientation) -> CGImagePropertyOrientation {
        switch uiOrientation {
        case .up: return .up
        case .down: return .down
        case .left: return .left
        case .right: return .right
        case .upMirrored: return .upMirrored
        case .downMirrored: return .downMirrored
        case .leftMirrored: return .leftMirrored
        case .rightMirrored: return .rightMirrored
        @unknown default: return .up
        }
    }
}

