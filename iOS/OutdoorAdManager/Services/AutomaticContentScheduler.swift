//
//  AutomaticContentScheduler.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/8/25.
//

import Foundation
import CoreData

class AutomaticContentScheduler {
    func analyze(ad: Advertisement, context: NSManagedObjectContext) -> [AdPlacement] {
        let placement1 = AdPlacement(context: context)
        placement1.location = "Downtown"
        placement1.timeSlot = "08:00 - 10:00"
        placement1.predictedImpressions = 5000
        placement1.estimatedCost = 1500.0

        let placement2 = AdPlacement(context: context)
        placement2.location = "Station Area"
        placement2.timeSlot = "18:00 - 20:00"
        placement2.predictedImpressions = 8000
        placement2.estimatedCost = 2000.0

        return [placement1, placement2]
    }

    func calculateTotalCost(placements: [AdPlacement]) -> Double {
        return placements.reduce(0.0) { $0 + $1.estimatedCost }
    }
}
