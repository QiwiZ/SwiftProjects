//
//  PersonLocationView.swift
//  NameBook
//
//  Created by Julian Saxl on 2023-08-14.
//
import MapKit
import SwiftUI


struct PersonLocationView: View {
    var imageInformation: ImageInformation
    @State var mapRegion: MKCoordinateRegion
    
    var body: some View {
        let annotation = [imageInformation]
        Map(coordinateRegion: $mapRegion, annotationItems: annotation) {
            MapMarker(coordinate: $0.location)
        }
    }
}
