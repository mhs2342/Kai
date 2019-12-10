//
//  Scene.swift
//  Kai
//
//  Created by Matthew Sanford on 11/16/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import SpriteKit

protocol ShapeSelectionDelegate: class {
    func wallSegmentSelected(_ node: SKShapeNode)
    func wallSegmentDeselected()
}

class Scene: SKScene {
    var design: Design! {
        didSet {
            populateDesign()
        }
    }
    static let BLOCK_SIZE: CGFloat = 20.0
    static let TABLE_SCALE_FACTOR: CGFloat = BLOCK_SIZE / 2
    private var movingNode: SKNode?
    private var selectedNode: SKShapeNode?
    weak var editingDelegate: ShapeSelectionDelegate?

    override init(size: CGSize) {
        super.init(size: size)
        isUserInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to: SKView) {
        if let grid = Grid(blockSize: Scene.BLOCK_SIZE, rows: 80, cols: 80) {
            grid.position = CGPoint (x:frame.midX, y:frame.midY)
            insertChild(grid, at: 0)
        }
        backgroundColor = .white

        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotateGestureRecognized))
        to.addGestureRecognizer(rotateGesture)

        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized(_:)))
        to.addGestureRecognizer(longPressGesture)

        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureRecognized(_:)))
        to.addGestureRecognizer(pinchGesture)
    }

    @objc func pinchGestureRecognized(_ gestureRecognizer: UIPinchGestureRecognizer) {
        if let wall = self.selectedNode {
            if gestureRecognizer.state == .ended {
                let currentScale: CGFloat = 0.3
                var newScale = currentScale * gestureRecognizer.scale
                if newScale < 1 {
                    newScale = 1
                }
                if newScale > 6 {
                    newScale = 6
                }
                let scaleAction = SKAction.scaleX(by: newScale, y: 1, duration: 0.1)
                wall.run(scaleAction)
            }


        }

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
                if node is Wall {
                    self.selectedNode = node as? SKShapeNode
                    self.movingNode = node
                    self.editingDelegate?.wallSegmentSelected(selectedNode!)
                } else if node is SKShapeNode {
                    self.movingNode = node
                    self.editingDelegate?.wallSegmentDeselected()
                } else {
                    self.editingDelegate?.wallSegmentDeselected()
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
            if let representable = node as? ShapeRepresentable,
                let shape = representable.shape {
                shape.frame = NSCoder.string(for: node.calculateAccumulatedFrame())
                ProjectDataManager.shared.updateShape(design, shape)
            }
        }
    }

    fileprivate func checkforIntersections(_ node: SKNode) {
        let filtered = children.filter({ $0 != node })
        for existing in filtered where existing is SKShapeNode {
            guard let existing = existing as? SKShapeNode,
            let node = node as? SKShapeNode,
            (!(node is RectangularWall) && !(existing is RectangularWall) )else {
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
        guard let selectedNode = self.selectedNode,
            !(selectedNode is Grid) else {
            return
        }
        let action = SKAction.rotate(byAngle: rotation, duration: 0.1)
        let centerOfRotation = convertPoint(fromView: point)
        selectedNode.position = centerOfRotation
        selectedNode.run(action)
    }

    func deleteNodeAt(point: CGPoint) {
        let sceneLocation = convertPoint(fromView: point)
        if let node = nodes(at: sceneLocation).first, !(node is Grid) {
            node.removeFromParent()
            if let representable = node as? ShapeRepresentable, let shape = representable.shape {
                ProjectDataManager.shared.removeShapeFromDesign(shape, design)
            }
        }
        
    }

    func addNewNode(_ node: SKShapeNode) {
        checkforIntersections(node)
        if let representable = node as? ShapeRepresentable {
            var shape = ProjectDataManager.shared.createNewShape()
            shape = representable.populateShape(shape)
            ProjectDataManager.shared.addShapeToDesign(shape, design: design)
        }

        if node is RectangularWall {
            insertChild(node, at: 1)
        } else {
            addChild(node)
        }

    }

    func populateDesign() {
        if let shapes = design.shapes as? Set<Shape> {
            for shape in shapes {
                if let circle = try? Circle(shape) {
                    scene?.addChild(circle)
                } else if let wall = try? RectangularWall(shape) {
                    scene?.addChild(wall)
                } else if let rectangle = try? Rectangle(shape) {
                    scene?.addChild(rectangle)
                }

            }
        }
    }
}

extension Scene: WallEditingDelegate {
    func rotateWallSegment() {
        if let selected = selectedNode, selected is Wall {
            let action = SKAction.rotate(byAngle: CGFloat.pi / 4, duration: 0.2)
            selected.run(action)
        }
    }

    func adjustlength(feet: Double) {
        if var selected = selectedNode as? Wall {
            let newLength = (CGFloat(feet) * Scene.TABLE_SCALE_FACTOR).nearestMultiple(Scene.BLOCK_SIZE / 4)
            if selected.length - newLength == selected.previousLength {
                selected.removeFromParent()
                selected = Wall(start: selected.position, length: selected.length - newLength)
                self.selectedNode = selected
                scene?.addChild(selected)
            } else {
                selected.length += CGFloat(feet) * Scene.TABLE_SCALE_FACTOR
            }
//            selectedNode?.removeFromParent()
//            scene?.addChild(self.selectedNode!)

        }
    }
}
