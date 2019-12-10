//
//  Circle.swift
//  Kai
//
//  Created by Matthew Sanford on 12/8/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import SpriteKit

enum ShapeError: Error {
    case DecodingFailure
}

class Circle: SKShapeNode, ShapeRepresentable {
    var shape: Shape?

    func populateShape(_ shape: Shape) -> Shape {
        shape.frame = NSCoder.string(for: self.calculateAccumulatedFrame())
        shape.name = "Circle"
        shape.radius = Float(self.diameter / 2)
        self.shape = shape
        return shape
    }

    private var diameter: CGFloat

    convenience init(_ shape: Shape) throws {
        let rect = NSCoder.cgRect(for: shape.frame)
        let diameter = shape.radius  * 2
        if diameter == 0 { throw ShapeError.DecodingFailure }

        self.init(diameter: CGFloat(diameter), point: rect.origin)
        self.shape = shape
    }
    
    init(diameter: CGFloat, point: CGPoint) {
        self.diameter = diameter
        super.init()
        self.path = CGPath(ellipseIn: CGRect(origin: CGPoint.zero,
                                             size: CGSize(width: diameter, height: diameter)),
                           transform: nil)
        position = point
        strokeColor = SKColor.orange
        glowWidth = 1.0
        fillColor = SKColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
