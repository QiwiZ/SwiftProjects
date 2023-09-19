//
//  MediaEntityDetailView.swift
//  TrackEverything
//
//  Created by Julian Saxl on 2023-09-05.
//

import SwiftUI

struct MediaEntityDetailView: View {
    var mediaEntity: MediaEntity
    
    @FetchRequest private var entity: FetchedResults<MediaEntity>
    @State private var isAddingNote = false
    
    init(mediaEntity: MediaEntity) {
        self.mediaEntity = mediaEntity
        _entity = FetchRequest<MediaEntity>(sortDescriptors: [], predicate: NSPredicate(format: "id == %@", mediaEntity.id! as CVarArg), animation: .default)
    }
    
    
    var body: some View {
        VStack {
            RatingView(rating: .constant(Int(mediaEntity.rating)))
                .font(.headline)
            
            Text(mediaEntity.wrappedCreator)
            Text(mediaEntity.wrappedGenre)
            
            List {
                ForEach(mediaEntity.notesArray) { note in
                    Text(note.wrappedText)
                }
            }
            
            Button("Add a note") {
                isAddingNote = true
            }
            
        }
        .navigationTitle(mediaEntity.wrappedTitle)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isAddingNote) {
            AddNoteView(mediaEntity: entity[0])
        }
    }
}
