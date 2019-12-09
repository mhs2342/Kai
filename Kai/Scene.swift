//
//  Scene.swift
//  Kai
//
//  Created by Matthew Sanford on 11/16/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import SpriteKit

class Scene: SKScene {

    static let BLOCK_SIZE: CGFloat = 40.0
    static let TABLE_SCALE_FACTOR: CGFloat = BLOCK_SIZE
    private var movingNode: SKNode?
    override init(size: CGSize) {
        super.init(size: size)
        isUserInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to: SKView) {
        if let grid = Grid(blockSize: Scene.BLOCK_SIZE, rows: 50, cols: 50) {
            grid.position = CGPoint (x:frame.midX, y:frame.midY)
            addChild(grid)
        }
        backgroundColor = .white

        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotateGestureRecognized))
        to.addGestureRecognizer(rotateGesture)

        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized(_:)))
        to.addGestureRecognizer(longPressGesture)
    }

    @objc func longPressGestureRecognized(_ gestureRecognizer: UILongPressGestureRecognizer) {
        guard let view = gestureRecognizer.view else { return }
        if gestureRecognizer.state == .began {
            deleteNodeAt(point: gestureRecognizer.location(in: view))
        }
    }

    @objc func rotateGestureRecognized(_ gestureRecognizer: UIRotationGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }

        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            applyRotationForViewAtLocation(point: gestureRecognizer.location(in: gestureRecognizer.view!),
                                           rotation: gestureRecognizer.rotation)
           gestureRecognizer.rotation = 0
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)

            let touchedNodes = self.nodes(at: location)
            for node in touchedNodes.reversed() {
                if node is SKShapeNode {
                    self.movingNode = node
                }
            }
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let node = movingNode {
            checkforIntersections(node)
        }

        self.movingNode = nil
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let node = movingNode {
            checkforIntersections(node)
        }
        self.movingNode = nil
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = self.movingNode {
            let touchLocation = touch.location(in: self)
            node.position = touchLocation.snapToGridLine()
        }
    }

    fileprivate func checkforIntersections(_ node: SKNode) {
        let filtered = children.filter({ $0 != node })
        for existing in filtered where existing is SKShapeNode {
            guard let existing = existing as? SKShapeNode,
            let node = node as? SKShapeNode else {
                continue
            }

            if existing.intersects(node) {
                node.strokeColor = .red
                existing.strokeColor = .red
            } else {
                node.strokeColor = .orange
                existing.strokeColor = .orange
            }
        }
    }

    func applyRotationForViewAtLocation(point: CGPoint, rotation: CGFloat) {
        let sceneLocation = convertPoint(fromView: point)
        if let node = nodes(at: sceneLocation).first {
            let action = SKAction.rotate(byAngle: rotation, duration: 0.1)
            node.run(action)
        }
    }

    func deleteNodeAt(point: CGPoint) {
        let sceneLocation = convertPoint(fromView: point)
        if let node = nodes(at: sceneLocation).first {
            node.removeFromParent()
        }
    }

    func addNewNode(_ node: SKShapeNode) {
        checkforIntersections(node)
        addChild(node)
    }
}
