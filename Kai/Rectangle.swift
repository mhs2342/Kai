//
//  Rectangle.swift
//  Kai
//
//  Created by Matthew Sanford on 12/8/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import SpriteKit

class Rectangle: SKShapeNode {
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
}
