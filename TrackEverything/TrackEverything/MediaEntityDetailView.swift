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
    @State private var isDeleting = false
    
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
                .foregroundColor(.secondary)
            Text(mediaEntity.wrappedGenre)
                .foregroundColor(.secondary)
            
            List {
                ForEach(mediaEntity.notesArray) { note in
                    Text(note.wrappedText)
                        .listRowBackground(Color.darkBackground)
                        .listRowSeparatorTint(.yellowHighlights)
                        .foregroundColor(.white)
                }
                .onDelete(perform: deleteNote)
            }
            .listStyle(.plain)
            .background(.darkBackground)
            
            Button("Add a note") {
                isAddingNote = true
            }
            
        }
        .background(.darkBackground)
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
                isDeleting = true
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
        .alert("Are you sure you want to delete \(mediaEntity.wrappedTitle)?", isPresented: $isDeleting) {
            Button("Delete") {
                moc.delete(mediaEntity)
                
                if moc.hasChanges {
                    try? moc.save()
                }
            }
            Button("Cancel") {
                isDeleting = false
            }
        } message: {
            Text("This cannot be undone.")
        }
    }
    
    func deleteNote(at offsets: IndexSet) {
        for index in offsets {
            let note = mediaEntity.notesArray[index]
            moc.delete(note)
            
            if moc.hasChanges {
                try? moc.save()
            }
        }
    }
}
