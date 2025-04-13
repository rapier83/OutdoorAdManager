//
//  PersistenceController.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/11/25.
//

// 📄 PersistenceController.swift

import CoreData

final class PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "OutdoorAdManager") // .xcdatamodeld 이름!

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        container.viewContext
    }
}
