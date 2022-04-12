//
//  CachedUser+CoreDataProperties.swift
//  UserChallenge
//
//  Created by Garret Poole on 4/12/22.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: String?
    
    var wrappedName: String {
        name ?? "Unknown"
    }
    var wrappedCompany: String {
        company ?? "Unknown"
    }
    var wrappedEmail: String {
        email ?? "Unknown"
    }
    var wrappedAddress: String {
        address ?? "Unknown"
    }
    var wrappedAbout: String {
        about ?? "NA"
    }
    var wrappedRegistered: Date {
        registered ?? Date.now
    }
    var wrappedTags: [String]{
        tags?.components(separatedBy: ",") ?? ["NA"]
    }
    
    

}

extension CachedUser : Identifiable {

}
