//
//  AddNoteView.swift
//  TrackEverything
//
//  Created by Julian Saxl on 2023-09-13.
//

import SwiftUI

struct AddNoteView: View {
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.dismiss) private var dismiss
    
    var mediaEntity: MediaEntity
    @State private var noteText = ""
    
    var body: some View {
        Form {
            TextEditor(text: $noteText)
            
            Button("Add note") {
                addNote()
            }
        }
        .background(.darkBackground)
        .scrollContentBackground(.hidden)
    }
    
    func addNote() {
        let note = Note(context: moc)
        note.mediaEntity = mediaEntity
        note.creationDate = Date.now
        note.text = noteText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if moc.hasChanges {
            try? moc.save()
        }
        dismiss()
    }
}
