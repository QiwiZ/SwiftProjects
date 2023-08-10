//
//  ContentView.swift
//  HabitTracker
//
//  Created by Julian Saxl on 2023-07-18.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var habits = Habits()
    @State private var isAddingHabit = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.habits) { habit in
                    NavigationLink(habit.name) {
                        DetailView(habit: habit, habits: habits)
                    }
                }.onDelete(perform: removeItems)
            }.toolbar {
                Button {
                    isAddingHabit.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }.navigationTitle("iHabit")
                .sheet(isPresented: $isAddingHabit) {
                    AddView(habits: habits)
                }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        habits.habits.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
