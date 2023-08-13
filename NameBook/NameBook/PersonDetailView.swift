//
//  PersonDetailView.swift
//  NameBook
//
//  Created by Julian Saxl on 2023-08-13.
//

import SwiftUI

struct PersonDetailView: View {
    var image: Image
    var name: String
    
    var body: some View {
        VStack {
            image
                .resizable()
                .scaledToFit()
            
            Text(name)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        
    }
}
