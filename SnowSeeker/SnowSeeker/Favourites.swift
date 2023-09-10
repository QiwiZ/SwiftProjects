//
//  Favourites.swift
//  SnowSeeker
//
//  Created by Julian Saxl on 2023-09-09.
//

import SwiftUI

class Favourites: ObservableObject {
    private var resorts: Set<String>
    
    private var saveKey = "Favourites"
    private var savePath: URL
    
    init() {
        savePath = FileManager.documentsDirectory.appendingPathComponent(saveKey)
        do {
            let data = try Data(contentsOf: savePath)
            resorts = try JSONDecoder().decode(Set<String>.self, from: data)
        } catch {
            resorts = []
        }
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(resorts)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save the data.")
        }
    }
}
