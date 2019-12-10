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
    @NSManaged public var project: Project?

}
