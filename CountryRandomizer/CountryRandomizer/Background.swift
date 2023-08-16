//
//  Background.swift
//  CountryRandomizer
//
//  Created by Julian Saxl on 2023-08-15.
//

import SwiftUI

struct Background: View {
    var body: some View {
        RadialGradient(stops: [
            .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
            .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
        ], center: .top, startRadius: 200, endRadius: 400 )
            .ignoresSafeArea()
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background()
    }
}
