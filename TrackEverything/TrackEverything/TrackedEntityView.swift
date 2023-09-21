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
    @State private var isShowingRatingAlert = false
    @State private var entityToRate = MediaEntity()
    @State private var isShowingSortingDialog = false
    
    enum SortType {
        case genre, title, ratingAsc, ratingDesc
    }
    
    @State private var sorting: SortType = .title

    private var filteredEntities: [MediaEntity] {
        var filtered: [MediaEntity]
        
        if searchText == "" {
            filtered = entities.filter {_ in true}
        } else {
            filtered = entities.filter { entity in
                entity.wrappedTitle.contains(searchText)
            }
        }
        
        switch sorting {
        case .genre:
            return filtered.sorted {
                $0.wrappedGenre < $1.wrappedGenre
            }
        case .title:
            return filtered.sorted {
                $0.wrappedTitle < $1.wrappedTitle
            }
        case .ratingAsc:
            return filtered.sorted {
                $0.rating < $1.rating
            }
        case .ratingDesc:
            return filtered.sorted {
                $0.rating > $1.rating
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
                        Text(entity.wrappedTitle)
                        Spacer()
                        if entity.finished {
                            RatingView(rating: .constant(entity.rating))
                                .allowsHitTesting(false)
                        }
                    }
                }.swipeActions {
                    if entity.finished {
                        Button {
                            entity.finished.toggle()
                            entity.rating = 0
                            if moc.hasChanges {
                                try? moc.save()
                            }
                        } label: {
                            Label("Unmark finished", systemImage: "xmark.circle")
                        }.tint(.blue)
                    } else {
                        Button {
                            entity.finished.toggle()
                            entityToRate = entity
                            isShowingRatingAlert = true
                            if moc.hasChanges {
                                try? moc.save()
                            }
                        } label: {
                            Label("Mark finished", systemImage: "checkmark.circle")
                        }.tint(.green)
                    }
                    
                    if entity.favourite {
                        Button {
                            entity.favourite.toggle()
                            if moc.hasChanges {
                                try? moc.save()
                            }
                        } label: {
                            Label("Unmark favourite", systemImage: "heart.slash.fill")
                        }.tint(.red)
                    } else {
                        Button {
                            entity.favourite.toggle()
                            if moc.hasChanges {
                                try? moc.save()
                            }
                        } label: {
                            Label("Mark favourite", systemImage: "heart.fill")
                        }.tint(.yellow)
                    }
                }
            }
        }
        .searchable(text: $searchText)
        .sheet(isPresented: $isShowingRatingAlert) {
            RatingAlertView(entityRating: $entityToRate.rating)
        }.toolbar {
            Button {
                isShowingSortingDialog = true
            } label: {
                Label("Sort", systemImage: "line.3.horizontal.decrease.circle")
            }
        }
        .confirmationDialog("", isPresented: $isShowingSortingDialog) {
            Button("Title"){ sorting = .title}
            Button("Rating Asc"){ sorting = .ratingAsc }
            Button("Rating Desc"){ sorting = .ratingDesc }
            Button("Genre"){ sorting = .genre }
        }
    }
}

struct TrackedEntityView_Previews: PreviewProvider {
    static var previews: some View {
        TrackedEntityView(entityType: "Book")
    }
}
