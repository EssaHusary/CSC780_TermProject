//
//  WelcomePageView.swift
//  CSC780_TermProject
//
//  Created by Essa Husary on 11/18/26.
//

import SwiftUI

struct WelcomePage: View {
    
    @ObservedObject var cameraManager: CameraManager
    
    var body: some View {

        
        NavigationStack {
            VStack(spacing: 20) {
                Text("Welcome to my Nutrition Label Interpreter app!")
                    .font(.largeTitle.bold())
                    .fixedSize(horizontal: false, vertical: true)
                    .offset(y: -175)
                Text("Instructions:")
                    .font(.headline)
                    .offset(y: -100)
                Text("Click the button below. You will be navigated to the camera. Once you're at the photo-taking screen, take a photo of a nutrition label and you will have it interpreted for you!")
                    .offset(y: -100)
                Text("**Do note that these interpretations are based on one serving.")
                    .foregroundStyle(.secondary)
                NavigationLink("Tap here to start!") {
                    CameraPageView(cameraManager: cameraManager)
                }
                .buttonStyle(.glassProminent)
            }

            

        }
        
    }
}
