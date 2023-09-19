//
//  TrackEverythingApp.swift
//  TrackEverything
//
//  Created by Julian Saxl on 2023-08-28.
//

import SwiftUI

@main
struct TrackEverythingApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
