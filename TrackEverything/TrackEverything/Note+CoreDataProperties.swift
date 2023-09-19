//
//  Note+CoreDataProperties.swift
//  TrackEverything
//
//  Created by Julian Saxl on 2023-09-13.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var text: String?
    @NSManaged public var mediaEntity: MediaEntity?

    public var wrappedCreationDate: Date {
        creationDate ?? Date.now
    }
    
    public var wrappedText: String {
        text ?? ""
    }
}

extension Note : Identifiable {

}
