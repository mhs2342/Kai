//
//  CustomDesignItem+CoreDataProperties.swift
//  Kai
//
//  Created by Matthew Sanford on 12/10/19.
//  Copyright © 2019 sanch. All rights reserved.
//
//

import Foundation
import CoreData


extension CustomDesignItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CustomDesignItem> {
        return NSFetchRequest<CustomDesignItem>(entityName: "CustomDesignItem")
    }

    @NSManaged public var name: String
    @NSManaged public var length: Double
    @NSManaged public var width: Double
    @NSManaged public var diameter: Double
    @NSManaged public var design: Design

}
