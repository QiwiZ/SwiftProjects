//
//  Habit.swift
//  HabitTracker
//
//  Created by Julian Saxl on 2023-07-18.
//

import Foundation

class Habits: ObservableObject {
    @Published var habits = [HabitItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(habits) {
                UserDefaults.standard.set(encoded, forKey: "habits")
            }
        }
    }
    
    init() {
        if let savedHabits = UserDefaults.standard.data(forKey: "habits") {
            if let decoded = try? JSONDecoder().decode([HabitItem].self, from: savedHabits) {
                habits = decoded
                return
            }
        }
        habits = []
    }
}
