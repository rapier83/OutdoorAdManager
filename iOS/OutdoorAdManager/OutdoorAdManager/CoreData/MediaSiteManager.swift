//
//  MediaSiteManager.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/11/25.
//

// 📄 MediaSiteManager.swift

import CoreData

final class MediaSiteManager {

    static let shared = MediaSiteManager()
    private let context = PersistenceController.shared.context

    private init() {}

    func createMediaSite(
        buildingName: String,
        address: String,
        latitude: Double,
        longitude: Double
    ) -> MediaSite {
        let site = MediaSite(context: context)
        site.id = UUID()
        site.buildingName = buildingName
        site.address = address
        site.latitude = latitude
        site.longitude = longitude
        site.uploadAt = Date()
        saveContext()
        return site
    }

    func fetchAllSites() -> [MediaSite] {
        let request: NSFetchRequest<MediaSite> = MediaSite.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("❌ MediaSite fetch failed: \(error)")
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
