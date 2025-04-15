//
//  CampaignPlacement+CoreDataProperties.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/15/25.
//
//

import Foundation
import CoreData


extension CampaignPlacement {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CampaignPlacement> {
        return NSFetchRequest<CampaignPlacement>(entityName: "CampaignPlacement")
    }

    @NSManaged public var estimatedCost: Double
    @NSManaged public var id: UUID?
    @NSManaged public var location: String?
    @NSManaged public var predictedImpression: Int16
    @NSManaged public var timeSlot: String?
    @NSManaged public var campaign: AdCampaign?
    @NSManaged public var screen: MediaScreen?

}

extension CampaignPlacement : Identifiable {

}
