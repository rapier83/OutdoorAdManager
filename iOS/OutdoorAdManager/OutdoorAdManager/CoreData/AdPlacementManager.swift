//
//  AdPlacementManager.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/11/25.
//

// 📄 AdPlacementManager.swift

import CoreData

final class AdPlacementManager {

    static let shared = AdPlacementManager()
    private let context = PersistenceController.shared.context

    private init() {}

    func createPlacement(
        location: String,
        brightness: Float,
        mediaSite: MediaSite
    ) -> AdPlacement {
        let placement = AdPlacement(context: context)
        placement.id = UUID()
        placement.location = location
        placement.brightnessLevel = brightness
        placement.mediaSite = mediaSite
        placement.status = "available"
        saveContext()
        return placement
    }

    func fetchPlacements(for mediaSite: MediaSite) -> [AdPlacement] {
        let request: NSFetchRequest<AdPlacement> = AdPlacement.fetchRequest()
        request.predicate = NSPredicate(format: "mediaSite == %@", mediaSite)
        do {
            return try context.fetch(request)
        } catch {
            print("❌ Placement fetch error: \(error)")
            return []
        }
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("❌ Save error: \(error)")
        }
    }
}
