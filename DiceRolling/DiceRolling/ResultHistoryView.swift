//
//  ResultHistoryView.swift
//  DiceRolling
//
//  Created by Julian Saxl on 2023-09-05.
//

import SwiftUI

struct ResultHistoryView: View {
    @State var results: [Int]
    
    var body: some View {
        List {
            ForEach(results, id: \.self) { result in
                Text(String(result))
            }
        }
    }
}

struct ResultHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        @State var results = [1,2,3,4]
        ResultHistoryView(results: results)
    }
}
