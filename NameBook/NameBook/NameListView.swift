//
//  NameListView.swift
//  NameBook
//
//  Created by Julian Saxl on 2023-08-13.
//

import SwiftUI

struct NameListView: View {
    @State var names: [String]
    @State var images: [UIImage]
    
    var body: some View {
        List {
            ForEach(names, id: \.self) { name in
                Text(name)
            }
        }
    }
}
