//
//  EditEntityView.swift
//  TrackEverything
//
//  Created by Julian Saxl on 2023-09-19.
//

import SwiftUI

struct EditEntityView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    private var mediaEntity: MediaEntity
    @State private var creator: String
    @State private var title: String
    @State private var entityType: String
    @State private var releaseYear: String
    @State private var genre: String
    @State private var finished: Bool
    @State private var rating: Int16
    
    init(_ mediaEntity: MediaEntity) {
        self.mediaEntity = mediaEntity
        _creator = State(initialValue: mediaEntity.wrappedCreator)
        _title = State(initialValue: mediaEntity.wrappedTitle)
        _entityType = State(initialValue: mediaEntity.wrappedType)
        _releaseYear = State(initialValue: String(mediaEntity.year))
        _genre = State(initialValue: mediaEntity.wrappedGenre)
        _finished = State(initialValue: mediaEntity.finished)
        _rating = State(initialValue: mediaEntity.rating)
    }
    
    var body: some View {
        
        Form {
            TextField("Creator", text: $creator)
            TextField("Title", text: $title)
            TextField("Release year", text: $releaseYear)
            TextField("Genre", text: $genre)
            Picker("Type", selection: $entityType) {
                ForEach(entityTypes, id: \.self) {
                    Text($0)
                }
            }
            
            Section {
                Toggle("Finished the \(entityType)?", isOn: $finished)
                if finished {
                    RatingView(rating: $rating)
                }
            }
            
            Section {
                Button("Save") {
                    mediaEntity.creator = creator
                    mediaEntity.title = title
                    mediaEntity.type = entityType
                    mediaEntity.year = Int16(releaseYear)!
                    mediaEntity.genre = genre
                    mediaEntity.finished = finished
                    if finished {
                        mediaEntity.rating = Int16(rating)
                    } else {
                        mediaEntity.rating = 0
                    }
                    
                    if moc.hasChanges {
                        try? moc.save()
                        dismiss()
                    }
                }.disabled(!isValidEntry())
            }
        }
        .navigationTitle("Track new entry")
    }
    
    func isValidCreator() -> Bool {
        !creator.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func isValidTitle() -> Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func isValidYear() -> Bool {
        !(Int16(releaseYear) == nil)
    }
    
    func isValidEntry() -> Bool {
         return isValidCreator() && isValidTitle() && isValidYear()
    }
}
