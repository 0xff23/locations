//
//  DataManager.swift
//  LocationPins
//
//  Created by Kirill Garetov on 7/15/19.
//  Copyright © 2019 ios. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
  
  static let shared = DataManager()
  
  private init() {}
  
  func getLocationsData() -> [UserLocation] {
    let fileUrl = URL(string: "https://annetog.gotenna.com/development/scripts/get_map_pins.php")
    let locations = [UserLocation]()
    if let fileUrl = fileUrl {
      do {
        let decoder = JSONDecoder()
        let jsonData = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
        let model = try decoder.decode([LocationsData].self, from:
          jsonData)
        addLocationsToCoreData(model)
        return createLocationList(from: model)
      } catch {
        print("\(error) Unable to read contents of the file url")
      }
    }
    return locations
  }
  
  func addLocationsToCoreData(_ locations: [LocationsData]) {
    for location in locations {
      if !CoreDataStack.isLocationExist(id: location.id) {
        let entity = NSEntityDescription.entity(forEntityName: "Location", in: CoreDataStack.getContext())
        let newLocation = NSManagedObject(entity: entity!, insertInto: CoreDataStack.getContext())
        // Set the data to the entity
        newLocation.setValue(location.description, forKey: "locationDescription")
        newLocation.setValue(location.longitude, forKey: "lon")
        newLocation.setValue(location.latitude, forKey: "lat")
        newLocation.setValue(location.id, forKey: "id")
        CoreDataStack.shared.saveContext()
      }
    }
    
  }

  private func createLocationList(from data: [LocationsData]) -> [UserLocation] {
    var locations = [UserLocation]()
    
    for location in data {
      locations.append(UserLocation.init(wihh: location))
    }
    return locations
  }
  
}
