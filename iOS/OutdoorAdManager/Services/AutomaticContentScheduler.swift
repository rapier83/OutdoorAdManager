//
//  AutomaticContentScheduler.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/8/25.
//

import Foundation

class AutomaticContentScheduler {
    func analyze(ad: Advertisement) -> [AdPlacement] {
        let placements = [
            AdPlacement(location: "Downtown", timeSlot: "08:00 - 10:00", predictedImpressions: 5000, estimatedCost: 1500.0),
            AdPlacement(location: "Station Area", timeSlot: "18:00 - 20:00", predictedImpressions: 8000, estimatedCost: 2000.0)
        ]
        return placements
    }

    func calculateTotalCost(placements: [AdPlacement]) -> Double {
        return placements.reduce(0) { $0 + $1.estimatedCost }
    }
}
