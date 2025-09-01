//
//  PersistenceController.swift
//  InboxKit
//
//  Created by User on 30/08/25.
//


import CoreData

@MainActor
public final class PersistenceController {
    public static let shared = PersistenceController()

    public let container: NSPersistentContainer

    private init() {
        guard let modelURL = Bundle.module.url(forResource: "InboxModel", withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to load Core Data model from package")
        }

        container = NSPersistentContainer(name: "InboxModel", managedObjectModel: model)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

    }

    public var context: NSManagedObjectContext {
        container.viewContext
    }
}


