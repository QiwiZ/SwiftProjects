//
//  ContentViewViewModel.swift
//  CountryRandomizer
//
//  Created by Julian Saxl on 2023-08-10.
//

import Foundation

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var countries: [Country]
        @Published var randomCountry: Country?
        
        private let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedCountries")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                countries = try JSONDecoder().decode([Country].self, from: data)
            } catch {
                countries = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(countries)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save the data.")
            }
        }
        
        func fetchWorldCountries() async {
            let urlString = "https://api.worldbank.org/v2/country/?format=json&per_page=300"
            
            guard let url = URL(string: urlString) else {
                print("Bad url string: \(urlString)")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let items = try JSONDecoder().decode(Result.self, from: data)
                
                countries = items.countries.filter { country in
                    country.region.value != "Aggregates"
                }
                
                save()
            } catch {
                print(error)
            }
        }
        
        func randomizeCountry() {
            randomCountry = countries.randomElement()
        }
    }
}
