//
//  ContentView.swift
//  CountryRandomizer
//
//  Created by Julian Saxl on 2023-08-09.
//
import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Background()
                
                VStack(spacing: 15) {
                    Spacer()
                    VStack {
                        if (viewModel.randomCountry != nil) {
                            Text("Your country is:")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text(viewModel.randomCountry!.name)
                                .font(.largeTitle.weight(.bold))
                                .foregroundColor(.black)
                            Spacer()
                            Image(viewModel.randomCountry!.id)
                                .resizable()
                                .scaledToFit()
                                .padding(.horizontal)
                        } else {
                            Text("Choose a random country")
                                .foregroundColor(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                    Spacer()
                    if viewModel.randomCountry != nil && !viewModel.randomCountry!.capitalCity.isEmpty{
                        NavigationLink {
                            AdditionalInformationView(country: viewModel.randomCountry!, mapRegion: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: viewModel.randomCountry!.wrappedLatitude, longitude: viewModel.randomCountry!.wrappedLongitude), span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25)))
                        } label: {
                            Text("Additional information")
                                .padding()
                                .background(.blue)
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                        }
                    }
                }.padding()
                .onTapGesture {
                    viewModel.randomizeCountry()
                }
            }
        }
        .task {
            if viewModel.countries.isEmpty {
                await viewModel.fetchWorldCountries()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
