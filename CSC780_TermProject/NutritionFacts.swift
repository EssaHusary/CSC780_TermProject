//
//  NutritionFacts.swift
//  CSC780_TermProject
//
//  Created by Essa Husary on 11/8/26.
//

import Foundation

struct NutritionFacts: Identifiable {
    let id = UUID()   // I may need this list out values before interpreting them
    var calories: Double?
    var totalFat: Double?
    var totalCarbohydrates: Double?
    var protein: Double?
    var sodium: Double?
    var rawLines: [String] = []   
    
    // This is a computed property to see if we have at least one macro. I might delete this computed property later.
    var hasData: Bool {
        calories != nil || totalFat != nil || totalCarbohydrates != nil || protein != nil || sodium != nil
    }
}
