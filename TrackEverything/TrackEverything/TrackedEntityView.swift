//
//  TrackedBooksView.swift
//  TrackEverything
//
//  Created by Julian Saxl on 2023-09-05.
//

import SwiftUI

struct TrackedEntityView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest var entities: FetchedResults<MediaEntity>
    @State private var searchText = ""

    private var filteredEntities: [MediaEntity] {
        if searchText == "" {
            return entities.filter {_ in true}
        } else {
            return entities.filter { entity in
                entity.wrappedTitle.contains(searchText)
            }
        }
    }
    
    init(entityType: String) {
        _entities = FetchRequest<MediaEntity>(sortDescriptors: [], predicate: NSPredicate(format: "type == %@", entityType), animation: .default)
    }
    
    var body: some View {
        List {
            ForEach(filteredEntities, id: \.id) { entity in
                NavigationLink {
                    MediaEntityDetailView(mediaEntity: entity)
                } label: {
                    HStack {
                        Text(String(entity.rating))
                            .font(.largeTitle)
                        Text(entity.wrappedTitle)
                    }
                }
            }.onDelete(perform: deleteEntity)
        }.searchable(text: $searchText)
    }
    
    func deleteEntity(at offsets: IndexSet) {
        for index in offsets {
            let entity = entities[index]
            moc.delete(entity)
            
            if moc.hasChanges {
                try? moc.save()
            }
        }
    }
}

struct TrackedEntityView_Previews: PreviewProvider {
    static var previews: some View {
        TrackedEntityView(entityType: "Book")
    }
}
