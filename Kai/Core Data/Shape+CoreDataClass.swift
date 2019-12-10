//
//  Shape+CoreDataClass.swift
//  Kai
//
//  Created by Matthew Sanford on 12/10/19.
//  Copyright © 2019 sanch. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Shape)
public class Shape: NSManagedObject {

}

protocol ShapeRepresentable {
    var shape: Shape? { get }
    func populateShape(_ shape: Shape) -> Shape
}
