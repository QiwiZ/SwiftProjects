//
//  ControlSlidersView.swift
//  InstaFilter
//
//  Created by Julian Saxl on 2023-08-04.
//

import SwiftUI

struct ControlSlidersView: View {
    @Binding var currentFilter: CIFilter
    @Binding var context: CIContext
    @Binding var processedImage: UIImage?
    @Binding var image: Image?
    
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 100.0
    @State private var filterScale = 5.0
    @State private var filterAngel = 0.5
    
    
    
    var body: some View {
        let inputKeys = currentFilter.inputKeys
        
        VStack {
            HStack {
                if inputKeys.contains(kCIInputIntensityKey) {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) { _ in
                            applyProcessing()
                        }
                }
                
            }
            HStack {
                if inputKeys.contains(kCIInputRadiusKey) {
                    Text("Radius")
                    Slider(value: $filterRadius, in: 50...200)
                        .onChange(of: filterRadius) { _ in
                            applyProcessing()
                        }
                }
            }
            HStack {
                if inputKeys.contains(kCIInputScaleKey) {
                    Text("Scale")
                    Slider(value: $filterScale, in: 1...10)
                        .onChange(of: filterScale) { _ in
                            applyProcessing()
                        }
                }
            }
            
            HStack {
                if inputKeys.contains(kCIInputAngleKey) {
                    Text("Angle")
                    Slider(value: $filterAngel)
                        .onChange(of: filterAngel) { _ in
                            applyProcessing()
                        }
                }
            }
        }
        
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)}
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale, forKey: kCIInputScaleKey)
        }
        
        if inputKeys.contains(kCIInputAngleKey) {
            currentFilter.setValue(filterAngel, forKey: kCIInputAngleKey)
        }
        
        
        guard let outputImage = currentFilter.outputImage else {return}
        
        if let cgimage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimage)
            processedImage = uiImage
            image = Image(uiImage: uiImage)
        }
    }
}
