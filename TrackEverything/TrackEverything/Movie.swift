//
//  Movie.swift
//  TrackEverything
//
//  Created by Julian Saxl on 2023-08-28.
//

import Foundation

struct Movie: Codable, Identifiable {
    var id = UUID()
    var title: String
    var director: String
    var genre: String
    var rating: Int
    var notes: [Note]
}
