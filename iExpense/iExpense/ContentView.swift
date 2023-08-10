//
//  ContentView.swift
//  iExpense
//
//  Created by Julian Saxl on 2023-07-11.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var expenses = Expenses()
    @State private var showingAddExpense = false

   var body: some View {
       NavigationView {
           List {
               ForEach(expenses.items) { item in
                   HStack {
                       VStack(alignment: .leading) {
                           Text(item.name).font(.headline)
                           Text(item.type)
                       }
                       Spacer()
                       Text(item.cost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                           .foregroundColor(item.cost > 10 ? item.cost > 100 ? .red : .green : .blue )
                   }.accessibilityLabel("\(item.name), \(item.cost)")
                       .accessibilityHint("\(item.type)")
               }.onDelete(perform: removeItems)
           }
           .navigationTitle("iExpense")
           .toolbar {
               Button {
                   showingAddExpense = true
               } label: {
                   Image(systemName: "plus")
               }
           }
       }.sheet(isPresented: $showingAddExpense) {
           AddView(expenses: expenses)
       }
   }
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
