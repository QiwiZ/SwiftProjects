//
//  ContentView.swift
//  TrackEverything
//
//  Created by Julian Saxl on 2023-08-28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Text("Books")
                .tabItem {
                    Label("Books", systemImage: "book")
                }
            Text("Games")
                .tabItem {
                    Label("Games", systemImage: "gamecontroller")
                }
            Text("Movies")
                .tabItem {
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
