//
//  Rectangle.swift
//  Kai
//
//  Created by Matthew Sanford on 12/8/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import SpriteKit

class Rectangle: SKShapeNode, ShapeRepresentable {
    var shape: Shape?

    convenience init(_ shape: Shape) throws {
        let rect = NSCoder.cgRect(for: shape.frame)
        if shape.name != "Rectangle" {
            throw ShapeError.DecodingFailure
        }
        self.init(rect: rect)
        self.shape = shape
    }

    init(rect: CGRect) {
        super.init()
        self.path = CGPath(rect: rect, transform: nil)
        strokeColor = .orange
        glowWidth = 1.0
        fillColor = SKColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func populateShape(_ shape: Shape) -> Shape {
        shape.frame = NSCoder.string(for: self.calculateAccumulatedFrame())
        shape.name = "Rectangle"
        shape.radius = 0.0
        self.shape = shape
        return shape
    }
}
