//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Julian Saxl on 2023-06-29.
//

import SwiftUI

struct Headline: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
            .font(.headline)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Headline())
    }
}

struct GridStack<Content: View>: View {
    var rows: Int
    var collumns: Int
    @ViewBuilder var content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<collumns, id: \.self) { column in
                        content(row, column)
                            .titleStyle()
                    }
                }
            }
        }
    }
}


struct ContentView: View {
    var body: some View {
        GridStack(rows: 4, collumns: 4) { row, col in
                Image(systemName: "\(row * 4 + col).circle")
                Text("Row: \(row), Col: \(col)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
