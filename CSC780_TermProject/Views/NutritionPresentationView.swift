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
    
    var body: some View {
        
        VStack {
            
            List {
                
                Row(macroNutrient: "Calories", macroNutrientValue: nutritionFacts.calories, unit: "kcal")
                Row(macroNutrient: "Total Fat", macroNutrientValue: nutritionFacts.totalFat, unit: "g")
                Row(macroNutrient: "Total Carbs", macroNutrientValue: nutritionFacts.totalCarbohydrates, unit: "g")
                Row(macroNutrient: "Protein", macroNutrientValue: nutritionFacts.protein, unit: "g")
                Row(macroNutrient: "Sodium", macroNutrientValue: nutritionFacts.sodium, unit: "mg")
                
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
