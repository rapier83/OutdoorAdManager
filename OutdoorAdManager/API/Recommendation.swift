//
//  Recommendation.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/19/25.
//
import Foundation

struct Recommendation: Codable {
    let title: String
    let impression: Int
    let estimatedCost: Double
    let screenName: String
    let siteName: String
    let score: Double
}
