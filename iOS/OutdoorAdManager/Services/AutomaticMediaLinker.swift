//
//  AutomaaticMediaLinker.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/8/25.
//

import Foundation
import CoreData

class AutomaticMediaLinker {
    func optimizePlacement(for ad: Advertisement, on sites: [MediaSite], context: NSManagedObjectContext) -> [AdPlacement] {
        var recommendations: [AdPlacement] = []

        for site in sites {
            if site.socialTrendScore > 0.5, site.populationDensity > 1000 {
                let slots = (site.availableSlots ?? "").components(separatedBy: ",")
                let timeSlot = slots.randomElement() ?? "12:00 - 14:00"
                let estimatedCost = Double.random(in: 1000...3000)
                let impressions = Int(site.populationDensity * site.socialTrendScore)

                let placement = AdPlacement(context: context)
                placement.location = site.region
                placement.timeSlot = timeSlot
                placement.predictedImpressions = Int32(impressions)
                placement.estimatedCost = estimatedCost

                recommendations.append(placement)
            }
        }

        return recommendations.sorted { ($0.predictedImpressions) > ($1.predictedImpressions) }
    }

    func estimateRevenue(from placements: [AdPlacement]) -> Double {
        return placements.reduce(0.0) { $0 + $1.estimatedCost * 0.8 }
    }
}
