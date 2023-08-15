//
//  NameFormView.swift
//  NameBook
//
//  Created by Julian Saxl on 2023-08-13.
//

import SwiftUI

struct NameFormView: View {
    @Environment(\.dismiss) var dismiss
    @State var uiImage: UIImage
    @State private var nameOfPerson = ""
    @Binding var images: [ImageInformation]
    
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter the persons name", text: $nameOfPerson)
            }
            .navigationTitle("Add a new name")
            .toolbar {
                Group {
                    Button("Track the location for this picture") {
                        self.locationFetcher.start()
                    }
                    Button("Save") {
                        save()
                    }.disabled(nameOfPerson.isEmpty)
                }
                
            }
        }
    }
    
    func save() {
        let imageSaver = ImageSaver()
        let savePath = FileManager.documentsDirectory.appendingPathComponent(nameOfPerson)
        imageSaver.writePhotoToDisc(image: uiImage, savePath: savePath)
        images.append(ImageInformation(name: nameOfPerson, latitude: locationFetcher.lastKnownLocation?.latitude, longitude: locationFetcher.lastKnownLocation?.longitude))
        dismiss()
    }
}
