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
            return "The calorie content of this food item is quite high, at >= 20% of the daily caloric intake, assuming a 2000 calorie diet. Typical dietary guidlines suggest that people ought to consume 3 meals a day with roughly 20-30% of their maintenance calories deriving from each meal. If this item is a mere snack, take extra precaution if you consume less than 2000 calories per day."
        
        case .calories(.medium):
            return "The calorie content in one serving of this item is moderate at just under 20% of the daily average intake, assuming a 2000 calorie diet. It ought to provide a good source of energy for all use cases."
        
        case .calories(.low):
            return "The calorie content in one serving of this item is very low, at under 5% of the daily average intake, assuming a 2000 calorie diet. If you are aiming to gain weight or consume enough energy for bodily health, consider switching to a food item with a higher source of calories."
        
        case .calories(.unknown):
            return "Insufficient data is provided. Cannot interpret caloric intake."
        
        case .saturatedFat(.high):
            return "The saturated fat content of this food item is quite high, at >= 20% of the daily recommended intake (20g cap per the FDA). High intakes of saturated fat are associated with elevated LDL cholesterol (bad cholesterol), elevated kidney strain, and increased risk of cardiovascular disease risk. Take these risks into consideration."
        
        case .saturatedFat(.medium):
            return "The saturated fat content in one serving of this item is moderately high at just under 20% of the daily recommended intake (20g cap per the FDA). Because high intakes of saturated fats increase risk for cardiovascular disease and elevated LDL cholesterol levels, do take into mind while consuming this product that you may need to be wary of other foods with higher amounts of saturated fats for the rest of the day so as to not exceed 20g of saturated fats."
        
        case .saturatedFat(.low):
            return "The saturated fat content in one serving of this item is very low at under 5% of the daily recommended intake (20g cap per the FDA). You can safely consume this food item, though do be wary of other sources of saturated fats throughout the day."
        
        case .saturatedFat(.unknown):
            return "Insufficient data is provided. Cannot interpret saturated fat intake."
        
        case .sodium(.high):
            return "The sodium content of this food item is quite high, at >= 20% of the daily recommended intake (2300mg cap per the FDA). High sodium intake is associated with hypertension and certain cardiovascular diseases over time. Take these risks into consideration and do be vigilant of other high sources of sodium throughout the day."
        
        case .sodium(.medium):
            return "The sodium content in one serving of this item is moderately high at just under 20% of the daily recommended intake (2300mg cap per the FDA). Because high intake of sodium is associated with hypertension and certain cardiovascular diseases over time, do take into mind while consuming this product that you may need to be wary of other foods with higher amounts of sodium for the rest of the day so as to not exceed 2300mg of sodium."
        
        case .sodium(.low):
            return "The sodium content in one serving of this item is very low at under 5% of the daily recommended intake (2300mg cap per the FDA). You can safely consume this food item, though do be wary of other sources of sodium throughout the day."
        
        case .sodium(.unknown):
            return "Insufficient data is provided. Cannot interpret sodium intake."
        
        case .addedSugars(.high):
            return "The added sugar content of this food item is quite high, at >= 20% of the daily recommended intake (50g cap per the FDA). High intakes of added sugar are associated with hypertension and increased risk of diabetes. Unlike the naturally occuring sugars in fruits which are surrounded by fiber, water, vitamins, and minerals, added sugars lack this boundary and enter your bloodstream quickly. Take these risks into consideration, especially if you are diabetic or have prediabetes."
        
        case .addedSugars(.medium):
            return "The added sugar content in one serving of this item is moderately high at just under 20% of the daily recommended intake (50g cap per the FDA). While it is not high, do be cautious of other sources of added sugar throughout your day, such as honey and table sugar, as added sugars increase risk of hypertension and diabetes."
        
        case .addedSugars(.low):
            return "The added sugar content in one serving of this item is very low at under 5% of the daily recommended intake (50g cap per the FDA). You may safely enjoy this food item, though do be vigilant of other sources of added sugar, especially if you are a person with diabetes or prediabetes."
        
        case .addedSugars(.unknown):
            return "Insufficient data is provided. Cannot interpret added sugar intake."
        
        case .protein(.high):
            return "The protein content of this food item is quite high, at >= 20% of the daily suggested and encouraged intake (50g encouraged amount per the FDA). Protein is a macronutrient that is almost never limited by dieticians and doctors, as a person in good health can theoretically digest large amounts of protein exceeding 300% of the daily suggested intake throughout the day. High intake of protein is associated with increased muscle and bone health. You can never have enough of it! In fact, there is no upper limit established by the FDA, so enjoy!"
        
        case .protein(.medium):
            return "The protein content of this food item is moderately high, at just under 20% of the daily suggested and encouraged intake (50g encouraged amount per the FDA). Protein is a macronutrient that is almost never limited by dieticians and doctors, as a person in good health can theoretically digest large amounts of protein exceeding 300% of the daily suggested intake throughout the day. High intake of protein is associated with increased muscle and bone health. Do consume food items with high amounts of protein to at least reach the FDA recommended amount of 50g by the end of the day."
        
        case .protein(.low):
            return "The protein content of this food item is very low, at just under 5% of the daily suggested and encouraged intake (50g encouraged amount per the FDA). Please consider consuming foods throughout the day with protein content higher than this as high intakes of protein is associated with increased bone and muscle health. The FDA does not have a cap on protein intake because protein is a vital macronutrient, so consider eating other foods throughout the day with higher amounts of protein to maximize your health."
        
        case .protein(.unknown):
            return "Insufficient data is provided. Cannot interpret protein intake."
            
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
