//
//  MediaSite.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/8/25.
//

import Foundation

// MARK: - Model

struct MediaSite {
    let id: UUID
    let region: String
    let populationDensity: Double
    let weatherForecast: String
    let socialTrendScore: Double
    let availableSlots: [String]
}
