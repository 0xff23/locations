//
//  LocationsData.swift
//  LocationPins
//
//  Created by Kirill Garetov on 7/15/19.
//  Copyright © 2019 ios. All rights reserved.
//

import Foundation

struct LocationsData: Codable {
  var id: Int
  var latitude: Double
  var longitude: Double
  var description: String
}
