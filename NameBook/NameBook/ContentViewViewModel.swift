//
//  ContentViewViewModel.swift
//  NameBook
//
//  Created by Julian Saxl on 2023-08-13.
//

import Foundation
import SwiftUI

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var image: Image?
        @Published var showingImagePicker = false
        @Published var inputImage: UIImage?
        @Published var askingForName = false
        @Published var images = [ImageInformation]() {
            didSet {
                if let encoded = try? JSONEncoder().encode(images) {
                    UserDefaults.standard.set(encoded, forKey: "imageNames")
                }
            }
        }
        
        
        init() {
            if let savedImages = UserDefaults.standard.data(forKey: "imageNames") {
                if let decoded = try? JSONDecoder().decode([ImageInformation].self, from: savedImages) {
                    images = decoded
                    return
                }
            }
            images = []
        }
        
        func loadImage() {
            guard let inputImage = inputImage else {return}
            image = Image(uiImage: inputImage)
        }
        
        func loadImageFromDisc(savePath: URL) -> Image {
            let image = UIImage(contentsOfFile: savePath.path)
            return Image(uiImage: image!)
        }
    }
}

