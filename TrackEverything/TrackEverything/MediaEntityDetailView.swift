//
//  MediaEntityDetailView.swift
//  TrackEverything
//
//  Created by Julian Saxl on 2023-09-05.
//

import SwiftUI

struct MediaEntityDetailView: View {
    @Environment(\.managedObjectContext) var moc
    var mediaEntity: MediaEntity
    
    @FetchRequest private var entity: FetchedResults<MediaEntity> //needed so that notes will reload immediately after adding them
    @State private var isAddingNote = false
    @State private var isEditingEntity = false
    
    init(mediaEntity: MediaEntity) {
        self.mediaEntity = mediaEntity
        _entity = FetchRequest<MediaEntity>(sortDescriptors: [], predicate: NSPredicate(format: "id == %@", mediaEntity.id! as CVarArg), animation: .default)
    }
    
    
    var body: some View {
        VStack {
            if mediaEntity.finished {
                RatingView(rating: .constant(mediaEntity.rating))
                    .font(.headline)
            }
            
            Text(mediaEntity.wrappedCreator)
            Text(mediaEntity.wrappedGenre)
            
            List {
                ForEach(mediaEntity.notesArray) { note in
                    Text(note.wrappedText)
                }.onDelete(perform: deleteNote)
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
        .sheet(isPresented: $isEditingEntity) {
            EditEntityView(mediaEntity)
        }
        .toolbar {
            Button {
                isEditingEntity = true
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            
            Button {
                moc.delete(mediaEntity)
                
                if moc.hasChanges {
                    try? moc.save()
                }
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
    
    func deleteNote(at offsets: IndexSet) {
        for index in offsets {
            let entity = mediaEntity.notesArray[index]
            moc.delete(entity)
            
            if moc.hasChanges {
                try? moc.save()
            }
        }
    }
}
