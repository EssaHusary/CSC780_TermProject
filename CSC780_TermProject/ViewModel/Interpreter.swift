//
//  Interpreter.swift
//  CSC780_TermProject
//
//  Created by Essa Husary on 11/13/26.
//

import Foundation
import UIKit
import Combine

// https://youtu.be/cLnw5z8ZGqM?si=ERRnIjfBKnxBLrkb

struct Interpreter {
    
    private var parsedNutritionFacts: NutritionFacts?
    
    init(parsedNutritionFacts: NutritionFacts?) {
        self.parsedNutritionFacts = parsedNutritionFacts
    }
    
    private func findCorrectInterpretation(forMacro macro: NutritionMacroWithRank) -> String {
        
        switch macro{
            
        case .calories(.high):
            return "high calories"
        case .calories(.medium):
            return "medium calories"
        case .calories(.low):
            return "low calories"
        case .calories(.unknown):
            return "cannot determine calories"
        case .saturatedFat(.high):
            return "high saturated fat"
        case .saturatedFat(.medium):
            return "medium saturated fat"
        case .saturatedFat(.low):
            return "low saturated fat"
        case .saturatedFat(.unknown):
            return "cannot determine saturated fat"
        case .addedSugars(.high):
            return "high added sugars"
        case .addedSugars(.medium):
            return "medium added sugars"
        case .addedSugars(.low):
            return "low added sugars"
        case .addedSugars(.unknown):
            return "cannot determine added sugars"
        case .sodium(.high):
            return "high sodium"
        case .sodium(.medium):
            return "medium sodium"
        case .sodium(.low):
            return "low sodium"
        case .sodium(.unknown):
            return "cannot determine sodium"
        case .protein(.high):
            return "high protein"
        case .protein(.medium):
            return "medium protein"
        case .protein(.low):
            return "low protein"
        case .protein(.unknown):
            return "cannot determine protein"
            
        }
    }
    
    func interpret() -> [String] {
        
        var interpretations: [String] = []
        
        let calorieRank: NutritionRank = NutritionRank.determineRank(nutritionValue: self.parsedNutritionFacts?.calories, valueCapGlobal: NutritionDailyValueDenominatorGlobals.calorieCap)
        let calorieInterpretation = self.findCorrectInterpretation(forMacro: .calories(calorieRank))
        interpretations.append(calorieInterpretation)
        
        let satFatRank: NutritionRank = NutritionRank.determineRank(nutritionValue: self.parsedNutritionFacts?.saturatedFat, valueCapGlobal: NutritionDailyValueDenominatorGlobals.saturatedFatsCap)
        let satFatRankInterpretation = self.findCorrectInterpretation(forMacro: .saturatedFat(satFatRank))
        interpretations.append(satFatRankInterpretation)
        
        let sodiumRank: NutritionRank = NutritionRank.determineRank(nutritionValue: self.parsedNutritionFacts?.sodium, valueCapGlobal: NutritionDailyValueDenominatorGlobals.sodiumCap)
        let sodiumInterpretation = self.findCorrectInterpretation(forMacro: .sodium(sodiumRank))
        interpretations.append(sodiumInterpretation)
        
        let addedSugarRank: NutritionRank = NutritionRank.determineRank(nutritionValue: self.parsedNutritionFacts?.addedSugars, valueCapGlobal: NutritionDailyValueDenominatorGlobals.addedSugarsCap)
        let addedSugarInterpretation = self.findCorrectInterpretation(forMacro: .addedSugars(addedSugarRank))
        interpretations.append(addedSugarInterpretation)
        
        let proteinRank: NutritionRank = NutritionRank.determineRank(nutritionValue: self.parsedNutritionFacts?.protein, valueCapGlobal: NutritionDailyValueDenominatorGlobals.proteinCap)
        let proteinInterpretation = self.findCorrectInterpretation(forMacro: .protein(proteinRank))
        interpretations.append(proteinInterpretation)
        
        return interpretations
        
    }
}
