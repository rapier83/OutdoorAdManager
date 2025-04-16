//
//  SampleDataLoader.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/11/25.
//

// 📄 SampleDataLoader.swift

import Foundation
<<<<<<< HEAD

final class SampleDataLoader {

    static func loadAllSampleData() {
        for i in 1...50 {
            let site = MediaSiteManager.shared.createMediaSite(
                buildingName: "Building \(i)",
                address: "서울시 강남구 가상로 \(i)",
                latitude: 37.5 + Double.random(in: -0.05...0.05),
                longitude: 127.0 + Double.random(in: -0.05...0.05)
            )

            let placement = AdPlacementManager.shared.createPlacement(
                location: "전광판 위치 \(i)",
                brightness: Float.random(in: 0.5...1.0),
                mediaSite: site
            )

            _ = AdvertisementManager.shared.createAdvertisement(
                title: "광고 타이틀 \(i)",
                brand: "브랜드 \(Int.random(in: 1...10))",
                mediaURL: URL(string: "https://example.com/ad\(i).mp4")!,
                budget: Double.random(in: 300_000...1_000_000),
                placements: [placement]
            )
        }
    }
=======
import CoreData
import UIKit

class SampleDataLoader {

    static let shared = SampleDataLoader()
    private init() {}

    private var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    func loadAll() {
        insertSampleMediaSites()
        insertSampleAdCampaigns()
    }

    func insertSampleMediaSites() {
        for i in 1...10 {
            let site = MediaSite(context: context)
            site.id = UUID()
            site.name = "Site \(i)"
            site.address = "City \(i) Street \(i)"
            site.latitude = 37.5 + Double(i) * 0.01
            site.longitude = 127.0 + Double(i) * 0.01
            site.owner = "Owner \(i)"
            site.populationDensity = Double.random(in: 1000...10000)
            site.uploadAt = Date()
            site.weatherForecast = "Sunny"

            for j in 1...3 {
                let screen = MediaScreen(context: context)
                screen.id = UUID()
                screen.name = "Screen \(i)-\(j)"
                screen.width = 1920
                screen.height = 1080
                screen.brightnessLevel = Float.random(in: 0.5...1.0)
                screen.status = "Active"
                screen.timeSlot = "08:00 ~ 20:00"
                screen.estimatedCost = Double.random(in: 1000...3000)
                screen.orientation = "Landscape"
                screen.uploadAt = Date()
                screen.site = site
            }
        }
        saveContext()
    }

    func insertSampleAdCampaigns() {
        for i in 1...5 {
            let campaign = AdCampaign(context: context)
            campaign.id = UUID()
            campaign.title = "Campaign \(i)"
            campaign.client = "Client \(i)"
            campaign.brand = "Brand \(i)"
            campaign.budget = Double.random(in: 50000...100000)
            campaign.startDate = Date()
            campaign.endDate = Calendar.current.date(byAdding: .day, value: 30, to: Date())
            campaign.onAirDays = 30
            campaign.descriptionText = "Ad campaign description for \(i)"
            campaign.uploadDate = Date()

            // Match with some screens
            let fetchRequest: NSFetchRequest<MediaScreen> = MediaScreen.fetchRequest()
            if let screens = try? context.fetch(fetchRequest).prefix(2) {
                for screen in screens {
                    let placement = CampaignPlacement(context: context)
                    placement.id = UUID()
                    placement.predictedImpression = Int16(Int32.random(in: 1000...5000))
                    placement.timeSlot = "08:00 ~ 20:00"
                    placement.estimatedCost = Double.random(in: 500...1500)
                    placement.location = screen.name ?? "Unknown"
                    placement.campaign = campaign
                    placement.screen = screen
                }
            }
        }
        saveContext()
    }

    func saveContext() {
        do {
            try context.save()
        } catch {
            print("❌ Failed to save context: \(error)")
        }
    }

    func resetAllData() {
        let entities = ["MediaSite", "MediaScreen", "AdCampaign", "CampaignPlacement"]
        entities.forEach { name in
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: name)
            let request = NSBatchDeleteRequest(fetchRequest: fetch)
            _ = try? context.execute(request)
        }
        saveContext()
    }
>>>>>>> ce9af146ce06abdf0e406970988b4dad0a069acd
}
