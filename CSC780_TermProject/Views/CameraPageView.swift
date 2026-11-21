//
//  CameraPageView.swift
//  CSC780_TermProject
//
//  Created by Essa Husary on 11/18/26.
//

import SwiftUI

struct CameraPageView: View {
    
    @ObservedObject var cameraManager: CameraManager
    
    var body: some View {
        
        ZStack {
            
            CameraPreviewView(session: cameraManager.session)
                .onAppear {
                    cameraManager.startSession()
                }
                .ignoresSafeArea()
            
            VStack {
                
                Rectangle()
                    .fill(.black)
                    .frame(width: 600, height: 115)
                    .ignoresSafeArea()

                Spacer()
                
        
                Rectangle()
                    .fill(.black)
                    .frame(width: 600, height: 210)
                    .ignoresSafeArea(edges: .bottom)
                
            }
            
            VStack {
                
                Spacer()
                
                Button {
                    Task {
                        cameraManager.capturePhoto()
                    }
                } label: {
                    
                    ZStack {
                        
                        Circle()
                            .fill(.white)
                            .frame(width: 83, height: 83)
                            .padding(.bottom, 74.5)
                        
                        Circle()
                            .fill(.white)
                            .frame(width: 83, height: 83)
                            .padding(.bottom, 75.5)
                        
                        Circle()
                            .fill(.black)
                            .frame(width: 82, height: 82)
                            .padding(.bottom, 75)
                        
                        Circle()
                            .buttonStyle(.borderedProminent)
                            .buttonBorderShape(.circle)
                            .frame(width: 72, height: 72)
                            .tint(.white)
                            .controlSize(.large)
                            .padding(.bottom, 75)
                        
                    }
                    
                }
                .sheet(item: $cameraManager.parsedNutritionFacts) { nutritionFacts in
                    
                    NutritionSheet(nutritionFacts: nutritionFacts)
                    
                }
                
            }
            
            
            
        }
        
    }
}
