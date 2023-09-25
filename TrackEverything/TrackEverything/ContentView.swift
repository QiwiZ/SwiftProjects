//
//  ContentView.swift
//  TrackEverything
//
//  Created by Julian Saxl on 2023-08-28.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var showingAddView = false
    @State private var isShowingSortingDialog = false
    
    var body: some View {
        TabView {
            NavigationView {
              TrackedEntityView(entityType: "Book")
                    .toolbar {
                        Button {
                            showingAddView = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    .sheet(isPresented: $showingAddView) {
                        AddEntityView(entityType: "Book")
                    }
            }.tabItem {
                Label("Books", systemImage: "book")
            }
            NavigationView {
              TrackedEntityView(entityType: "Game")
                    .toolbar {
                        Button {
                            showingAddView = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    .sheet(isPresented: $showingAddView) {
                        AddEntityView(entityType: "Game")
                    }
            }.tabItem {
                Label("Games", systemImage: "gamecontroller")
            }
            NavigationView {
              TrackedEntityView(entityType: "Movie")
                    .toolbar {
                        Button {
                            showingAddView = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    .sheet(isPresented: $showingAddView) {
                        AddEntityView(entityType: "Movie")
                    }
            }.tabItem {
                Label("Movies", systemImage: "popcorn")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
