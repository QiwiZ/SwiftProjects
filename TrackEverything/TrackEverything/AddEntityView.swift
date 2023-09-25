//
//  AddEntityView.swift
//  TrackEverything
//
//  Created by Julian Saxl on 2023-09-11.
//

import SwiftUI

struct AddEntityView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var creator = ""
    @State private var title = ""
    @State var entityType: String
    @State private var releaseYear = ""
    @State private var genre = ""
    @State private var finished = false
    @State private var rating = Int16(3)
    
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
                    let entity = MediaEntity(context: moc)
                    entity.id = UUID()
                    entity.creator = creator
                    entity.title = title
                    entity.type = entityType
                    entity.year = Int16(releaseYear)!
                    entity.genre = genre
                    entity.finished = finished
                    entity.favourite = false
                    if finished {
                        entity.rating = Int16(rating)
                    } else {
                        entity.rating = 0
                    }
                    
                    if moc.hasChanges {
                        try? moc.save()
                        dismiss()
                    }
                }
                .disabled(!isValidEntry())
            }
        }
        .navigationTitle("Track new entry")
        .background(.darkBackground)
        .scrollContentBackground(.hidden)
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

struct AddEntityView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntityView(entityType: "Movie")
    }
}
