//
//  DataController.swift
//  ChallengeDay60
//
//  Created by Julian Saxl on 2023-07-28.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "ChallengeDay60DataModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("There was an error loading core data: \(error.localizedDescription)")
                return
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
