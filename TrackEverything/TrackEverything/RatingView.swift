//
//  RatingView.swift
//  TrackEverything
//
//  Created by Julian Saxl on 2023-08-28.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int16
    
    var label = ""
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            
            ForEach(1..<maximumRating+1, id:\.self) { number in
                    image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = Int16(number)
                    }
                    .accessibilityElement()
                    .accessibilityLabel(label)
                    .accessibilityValue(rating == 1 ? "1 star" : "\(number) stars")
                    .accessibilityAdjustableAction { direction in
                        switch direction {
                        case .increment:
                            if rating < maximumRating { rating += 1}
                        case .decrement:
                            if rating > 1 { rating -= 1}
                        default:
                            break
                        }
                    }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
