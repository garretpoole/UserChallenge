//
//  CachedFriend+CoreDataProperties.swift
//  UserChallenge
//
//  Created by Garret Poole on 4/12/22.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    
    var wrappedName: String {
        name ?? "Unknown"
    }

}

extension CachedFriend : Identifiable {

}
