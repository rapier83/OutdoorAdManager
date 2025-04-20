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

    func fetchRecommendations(siteId: Int, completion: @escaping (Result<[Recommendation], Error>) -> Void) {
        guard let url = URL(string: "http://localhost:8080/recommendations?site_id=\(siteId)") else {
            print("❌ Invalid URL")
            completion(.failure(NSError(domain: "RecommendationService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL."])))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error fetching recommendations: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("❌ No data received")
                completion(.failure(NSError(domain: "RecommendationService", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received from server."])))
                return
            }

            do {
                let decoded = try JSONDecoder().decode([Recommendation].self, from: data)
                completion(.success(decoded))
            } catch {
                print("❌ Failed to decode recommendations: \(error)")
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
