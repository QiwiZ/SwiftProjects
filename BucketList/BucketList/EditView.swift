//
//  EditView.swift
//  BucketList
//
//  Created by Julian Saxl on 2023-08-06.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void
    
    @StateObject private var viewModel: ViewModel
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave
        
        _viewModel = StateObject(wrappedValue: ViewModel(location: location))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place Name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                Section("Nearby...") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .failed:
                        Text("Please try again later")
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    }
                }
            }
            .navigationTitle("\(viewModel.location.name) Details")
            .toolbar {
                Button("Save") {
                    var newLocation = viewModel.location
                    newLocation.id = UUID()
                    newLocation.name = viewModel.name
                    newLocation.description = viewModel.description
                    onSave(newLocation)
                    
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) {newLocation in}
    }
}
