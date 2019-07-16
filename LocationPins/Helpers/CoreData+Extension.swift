//
//  CoreData+Extension.swift
//  LocationPins
//
//  Created by Kirill Garetov on 7/15/19.
//  Copyright © 2019 ios. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
  
  class func contextForTests() -> NSManagedObjectContext {
    // Get the model
    let model = NSManagedObjectModel.mergedModel(from: Bundle.allBundles)!
    
    // Create and configure the coordinator
    let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
    try! coordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
    
    // Setup the context
    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.persistentStoreCoordinator = coordinator
    return context
  }
  
}
