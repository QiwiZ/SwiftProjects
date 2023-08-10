//
//  ChallengeDay60App.swift
//  ChallengeDay60
//
//  Created by Julian Saxl on 2023-07-27.
//
import SwiftUI

@main
struct ChallengeDay60App: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
