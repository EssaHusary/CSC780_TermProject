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
        
        if !cameraManager.permissionGranted {
            
            RequestPermissionsView()
        
        } else {
            
            WelcomePage(cameraManager: cameraManager)
        }
        
    }
        
}



#Preview {
    ContentView()
}
