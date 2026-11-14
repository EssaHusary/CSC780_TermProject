//
//  CameraManager.swift
//  CSC780_TermProject
//
//  Created by Essa Husary on 11/8/26.
//

import AVFoundation
import UIKit
import Combine

// https://youtu.be/cLnw5z8ZGqM?si=ERRnIjfBKnxBLrkb

class CameraManager: NSObject, ObservableObject {
    
    @Published var image: UIImage?
    @Published var isRunning = false
    @Published var permissionGranted = false
    @Published var parsedNutritionFacts: NutritionFacts?
    
    let session = AVCaptureSession()
    private let photoOutput = AVCapturePhotoOutput()
    private let sessionQueue = DispatchQueue(label: "com.csc780.cameraSessionQueue")
    private var isConfigured = false
    
    
    override init(){
        super.init()
        checkPermissions()
    }
    
    func checkPermissions(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
            
        case .authorized:
            permissionGranted = true
            
        case .notDetermined:
            Task {
                await AVCaptureDevice.requestAccess(for: .video)
            }
            
        case .denied:
            return
            
        case .restricted:
            return
            
        @unknown default:
            return
        }
    }
    
    
    func configureSession(){
        
        session.beginConfiguration()
        
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let captureDeviceInput = try? AVCaptureDeviceInput(device: captureDevice) else {
                      return
        }
        
        if session.canAddInput(captureDeviceInput) {
            session.addInput(captureDeviceInput)
        } else {
            
            return
        
        }
        
        if session.canAddOutput(photoOutput){
            session.addOutput(photoOutput)
        }
        
        session.commitConfiguration()
        self.isConfigured = true
        
    }
    
    func startSession(){
        sessionQueue.async {[weak self] in
            
            guard let self = self else {
                return
            }
            
            if !self.isConfigured {
                self.configureSession()
            }
            if !self.isRunning {
                session.startRunning()
                DispatchQueue.main.async { self.isRunning = true }
            }
            
        }
    }
    
    func stopSession(){
        sessionQueue.async {[weak self] in
            
            guard let self = self else {
                return
            }
            
            if self.isRunning {
                session.stopRunning()
                DispatchQueue.main.async { self.isRunning = false }
            }
            
        }
    }
    
    func capturePhoto(){
        
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
        
    }
    
}
//MARK: - Photo Capture Delegate
extension CameraManager: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput,
                         didFinishProcessingPhoto photo: AVCapturePhoto,
                         error: Error?) {
        guard error == nil,
              let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else {
            return
        }
        
        Task {@MainActor in
            
            self.image = image
            self.parsedNutritionFacts = await NutritionParser.parse(image: image)
            
        }
    }
    
}
