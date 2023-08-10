//
//  ContentView.swift
//  WeSplit
//
//  Created by Julian Saxl on 2023-06-26.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var users = 2
    @State private var tipPercentage = 0
    @FocusState private var amountIsFocused: Bool
    let tipPercentages = [0, 10, 15, 18, 20]
    let currencyFormatter: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
    
    var totalAmount: Double {
        let tipAmount = checkAmount / 100 * Double(tipPercentage)
        return checkAmount + tipAmount
    }
    
    var totalPerPerson: Double {
        let numberOfUsers = Double(users + 2)
        let tipAmount = checkAmount / 100 * Double(tipPercentage)
        
        return (checkAmount + tipAmount) / numberOfUsers
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $users) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much of a tip do you want to leave?")
                }
                Section {
                    Text(totalPerPerson, format: currencyFormatter)
                } header: {
                    Text("Amount per person")
                }
                Section {
                    Text(totalAmount, format: currencyFormatter).foregroundColor(tipPercentage == 0 ? .red : .none)
                } header: {
                    Text("Total amount")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
