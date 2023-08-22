//
//  Prospect.swift
//  HotProspects
//
//  Created by Julian Saxl on 2023-08-21.
//

import SwiftUI

class Prospect: Codable, Identifiable {
    var id = UUID()
    var name = "Anonymous"
    var email = ""
    var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    init() {
        self.people = []
    }
}
