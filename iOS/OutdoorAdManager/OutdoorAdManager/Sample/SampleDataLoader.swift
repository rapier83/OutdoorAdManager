//
//  SampleDataLoader.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/11/25.
//

// 📄 SampleDataLoader.swift

import Foundation

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
}
