//
//  Wall.swift
//  Kai
//
//  Created by Matthew Sanford on 12/9/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import SpriteKit

class Wall: SKShapeNode {
    var previousLength: CGFloat = 0.0
    var length: CGFloat {
        willSet{
            self.previousLength = length
        }
        didSet {
            let path = CGMutablePath()
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: self.length, y: 0.0))
            self.path = path
        }
    }
    
    init(start: CGPoint, length: CGFloat) {
        self.length = length
        super.init()
        position = CGPoint(x: start.x, y: start.y)
        let path = CGMutablePath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: self.length, y: 0.0))
        self.path = path
        strokeColor = .black
        lineWidth = 10.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


class RectangularWall: Rectangle {
    convenience init(_ shape: Shape) throws {
        let rect = NSCoder.cgRect(for: shape.frame)
        if shape.name != "Rectangular Wall" {
            throw ShapeError.DecodingFailure
        }
        self.init(rect: rect)
        self.shape = shape
    }
    override init(rect: CGRect) {
        super.init(rect: rect)

        strokeColor = .black
        lineWidth = 4.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func populateShape(_ shape: Shape) -> Shape {
        let shape = super.populateShape(shape)
        shape.name = "Rectangular Wall"
        self.shape = shape
        return shape
    }
}
