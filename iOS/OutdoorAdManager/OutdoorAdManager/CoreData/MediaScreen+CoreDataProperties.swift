//
//  MediaScreen+CoreDataProperties.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/15/25.
//
//

import Foundation
import CoreData


extension MediaScreen {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MediaScreen> {
        return NSFetchRequest<MediaScreen>(entityName: "MediaScreen")
    }

    @NSManaged public var brightnessLevel: Float
    @NSManaged public var estimatedCost: Double
    @NSManaged public var height: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var location: String?
    @NSManaged public var status: String?
    @NSManaged public var timeSlot: String?
    @NSManaged public var width: Int16
    @NSManaged public var placements: NSSet?
    @NSManaged public var site: MediaSite?

}

// MARK: Generated accessors for placements
extension MediaScreen {

    @objc(addPlacementsObject:)
    @NSManaged public func addToPlacements(_ value: CampaignPlacement)

    @objc(removePlacementsObject:)
    @NSManaged public func removeFromPlacements(_ value: CampaignPlacement)

    @objc(addPlacements:)
    @NSManaged public func addToPlacements(_ values: NSSet)

    @objc(removePlacements:)
    @NSManaged public func removeFromPlacements(_ values: NSSet)

}

extension MediaScreen : Identifiable {

}
