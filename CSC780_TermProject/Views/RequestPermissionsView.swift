//
//  RequestPermissionsView.swift
//  CSC780_TermProject
//
//  Created by Essa Husary on 11/20/26.
//

import SwiftUI

struct RequestPermissionsView: View {
    
    var body: some View {
        
        Text("Please provide permission to access your camera. The app cannot function without your permission.")
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(.blue, in: RoundedRectangle(cornerRadius: 20, style: .continuous)) // Or RoundedRectangle(cornerRadius: 12)

        
    }
}
