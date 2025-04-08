//
//  AutomaaticMediaLinker.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/8/25.
//

import Foundation

class AutomaticMediaLinker {
    func optimizePlacement(for ad: Advertisement, on sites: [MediaSite]) -> [AdPlacement] {
        var recommendations: [AdPlacement] = []
        for site in sites {
            if site.socialTrendScore > 0.5, site.populationDensity > 1000 {
                let timeSlot = site.availableSlots.randomElement() ?? "12:00 - 14:00"
                let estimatedCost = Double.random(in: 1000...3000)
                let impressions = Int(site.populationDensity * site.socialTrendScore)
                recommendations.append(
                    AdPlacement(
                        location: site.region,
                        timeSlot: timeSlot,
                        predictedImpressions: impressions,
                        estimatedCost: estimatedCost
                    )
                )
            }
        }
        return recommendations.sorted { $0.predictedImpressions > $1.predictedImpressions }
    }

    func estimateRevenue(from placements: [AdPlacement]) -> Double {
        return placements.reduce(0) { $0 + $1.estimatedCost * 0.8 }
    }
}
