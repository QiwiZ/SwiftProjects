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
            Button("Generate random country") {
                viewModel.randomizeCountry()
            }
            
            if (viewModel.randomCountry != nil) {
                Text(viewModel.randomCountry!.name)
            }
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
