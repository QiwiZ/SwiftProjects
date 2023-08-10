//
//  EditViewModel.swift
//  BucketList
//
//  Created by Julian Saxl on 2023-08-09.
//

import SwiftUI
import Foundation

extension EditView {
    @MainActor class ViewModel: ObservableObject {
        enum LoadingState {
            case loading, loaded, failed
        }
        
        @Published var loadingState: LoadingState
        @Published var pages: [Page]
        @Published var name: String
        @Published var description: String
        
        public var location: Location
        
        init(location: Location) {
            self.loadingState = LoadingState.loading
            self.pages = []
            self.location = location
            
            _name = Published(initialValue: location.name)
            _description = Published(initialValue: location.description)
        }
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            
            guard let url = URL(string: urlString) else {
                print("Bad url string: \(urlString)")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)

                let items = try JSONDecoder().decode(Result.self, from: data)

                pages = items.query.pages.values.sorted()
                loadingState = .loaded
                
            } catch {
                print(error.localizedDescription)
                loadingState = .failed
            }
        }
    }
}
