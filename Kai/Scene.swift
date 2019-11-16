//
//  Scene.swift
//  Kai
//
//  Created by Matthew Sanford on 11/16/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import SpriteKit

class Scene: SKScene {

    override init(size: CGSize) {
        super.init(size: size)
        isUserInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to: SKView) {
        if let grid = Grid(blockSize: 40.0, rows: 50, cols:50) {
            grid.position = CGPoint (x:frame.midX, y:frame.midY)
            addChild(grid)

            let gamePiece = SKSpriteNode(imageNamed: "Spaceship")
            gamePiece.setScale(0.0625)
            gamePiece.position = grid.gridPosition(row: 1, col: 0)
            grid.addChild(gamePiece)
        }
        backgroundColor = .white
    }
}
