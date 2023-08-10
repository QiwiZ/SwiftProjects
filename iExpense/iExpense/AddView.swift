//
//  AddView.swift
//  iExpense
//
//  Created by Julian Saxl on 2023-07-12.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var cost = 0.0
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Cost", value: $cost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }.navigationTitle("Add new expense")
                .toolbar {
                    Button("Save") {
                        let expense = ExpenseItem(name: name, type: type, cost: cost)
                        expenses.items.append(expense)
                        dismiss()
                    }
                }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
