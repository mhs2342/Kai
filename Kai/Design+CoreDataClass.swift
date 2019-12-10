//
//  Design+CoreDataClass.swift
//  Kai
//
//  Created by Matthew Sanford on 12/10/19.
//  Copyright © 2019 sanch. All rights reserved.
//
//

import Foundation
import CoreData

extension CodingUserInfoKey {
   static let context = CodingUserInfoKey(rawValue: "context")
}

@objc(Design)
public class Design: NSManagedObject {
    var lastAccessedAsString: String {
        lastAccessed.getElapsedInterval()
    }
}
