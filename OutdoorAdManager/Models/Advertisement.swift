//
//  Advertisement.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/8/25.
//

import Foundation

// MARK: - Model

struct Advertisement {
    let id: UUID
    let title: String
    let description: String
    let mediaURL: URL
    let targetKeywords: [String]
    let budget: Double
    let durationInDays: Int
    let uploadDate: Date

    init(id: UUID = UUID(),
         title: String,
         description: String,
         mediaURL: URL,
         targetKeywords: [String],
         budget: Double,
         durationInDays: Int,
         uploadDate: Date = Date()) {
        self.id = id
        self.title = title
        self.description = description
        self.mediaURL = mediaURL
        self.targetKeywords = targetKeywords
        self.budget = budget
        self.durationInDays = durationInDays
        self.uploadDate = uploadDate
    }
}
