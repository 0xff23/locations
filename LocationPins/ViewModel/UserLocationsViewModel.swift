//
//  UserLocationsViewModel.swift
//  LocationPins
//
//  Created by Kirill Garetov on 7/15/19.
//  Copyright © 2019 ios. All rights reserved.
//

import Foundation


class UserLocationsViewModel: NSObject {

  private var locations: [UserLocation]?
  private var dataManager = DataManager.shared
  
  init(with: String?) {
    super.init()
    self.locations = dataManager.getLocationsData()
  }
  
  func userLocations() -> [UserLocation] {
    return locations!
  }
  
  
}










