//
//  AddView.swift
//  HabitTracker
//
//  Created by Julian Saxl on 2023-07-18.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var habits: Habits
    @State private var habitName = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $habitName)
                TextField("Description", text: $description)
            }.navigationTitle("Add a new Habit")
                .toolbar {
                    Button("Save") {
                        saveHabit()
                    }
                }
        }
    }
    
    func saveHabit() {
        let habit = HabitItem(name: habitName, description: description, completionCount: 0)
        habits.habits.insert(habit, at: 0)
        dismiss()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habits: Habits())
    }
}
