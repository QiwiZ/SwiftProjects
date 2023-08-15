//
//  PersonDetailView.swift
//  NameBook
//
//  Created by Julian Saxl on 2023-08-13.
//

import MapKit
import SwiftUI

struct PersonDetailView: View {
    var image: Image
    var imageInformation: ImageInformation
    
    var body: some View {
            VStack {
                NavigationLink {
                    PersonLocationView(imageInformation: imageInformation, mapRegion: MKCoordinateRegion(center: imageInformation.location, span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)))
                } label: {
                    image
                        .resizable()
                        .scaledToFit()
                }
                
                Text(imageInformation.name)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
        }.navigationTitle(imageInformation.name)
    }
}
