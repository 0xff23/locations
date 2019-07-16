//
//  LocationViewModel.swift
//  LocationPins
//
//  Created by Kirill Garetov on 7/15/19.
//  Copyright © 2019 ios. All rights reserved.
//

import Foundation

class LocationViewModel: NSObject {
  
  private var location: UserLocation!
  
  init(with data: UserLocation) {
    super.init()
    self.location = data
  }
  
  func getDescription() -> String {
    return location.desc
  }
  
  func getId() -> Int {
    return location.id
  }
  
  func getLat() -> Double {
    return location.latitude
  }
  
  func getLon() -> Double {
    return location.longitude
  }
  
}
