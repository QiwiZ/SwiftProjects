//
//  Game.swift
//  TrackEverything
//
//  Created by Julian Saxl on 2023-08-28.
//

import Foundation

struct Game: Codable, Identifiable {
    var id = UUID()
    var title: String
    var developer: String
    var genre: String
    var rating: Int
    var notes: [Note]
}
