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
    
    init() {
        
        resorts = []
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
        // save data
    }
}
