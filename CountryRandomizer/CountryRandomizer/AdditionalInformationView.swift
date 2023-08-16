//
//  AdditionalInformationView.swift
//  CountryRandomizer
//
//  Created by Julian Saxl on 2023-08-15.
//
import MapKit
import SwiftUI

struct AdditionalInformationView: View {
    var country: Country
    @State var mapRegion: MKCoordinateRegion
    
    var body: some View {
        let annotation = [country]
        ZStack {
            Map(coordinateRegion: $mapRegion, annotationItems: annotation) {_ in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: country.wrappedLatitude, longitude: country.wrappedLongitude))
            }
                .ignoresSafeArea()
        }
    }
}

struct AdditionalInformationView_Previews: PreviewProvider {
    static var previews: some View {
        AdditionalInformationView(country: Country(id: "Foo", iso2Code: "Foo", name: "Bar", region: Subinformation(id: "", iso2code: "", value: ""), adminregion: Subinformation(id: "", iso2code: "", value: ""), incomeLevel: Subinformation(id: "", iso2code: "", value: ""), lendingType: Subinformation(id: "", iso2code: "", value: ""), capitalCity: "Capital", longitude: "longitude", latitude: "latitude"),
          mapRegion: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 1), span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25)))
    }
}
