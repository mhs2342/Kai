//
//  Shape+CoreDataProperties.swift
//  Kai
//
//  Created by Matthew Sanford on 12/10/19.
//  Copyright © 2019 sanch. All rights reserved.
//
//

import Foundation
import CoreData


extension Shape {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shape> {
        return NSFetchRequest<Shape>(entityName: "Shape")
    }

    @NSManaged public var frame: String
    @NSManaged public var name: String
    @NSManaged public var radius: Float
    @NSManaged public var design: Design

}
