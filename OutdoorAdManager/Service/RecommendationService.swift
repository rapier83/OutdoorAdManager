//
//  Recommendation.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/19/25.
//
import Foundation

class RecommendationService {
    static let shared = RecommendationService()
    private init() {}

    func fetchRecommendations(siteId: Int, completion: @escaping (Result<[Recommendation], Error>) -> Void) {
        guard let url = URL(string: "http://localhost:8080/recommend") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "잘못된 URL"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["siteId": siteId]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                let statusError = NSError(
                    domain: "", code: httpResponse.statusCode,
                    userInfo: [NSLocalizedDescriptionKey: "서버 응답 코드: \(httpResponse.statusCode)"]
                )
                completion(.failure(statusError))
                return
            }

            guard let data = data, !data.isEmpty else {
                let noDataError = NSError(
                    domain: "", code: 0,
                    userInfo: [NSLocalizedDescriptionKey: "서버에서 데이터를 받지 못했습니다."]
                )
                completion(.failure(noDataError))
                return
            }

            do {
                let decoded = try JSONDecoder().decode([Recommendation].self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
