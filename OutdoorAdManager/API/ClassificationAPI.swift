//
//  ClassificationAPI.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/14/25.
//
// 📄 API/ClassificationAPI.swift

import Foundation

enum ClassificationAPI {
    static func classify(pixels: [Int], completion: @escaping (ClassificationResult?) -> Void) {
        guard let url = URL(string: "http://localhost:8080/classify") else {
            print("URL 생성 실패")
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONEncoder().encode(pixels)
            request.httpBody = jsonData
        } catch {
            print("JSON 인코딩 실패: \(error)")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("요청 실패: \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("응답 없음")
                completion(nil)
                return
            }

            do {
                let result = try JSONDecoder().decode(ClassificationResult.self, from: data)
                completion(result)
            } catch {
                print("JSON 디코딩 실패: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
