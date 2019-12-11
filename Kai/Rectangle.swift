//
//  Rectangle.swift
//  Kai
//
//  Created by Matthew Sanford on 12/8/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import SpriteKit

protocol SeatsDisplayable {
    func createSeatLabel(_ seats: Int32)
}

class Rectangle: SKShapeNode, ShapeRepresentable, SeatsDisplayable {
    var shape: Shape?

    convenience init(_ shape: Shape) throws {
        let rect = NSCoder.cgRect(for: shape.frame)
        if shape.name != "Rectangle" {
            throw ShapeError.DecodingFailure
        }
        self.init(rect: rect)
        self.shape = shape
        createSeatLabel(shape.seats)
    }

    init(rect: CGRect) {
        super.init()
        self.path = CGPath(rect: rect, transform: nil)
        self.position = CGPoint(x:self.frame.midX, y:self.frame.midY);
        strokeColor = .orange
        glowWidth = 1.0
        fillColor = SKColor.white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func populateShape(_ shape: Shape) -> Shape {
        shape.frame = NSCoder.string(for: self.frame)
        shape.name = "Rectangle"
        shape.radius = 0.0
        self.shape = shape
        return shape
    }

    func createSeatLabel(_ seats: Int32) {
        if let labelNode = childNode(withName: "Seat Label") as? SKLabelNode {
            labelNode.text = "\(seats)"
        } else {
            let labelNode = SKLabelNode(text: "\(seats)")
            labelNode.name = "Seat Label"
            labelNode.position = CGPoint(x: frame.midX, y: frame.midY)
            labelNode.fontName = "Helvetica-Bold"
            labelNode.fontSize = 20
            labelNode.fontColor = .black
            addChild(labelNode)
        }
    }
}
