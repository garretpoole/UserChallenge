//
//  DataController.swift
//  UserChallenge
//
//  Created by Garret Poole on 4/12/22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    //tells to use our Bookworm data model for its container
    //dont contain data just the model of the data
    let container = NSPersistentContainer(name: "UserChallenge")
    //loads data from model
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
                return
            }
            //merge objects based on their properties
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
