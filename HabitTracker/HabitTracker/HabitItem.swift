//
//  HabitItem.swift
//  HabitTracker
//
//  Created by Julian Saxl on 2023-07-18.
//

import Foundation

struct HabitItem: Identifiable, Codable, Equatable {
    let id = UUID()
    var name: String
    var description: String
    var completionCount: Int
}
