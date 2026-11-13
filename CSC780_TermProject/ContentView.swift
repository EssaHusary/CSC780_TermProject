//
//  ContentView.swift
//  CSC780_TermProject
//
//  Created by Essa Husary on 11/8/26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var cameraManager = CameraManager()
    @State private var didCapturePhoto = false
    
    var body: some View {
//        WelcomePage()
        
        if !cameraManager.permissionGranted {
            
            Text("Please provide permission to access your camera.")
                .font(.largeTitle)
        
        } else {
            
            ZStack {
                
                CameraPreviewView(session: cameraManager.session)
                    .onAppear {
                        cameraManager.startSession()
                    }
                    .ignoresSafeArea()
                
                Button("") {
                    Task {
                        cameraManager.capturePhoto()
                        didCapturePhoto = true
                    }
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.circle)
                .controlSize(.large)
                .sheet(isPresented: $didCapturePhoto) {
                    
                    NutritionSheet(capturedPhoto: cameraManager.capturedImage)
                    
                }
                
            }
        }
    }
        
}



struct NutritionSheet: View {
    
    var capturedPhoto: UIImage? // Passed from ContentView!
    @State var nutritionFacts: NutritionFacts?
    
    var body: some View {
        
        VStack {
            
            if let facts = nutritionFacts {
                
                List {
                    
                    Row(macroNutrient: "Calories", macroNutrientValue: facts.calories, unit: "kcal")
                    Row(macroNutrient: "Total Fat", macroNutrientValue: facts.totalFat, unit: "g")
                    Row(macroNutrient: "Total Carbs", macroNutrientValue: facts.totalCarbohydrates, unit: "g")
                    Row(macroNutrient: "Protein", macroNutrientValue: facts.protein, unit: "g")
                    Row(macroNutrient: "Sodium", macroNutrientValue: facts.sodium, unit: "mg")
                    
                }
                
            } else {
                
                Text("loading")
                
            }
            
            
        }
        .task(id: capturedPhoto) {
            guard let image = capturedPhoto else { return }
            nutritionFacts = await NutritionParser.parse(image: image)
        }
        
        
    }
}



struct Row: View {
    
    let macroNutrient: String
    let macroNutrientValue: Double?
    let unit: String
    
    var body: some View {
        HStack {
            
            Text("\(macroNutrient):")
            
            if let nutrientValue = macroNutrientValue {
                
                Text("\(nutrientValue, specifier: "%.1f") \(unit)")
                
            } else {
                
                Text("No value detected.")
                
            }
            
        }
        
    }
}




struct WelcomePage: View {
    var body: some View {
        Text("Welcome to My Nutrition Interpreter App! Press the button below to get started! You will be prompted to take a photo of a nutrition label for interpretation!")
            .font(.largeTitle)
            .fontDesign(.monospaced)
    }
}

#Preview {
    ContentView()
}
