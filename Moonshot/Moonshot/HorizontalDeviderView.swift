//
//  HorizontalDeviderView.swift
//  Moonshot
//
//  Created by Julian Saxl on 2023-07-16.
//

import SwiftUI

struct HorizontalDeviderView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

struct HorizontalDeviderView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalDeviderView()
    }
}
