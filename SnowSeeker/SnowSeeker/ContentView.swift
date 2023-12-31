//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Julian Saxl on 2023-09-06.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var favourites = Favourites()
    
    @State private var searchText = ""
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter {$0.name.localizedCaseInsensitiveContains(searchText)}
        }
    }

    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favourites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }.navigationTitle("Resorts")
                .searchable(text: $searchText, prompt: "Search for a resort")
            
            WelcomeView()
        }.environmentObject(favourites)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
