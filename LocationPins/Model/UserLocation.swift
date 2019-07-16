//
//  UserLocation.swift
//  LocationPins
//
//  Created by Kirill Garetov on 7/15/19.
//  Copyright © 2019 ios. All rights reserved.
//

import Foundation

class UserLocation: NSObject {
  
  var id: Int
  var latitude: Double
  var longitude: Double
  var desc: String
  
  init(id: Int, lat: Double, lon: Double, desc: String) {
    self.id = id
    self.latitude = lat
    self.longitude = lon
    self.desc = desc
  }
  
  init(wihh location: LocationsData) {
    self.id = location.id
    self.desc = location.description
    self.latitude = location.latitude
    self.longitude = location.longitude
  }
}
