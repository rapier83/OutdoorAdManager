//
//  AdvertisementManager.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/11/25.
//

// 📄 AdvertisementManager.swift

import CoreData

final class AdvertisementManager {

    static let shared = AdvertisementManager()
    private let context = PersistenceController.shared.context

    private init() {}

    func createAdvertisement(
        title: String,
        brand: String,
        mediaURL: URL,
        budget: Double,
        placements: [AdPlacement]
    ) -> Advertisement {
        let ad = Advertisement(context: context)
        ad.id = UUID()
        ad.title = title
        ad.brand = brand
        ad.mediaURL = mediaURL
        ad.budget = budget
        ad.uploadDate = Date()

        ad.placements = NSSet(array: placements)

        saveContext()
        return ad
    }

    func fetchAllAdvertisements() -> [Advertisement] {
        let request: NSFetchRequest<Advertisement> = Advertisement.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("❌ Fetch failed: \(error)")
            return []
        }
    }

    func delete(_ ad: Advertisement) {
        context.delete(ad)
        saveContext()
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("❌ Save error: \(error)")
        }
    }
}
