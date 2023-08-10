//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Julian Saxl on 2023-07-25.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
