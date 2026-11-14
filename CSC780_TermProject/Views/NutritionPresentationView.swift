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
    
    var interpretations: [String] {
        Interpreter(parsedNutritionFacts: nutritionFacts).interpret()
    }
    
    var body: some View {
        
        VStack {
            
            List {
                
                Row(macroNutrient: "Calories", macroNutrientValue: nutritionFacts.calories, unit: "kcal")
                Row(macroNutrient: "Saturated Fats", macroNutrientValue: nutritionFacts.saturatedFat, unit: "g")
                Row(macroNutrient: "Sodium", macroNutrientValue: nutritionFacts.sodium, unit: "mg")
                Row(macroNutrient: "Added Sugars", macroNutrientValue: nutritionFacts.addedSugars, unit: "g")
                Row(macroNutrient: "Protein", macroNutrientValue: nutritionFacts.protein, unit: "g")
                
                Text("\(interpretations[0])")
                Text("\(interpretations[1])")
                Text("\(interpretations[2])")
                Text("\(interpretations[3])")
                Text("\(interpretations[4])")
                
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
