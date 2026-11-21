//
//  NutritionPresentationView.swift
//  CSC780_TermProject
//
//  Created by Essa Husary on 11/12/26.
//

import Foundation
import SwiftUI

struct NutritionSheet: View {
    
    @State var nutritionFacts: NutritionFacts
    
    // To grab the dismiss action from the SwiftUI environment
    @Environment(\.dismiss) private var dismiss
    
    var interpretations: [String] {
        Interpreter(parsedNutritionFacts: nutritionFacts).interpret()
    }
    
    var body: some View {
        
        VStack {
            
            Button {
                dismiss()
            } label: {
                Text("Scan another")
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .padding(.vertical, 20)
            
            List {
                
                Section {
                    Row(macroNutrient: "Calories", macroNutrientValue: nutritionFacts.calories, unit: "kcal")
                    Row(macroNutrient: "Saturated Fats", macroNutrientValue: nutritionFacts.saturatedFat, unit: "g")
                    Row(macroNutrient: "Sodium", macroNutrientValue: nutritionFacts.sodium, unit: "mg")
                    Row(macroNutrient: "Added Sugars", macroNutrientValue: nutritionFacts.addedSugars, unit: "g")
                    Row(macroNutrient: "Protein", macroNutrientValue: nutritionFacts.protein, unit: "g")
                } header: {
                    Text("Detected macronutrients:")
                        .bold()
                }
                
                
                Section {
                    Text("\(interpretations[0])")
                    Text("\(interpretations[1])")
                    Text("\(interpretations[2])")
                    Text("\(interpretations[3])")
                    Text("\(interpretations[4])")
                } header: {
                    Text("Interpretations:")
                        .bold()
                }
                
                
            }
            
            
            
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
