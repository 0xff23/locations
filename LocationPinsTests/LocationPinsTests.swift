//
//  LocationPinsTests.swift
//  LocationPinsTests
//
//  Created by Kirill Garetov on 7/15/19.
//  Copyright © 2019 ios. All rights reserved.
//

import XCTest
import Foundation
import CoreData

@testable import LocationPins

class LocationPinsTests: XCTestCase {
  
  private var context: NSManagedObjectContext?
  
  override func setUp() {
    self.context = NSManagedObjectContext.contextForTests()
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testAddLocation() {
    let entity = NSEntityDescription.entity(forEntityName: "Location", in: context!)
    let newLocation = NSManagedObject(entity: entity!, insertInto: context)

    newLocation.setValue(1, forKey: "id")
    newLocation.setValue("Home", forKey: "locationDescription")
    newLocation.setValue(-34.000, forKey: "lat")
    newLocation.setValue(23.000, forKey: "lon")
    
    do {
      try context!.save()
    } catch {
      print("Failed saving")
    }
  }
  
  func testRetriveLocation() {
    // Add new location into memory
    let entity = NSEntityDescription.entity(forEntityName: "Location", in: context!)
    let newLocation = NSManagedObject(entity: entity!, insertInto: context)

    newLocation.setValue(1, forKey: "id")
    newLocation.setValue("Home", forKey: "locationDescription")
    newLocation.setValue(-34.000, forKey: "lat")
    newLocation.setValue(23.000, forKey: "lon")

    do {
      try context!.save()
    } catch {
      print("Failed saving")
    }
    
    //Retrive location
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
    request.returnsObjectsAsFaults = false
    do {
      let result = try context!.fetch(request)
      XCTAssert(result.count > 0, "Location records not found")
      for data in result as! [NSManagedObject] {
        XCTAssertNotNil(data.value(forKey: "locationDescription"))
        XCTAssertNotNil(data.value(forKey: "id"))
        XCTAssertNotNil(data.value(forKey: "lat"))
        XCTAssertNotNil(data.value(forKey: "lon"))
      }
    } catch {
      //XCTestError(_nsError: NSError(domain: "Unable to retrive location record from coredata", code: 1, userInfo: nil))
    }
  }
  
  func testGetLocationDataFromServer() {
    let result = DataManager.shared.getLocationsData()
    let location = result[0]
    
    XCTAssertNotNil(location)
    XCTAssert(!result.isEmpty, "Empty data")
    XCTAssert(location.desc != "", "No description presented")
    
    XCTAssertNotNil(location.latitude)
    XCTAssertNotNil(location.longitude)
    XCTAssertNotNil(location.id)
  }
  
}
