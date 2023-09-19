//
//  MediaEntity+CoreDataProperties.swift
//  TrackEverything
//
//  Created by Julian Saxl on 2023-09-06.
//
//

import Foundation
import CoreData


extension MediaEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MediaEntity> {
        return NSFetchRequest<MediaEntity>(entityName: "MediaEntity")
    }

    @NSManaged public var creator: String?
    @NSManaged public var title: String?
    @NSManaged public var rating: Int16
    @NSManaged public var genre: String?
    @NSManaged public var id: UUID?
    @NSManaged public var type: String?
    @NSManaged public var year: Int16
    @NSManaged public var finished: Bool
    @NSManaged public var notes: NSSet?

    public var wrappedCreator: String {
        creator ?? "Unknown Creator"
    }
    
    public var wrappedTitle: String {
        title ?? "Unknown Title"
    }
    
    public var wrappedGenre: String {
        genre ?? "Unknown Genre"
    }
    
    public var wrappedType: String {
        type ?? "Unknown Type"
    }
    
    public var notesArray: [Note] {
        let set = notes as? Set<Note> ?? []
        return set.sorted {
            $0.wrappedCreationDate > $1.wrappedCreationDate
        }
    }
    
}

// MARK: Generated accessors for notes
extension MediaEntity {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: Note)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: Note)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}

extension MediaEntity : Identifiable {

}
