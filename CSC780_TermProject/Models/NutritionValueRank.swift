//
//  NutritionInterpretations.swift
//  CSC780_TermProject
//
//  Created by Essa Husary on 11/13/26.
//


enum NutritionRank {
    
    case high
    case medium
    case low
    case unknown
    
    static func determineRank(nutritionValue: Double?, valueCapGlobal: Double) -> NutritionRank {
        guard let value = nutritionValue else {
            return .unknown
        }
        
        let computation = value / valueCapGlobal
        
        if computation >= 0.20 {
            return .high
        } else if (computation < 0.20) && (computation > 0.05){
            return .medium
        } else {
            return .low
        }
        
    }
    
}

enum NutritionMacroWithRank {
    case calories(NutritionRank)
    case saturatedFat(NutritionRank)
    case sodium(NutritionRank)
    case addedSugars(NutritionRank)
    case protein(NutritionRank)
}
