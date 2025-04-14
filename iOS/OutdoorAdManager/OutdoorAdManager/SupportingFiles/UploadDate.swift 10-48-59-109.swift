//
//  UploadDate.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/8/25.
//

import UIKit
import CoreData

func saveAdvertisement(title: String, description: String, budget: Double) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let context = appDelegate.persistentContainer.viewContext

    let newAd = Advertisement(context: context)
    newAd.id = UUID()
    newAd.title = title
    newAd.descriptionText = description
    newAd.budget = budget
    newAd.uploadDate = Date()

    do {
        try context.save()
        print("✅ 광고 저장 성공!")
    } catch {
        print("❌ 광고 저장 실패: \(error.localizedDescription)")
    }
}
