//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Julian Saxl on 2023-07-25.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16
    
    public var wrappedTitle: String {
        title ?? "Unkown Title"
    }
    
    public var wrappedDirector: String {
        director ?? "Unkown Director"
    }

}

extension Movie : Identifiable {

}
