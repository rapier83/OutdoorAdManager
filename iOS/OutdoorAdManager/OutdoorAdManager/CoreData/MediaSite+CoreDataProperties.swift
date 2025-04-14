//
//  MediaSite+CoreDataProperties.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/15/25.
//
//

import Foundation
import CoreData


extension MediaSite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MediaSite> {
        return NSFetchRequest<MediaSite>(entityName: "MediaSite")
    }

    @NSManaged public var address: String?
    @NSManaged public var mediaSiteName: String?
    @NSManaged public var circumferenceType: String?
    @NSManaged public var id: UUID?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var numberOfPanel: Int16
    @NSManaged public var owner: String?
    @NSManaged public var populationDensity: Double
    @NSManaged public var uploadAt: Date?
    @NSManaged public var weatherForecast: String?
    @NSManaged public var screens: NSSet?

}

// MARK: Generated accessors for screens
extension MediaSite {

    @objc(addScreensObject:)
    @NSManaged public func addToScreens(_ value: MediaScreen)

    @objc(removeScreensObject:)
    @NSManaged public func removeFromScreens(_ value: MediaScreen)

    @objc(addScreens:)
    @NSManaged public func addToScreens(_ values: NSSet)

    @objc(removeScreens:)
    @NSManaged public func removeFromScreens(_ values: NSSet)

}

extension MediaSite : Identifiable {

}
