//
//  CachedFriend+CoreDataProperties.swift
//  ChallengeDay60
//
//  Created by Julian Saxl on 2023-07-28.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    
    public var wrappedName: String {
        name ?? "Unknown"
    }

}

extension CachedFriend : Identifiable {

}
