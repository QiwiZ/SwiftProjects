//
//  ContentView.swift
//  CountryRandomizer
//
//  Created by Julian Saxl on 2023-08-09.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            if (viewModel.randomCountry != nil) {
                Text(viewModel.randomCountry!.name)
                    .font(.largeTitle)
            }
            
            Spacer()
            
            Button("Randomize country") {
                viewModel.randomizeCountry()
            }.padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
        }
        .padding()
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
