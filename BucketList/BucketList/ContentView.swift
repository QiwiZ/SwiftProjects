//
//  ContentView.swift
//  BucketList
//
//  Created by Julian Saxl on 2023-08-04.
//
import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.isUnlocked {
                Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(Circle())
                            Text(location.name)
                                .fixedSize()
                        }.onTapGesture {
                            viewModel.selectedPlace = location
                        }
                    }
                }
                    .ignoresSafeArea()
                Circle()
                    .fill(.blue)
                    .opacity(0.3)
                    .frame(width: 30, height: 30)
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button {
                            viewModel.addLocation()
                        } label: {
                            Image(systemName: "plus")
                                .padding()
                                .background(.black.opacity(0.75))
                                .foregroundColor(.white)
                                .font(.title)
                                .clipShape(Circle())
                                .padding(.trailing)
                        }
                    }
                }
            } else {
                Button("Authenticate") {
                    viewModel.authenticate()
                }
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }.sheet(item: $viewModel.selectedPlace) { place in
            EditView(location: place) {
                viewModel.updateLocation(location: $0)
            }
        }.alert("Ooops!", isPresented: $viewModel.showingAuthenticationError) {
            Button("Ok") {}
        } message: {
            Text("Authentication failed. Please try again.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
