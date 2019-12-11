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

class Circle: SKShapeNode, ShapeRepresentable, SeatsDisplayable {
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
        createSeatLabel(shape.seats)
    }
    
    init(diameter: CGFloat, point: CGPoint) {
        self.diameter = diameter
        super.init()
        self.path = CGPath(ellipseIn: CGRect(origin: CGPoint.zero,
                                             size: CGSize(width: diameter, height: diameter)),
                           transform: nil)
        self.position = point
        strokeColor = SKColor.orange
        glowWidth = 1.0
        fillColor = SKColor.white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createSeatLabel(_ seats: Int32) {
        if let labelNode = childNode(withName: "Seat Label") as? SKLabelNode {
            labelNode.text = "\(seats)"
        } else {
            let labelNode = SKLabelNode(text: "\(seats)")
            labelNode.name = "Seat Label"
            labelNode.position = CGPoint(x: frame.size.width/2 - (labelNode.frame.width / 2), y: frame.size.height/2 - (labelNode.frame.height / 2))
            labelNode.fontName = "Helvetica-Bold"
            labelNode.fontSize = 20
            labelNode.fontColor = .black
            addChild(labelNode)
        }
    }

}
