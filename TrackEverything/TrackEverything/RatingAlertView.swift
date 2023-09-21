//
//  RatingAlertView.swift
//  TrackEverything
//
//  Created by Julian Saxl on 2023-09-20.
//

import SwiftUI

struct RatingAlertView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @Binding var entityRating: Int16
    
    var body: some View {
        VStack {
            Text("Rate your experience")
                .padding(.horizontal)
                .font(.headline)
            
            RatingView(rating: $entityRating)
                .padding(.horizontal)
                .font(.largeTitle)
            
            Button("Done") {
                if moc.hasChanges {
                    try? moc.save()
                }
                dismiss()
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
    }
}
