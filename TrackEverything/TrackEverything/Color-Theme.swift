//
//  Color-Theme.swift
//  TrackEverything
//
//  Created by Julian Saxl on 2023-09-23.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
    
    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
}

extension Color {
    static var yellowHighlights: Color {
        Color(red: 1, green: 0.8, blue: 0.2)
    }
    
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
    
    static var greenUiElements: Color {
        Color(red: 0.2, green: 0.45, blue: 0.29)
    }
    
    static var blueUiElements: Color {
        Color(red: 0.18, green: 0.18, blue: 0.4).opacity(0.6)
    }
}
