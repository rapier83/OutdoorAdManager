//
//  SampleDataLoader.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/11/25.
//

// 📄 SampleDataLoader.swift

import Foundation
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

            let screenCount = Int.random(in: 1...5)
            for j in 1...screenCount {
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
        // 모든 스크린을 가져와서 랜덤하게 섞음
        let screenFetch: NSFetchRequest<MediaScreen> = MediaScreen.fetchRequest()
        guard let allScreens = try? context.fetch(screenFetch).shuffled() else { return }

        // 캠페인 5개 기준, 각 캠페인에 2개씩 나눠 배분
        let screensPerCampaign = stride(from: 0, to: min(10, allScreens.count), by: 2).map {
            Array(allScreens[$0..<$0+2])
        }

        for i in 1...screensPerCampaign.count {
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

            let screens = screensPerCampaign[i - 1]

            for screen in screens {
                let placement = CampaignPlacement(context: context)
                placement.id = UUID()
                placement.predictedImpression = Int16(Int32.random(in: 1000...5000))
                placement.timeSlot = "08:00 ~ 20:00"
                placement.estimatedCost = Double.random(in: 500...1500)
                placement.location = screen.name ?? "Unknown"
                placement.campaign = campaign
                placement.screen = screen

                campaign.addToPlacements(placement)
                screen.addToPlacements(placement)

                print("🔗 캠페인 '\(campaign.title ?? "")' → 스크린 '\(screen.name ?? "")' (Site: \(screen.site?.name ?? "-"))")
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
        context.reset() // ✅ 캐시, registered object, undo 등 초기화
        saveContext()
    }

    func debugCampaignMapping() {
        let fetchRequest: NSFetchRequest<CampaignPlacement> = CampaignPlacement.fetchRequest()
        if let placements = try? context.fetch(fetchRequest) {
            for placement in placements {
                print("🧩 Campaign: \(placement.campaign?.title ?? "-") ↔ Screen: \(placement.screen?.name ?? "-") ↔ Site: \(placement.screen?.site?.name ?? "-")")
            }
        } else {
            print("❌ Failed to fetch CampaignPlacement")
        }
    }
}
