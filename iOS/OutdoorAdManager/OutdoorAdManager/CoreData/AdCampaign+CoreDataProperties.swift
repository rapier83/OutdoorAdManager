//
//  AdCampaign+CoreDataProperties.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/15/25.
//
//

import Foundation
import CoreData


extension AdCampaign {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AdCampaign> {
        return NSFetchRequest<AdCampaign>(entityName: "AdCampaign")
    }

    @NSManaged public var agent: String?
    @NSManaged public var brand: String?
    @NSManaged public var budget: Double
    @NSManaged public var client: String?
    @NSManaged public var contentType: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var durationSecond: Int16
    @NSManaged public var endDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var mediaURL: URL?
    @NSManaged public var onAirDays: Int16
    @NSManaged public var predictedImpression: Int32
    @NSManaged public var production: String?
    @NSManaged public var socialTrendScore: Float
    @NSManaged public var startDate: Date?
    @NSManaged public var tagetKeywords: String?
    @NSManaged public var title: String?
    @NSManaged public var uploadDate: Date?
    @NSManaged public var placements: NSSet?

}

// MARK: Generated accessors for placements
extension AdCampaign {

    @objc(addPlacementsObject:)
    @NSManaged public func addToPlacements(_ value: CampaignPlacement)

    @objc(removePlacementsObject:)
    @NSManaged public func removeFromPlacements(_ value: CampaignPlacement)

    @objc(addPlacements:)
    @NSManaged public func addToPlacements(_ values: NSSet)

    @objc(removePlacements:)
    @NSManaged public func removeFromPlacements(_ values: NSSet)

}

extension AdCampaign : Identifiable {

}
