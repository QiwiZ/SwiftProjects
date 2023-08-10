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
    @NSManaged public var cachedUsers: NSSet?

    public var wrappedName: String {
        name ?? "Unknown"
    }
    
}

// MARK: Generated accessors for cachedUsers
extension CachedFriend {

    @objc(addCachedUsersObject:)
    @NSManaged public func addToCachedUsers(_ value: CachedUser)

    @objc(removeCachedUsersObject:)
    @NSManaged public func removeFromCachedUsers(_ value: CachedUser)

    @objc(addCachedUsers:)
    @NSManaged public func addToCachedUsers(_ values: NSSet)

    @objc(removeCachedUsers:)
    @NSManaged public func removeFromCachedUsers(_ values: NSSet)

}

extension CachedFriend : Identifiable {

}
