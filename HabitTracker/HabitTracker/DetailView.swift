//
//  DetailView.swift
//  HabitTracker
//
//  Created by Julian Saxl on 2023-07-18.
//

import SwiftUI

struct DetailView: View {
    var habit: HabitItem
    @ObservedObject var habits: Habits
    
    var body: some View {
        NavigationView {
            VStack {
                Text(habit.description)
                    .font(.headline)
                Spacer()
                Text("Completion: \(habit.completionCount)")
                    .font(.headline)
                Button("Increment") {
                    incrementHabitCompletion()
                }
                .padding(5)
                .frame(width: 500, height: 30)
                .background(.red)
                .foregroundColor(.white)
            }.navigationTitle(habit.name)
        }
    }
    
    func incrementHabitCompletion() {
        var tempHabit = habit
        tempHabit.completionCount += 1
        
        let index = habits.habits.firstIndex(of: habit)
        habits.habits[index!] = tempHabit
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(habit: HabitItem(name: "Foo", description: "This is an example description", completionCount: 0), habits: Habits())
    }
}
