//
//  ContentView.swift
//  CSC780_TermProject
//
//  Created by Essa Husary on 11/8/26.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        WelcomePage()
    }
}

struct WelcomePage: View {
    var body: some View {
        Text("Welcome to My Nutrition Interpreter App! Press the button below to get started! You will be prompted to take a photo of a nutrition label for interpretation!")
            .font(.largeTitle)
            .fontDesign(.monospaced)
    }
}
