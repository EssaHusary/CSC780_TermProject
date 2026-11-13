//
//  CameraPreviewView.swift
//  CSC780_TermProject
//
//  Created by Essa Husary on 11/8/26.
//

import SwiftUI
import AVFoundation

struct CameraPreviewView: UIViewRepresentable {
    let session: AVCaptureSession
    
    class VideoPreviewView: UIView {
        // 1. Tell UIKit: "Do not use standard CALayer; use AVCaptureVideoPreviewLayer instead!"
        
        override class var layerClass: AnyClass {
            AVCaptureVideoPreviewLayer.self
        }
        
        
        var castToAVCaptureVideoPreviewLayer: AVCaptureVideoPreviewLayer? {
            guard let castedLayer = layer as? AVCaptureVideoPreviewLayer else {
                return nil
            }
            return castedLayer
        }
    }

    
    func makeUIView(context: Context) -> some UIView {
        let videoPreviewView = VideoPreviewView()
        videoPreviewView.castToAVCaptureVideoPreviewLayer?.session = session
        videoPreviewView.backgroundColor = .black
        videoPreviewView.castToAVCaptureVideoPreviewLayer?.videoGravity = .resizeAspectFill
        return videoPreviewView
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //do nothing
    }
}
