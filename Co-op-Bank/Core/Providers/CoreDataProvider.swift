//
//  CoreDataProvider.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import Foundation
import CoreData


struct CoreDataProvider {
    static let shared = CoreDataProvider()
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "CoreDataModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("DEBUG: Error Unable initialize CoreDataProvider with error \(error.localizedDescription) ")
                fatalError("Unable initialize CoreDataProvider with error \(error.localizedDescription)")
            }
        }
    }
}

