//
//  ContentView.swift
//  NameBook
//
//  Created by Julian Saxl on 2023-08-13.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.images.sorted()) { image in
                        HStack {
                            NavigationLink {
                                PersonDetailView(image:viewModel.loadImageFromDisc(savePath: image.savePath), imageInformation: image)
                            } label: {
                                viewModel.loadImageFromDisc(savePath: image.savePath ).resizable().scaledToFit()
                                Text(image.name)
                            }
                        }
                    }
                }
                
                Button {
                    viewModel.showingImagePicker = true
                } label: {
                    Text("Select Image")
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                
            }
            .padding()
            .onChange(of: viewModel.inputImage) { _ in
                viewModel.loadImage()
                viewModel.askingForName = true
            }
            
            .sheet(isPresented: $viewModel.showingImagePicker) {
                ImagePicker(image: $viewModel.inputImage)
            }
            .sheet(isPresented: $viewModel.askingForName) {
                NameFormView(uiImage: viewModel.inputImage!, images: $viewModel.images)
            }
            .navigationTitle("NameBook")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
