//
//  Design+CoreDataProperties.swift
//  Kai
//
//  Created by Matthew Sanford on 12/10/19.
//  Copyright © 2019 sanch. All rights reserved.
//
//

import Foundation
import CoreData


extension Design {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Design> {
        return NSFetchRequest<Design>(entityName: "Design")
    }

    @NSManaged public var name: String
    @NSManaged public var lastAccessed: Date
    @NSManaged public var project: Project
    @NSManaged public var shapes: NSSet
    @NSManaged public var designItems: NSSet

}

extension Design {
    @objc(addShapesObject:)
    @NSManaged public func addToShapes(_ value: Shape)

    @objc(removeShapesObject:)
    @NSManaged public func removeFromShapes(_ value: Shape)

    @objc(addShapes:)
    @NSManaged public func addToShapes(_ values: NSSet)

    @objc(removeShapes:)
    @NSManaged public func removeFromShapes(_ values: NSSet)

    @objc(addDesignItemsObject:)
    @NSManaged public func addToDesignItems(_ value: CustomDesignItem)

    @objc(removeDesignItemsObject:)
    @NSManaged public func removeFromDesignItems(_ value: CustomDesignItem)

    @objc(addDesignItems:)
    @NSManaged public func addToDesignItems(_ values: NSSet)

    @objc(removeDesignItems:)
    @NSManaged public func removeFromDesignItems(_ values: NSSet)
}
