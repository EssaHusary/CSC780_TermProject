//
//  ContentView.swift
//  CSC780_TermProject
//
//  Created by Essa Husary on 11/8/26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var cameraManager = CameraManager()
    
    
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
                    }
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.circle)
                .controlSize(.large)
                .sheet(item: $cameraManager.parsedNutritionFacts) { nutritionFacts in
                    
                    NutritionSheet(nutritionFacts: nutritionFacts)
                    
                }
                
            }
        }
    }
        
}



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
