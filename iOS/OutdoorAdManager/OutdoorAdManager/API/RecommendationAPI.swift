//
//  Recommendation.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/19/25.
//


// RecommendationAPI.swift
// OutdoorAdManager

import Foundation

class RecommendationService {
    static let shared = RecommendationService()
    private init() {}

    func fetchRecommendations(siteId: Int, completion: @escaping ([Recommendation]) -> Void) {
        guard let url = URL(string: "http://localhost:8080/recommendations?site_id=\(siteId)") else {
            print("❌ Invalid URL")
            completion([])
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error fetching recommendations: \(error.localizedDescription)")
                completion([])
                return
            }

            guard let data = data else {
                print("❌ No data received")
                completion([])
                return
            }

            do {
                let decoded = try JSONDecoder().decode([Recommendation].self, from: data)
                completion(decoded)
            } catch {
                print("❌ Failed to decode recommendations: \(error)")
                completion([])
            }
        }

        task.resume()
    }
}
