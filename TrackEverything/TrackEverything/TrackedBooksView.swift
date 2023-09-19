//
//  TrackedBooksView.swift
//  TrackEverything
//
//  Created by Julian Saxl on 2023-09-05.
//

import SwiftUI

struct TrackedEntityView: View {
    @Environment(\.managedObjectContext) var moc
    var entityType: String
    
    var body: some View {
        @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "type == %@", entityType)) var entities: FetchedResults<MediaEntity>
        
        VStack {
            List {
                ForEach(entities, id: \.id) { entity in
                    NavigationLink {
                        MediaEntityDetailView(mediaEntity: entity)
                    } label: {
                        Text(entity.wrappedTitle)
                    }
                }
            }
        }.toolbar {
            Button {
                addExampleBook()
            } label: {
                Text("Add book")
            }
        }
    }
    
    func addExampleBook() {
        let example = MediaEntity(context: moc)
        example.id = UUID()
        example.title = "Example Title"
        example.type = "Book"
        
        do {
            try moc.save()
        } catch {
            print("Error while saving \(error.localizedDescription)")
        }
    }
    
    
}

struct TrackedBooksView_Previews: PreviewProvider {
    static var previews: some View {
        TrackedBooksView()
    }
}
