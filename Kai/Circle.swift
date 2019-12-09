//
//  Circle.swift
//  Kai
//
//  Created by Matthew Sanford on 12/8/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import SpriteKit

class Circle: SKShapeNode {
    
    init(diameter: CGFloat, point: CGPoint) {
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
