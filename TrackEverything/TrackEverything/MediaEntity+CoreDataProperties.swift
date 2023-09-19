//
//  MediaEntity+CoreDataProperties.swift
//  TrackEverything
//
//  Created by Julian Saxl on 2023-09-05.
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
