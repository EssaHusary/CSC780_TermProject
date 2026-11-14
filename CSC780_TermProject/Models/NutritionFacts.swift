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
    var saturatedFat: Double?
    var sodium: Double?
    var addedSugars: Double?
    var protein: Double?
    var rawLines: [String] = []   
}
