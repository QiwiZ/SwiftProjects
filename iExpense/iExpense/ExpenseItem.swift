//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Julian Saxl on 2023-07-12.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let cost: Double
}
