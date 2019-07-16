//
//  Location+CoreDataProperties.swift
//  
//
//  Created by Kirill Garetov on 7/15/19.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var id: Int64
    @NSManaged public var locationDescription: String?
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double

}
