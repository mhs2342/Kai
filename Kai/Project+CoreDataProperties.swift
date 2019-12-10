//
//  Project+CoreDataProperties.swift
//  Kai
//
//  Created by Matthew Sanford on 12/10/19.
//  Copyright © 2019 sanch. All rights reserved.
//
//

import Foundation
import CoreData


extension Project {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Project> {
        return NSFetchRequest<Project>(entityName: "Project")
    }

    @NSManaged public var name: String
    @NSManaged public var designs: NSSet?

}

// MARK: Generated accessors for designs
extension Project {

    @objc(addDesignsObject:)
    @NSManaged public func addToDesigns(_ value: Design)

    @objc(removeDesignsObject:)
    @NSManaged public func removeFromDesigns(_ value: Design)

    @objc(addDesigns:)
    @NSManaged public func addToDesigns(_ values: NSSet)

    @objc(removeDesigns:)
    @NSManaged public func removeFromDesigns(_ values: NSSet)

}
