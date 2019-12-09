//
//  ViewController.swift
//  Kai
//
//  Created by Matthew Sanford on 11/16/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import UIKit
import SpriteKit
import MobileCoreServices

class ViewController: UIViewController {

    var skview: SKView!
    var scene: Scene!
    var camera = SKCameraNode()
    var scaleFactor: CGFloat = 1.0
    var designTray = DesignTrayView()
    var wallEditingTray = WallEditingTray()
    static let SCALE_TO_SIZE: CGFloat = 10.0

    override func viewDidLoad() {
        super.viewDidLoad()
        skview = SKView(frame: view.bounds)
        skview.addInteraction(UIDropInteraction(delegate: self))
        scene = Scene(size: skview.frame.size)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        camera.position = CGPoint(x: 0.5, y: 0.5)

        scene.camera = camera
        scene.addChild(camera)
        scene.editingDelegate = self
        skview.presentScene(scene)
        view.addSubview(skview)
        view.addSubview(designTray)
        view.addSubview(wallEditingTray)
        setupSubviews()

        designTray.delegate = self

    }

    func setupSubviews() {
        designTray.anchor(trailing: view.safeAreaLayoutGuide.trailingAnchor,
                          centerY: view.safeAreaLayoutGuide.centerYAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -16))

        wallEditingTray.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                               centerX: view.safeAreaLayoutGuide.centerXAnchor)
        wallEditingTray.alpha = 0
        wallEditingTray.isHidden = true
        wallEditingTray.delegate = self
    }

    func createNodeFromModel(_ model: DesignTrayShapeItemModel, point: CGPoint) -> SKShapeNode? {
        let placement = scene.convertPoint(fromView: point.snapToGridLine())
        if model.name == "Circle" {
            guard let diameter = model.diameter else { return  nil}
            let circle = Circle(diameter: CGFloat(diameter) * Scene.TABLE_SCALE_FACTOR, point: placement) // Size of Circle
            return circle
        } else if model.name == "Rectangular Wall" {
            guard let length = model.length, let width = model.width else { return nil }
            let wall = RectangularWall(rect: CGRect(x: placement.x,
                                                    y: placement.y,
                                                    width: CGFloat(width) * Scene.TABLE_SCALE_FACTOR,
                                                    height: CGFloat(length) * Scene.TABLE_SCALE_FACTOR))
            return wall
        } else {
            guard let length = model.length, let width = model.width else { return nil }
            let rect = Rectangle(rect: CGRect(x: placement.x,
                                                  y: placement.y,
                                                  width: CGFloat(width) * Scene.TABLE_SCALE_FACTOR,
                                                  height: CGFloat(length) * Scene.TABLE_SCALE_FACTOR))
            return rect

        }
    }


}

extension ViewController: ShapeSelectionDelegate {
    func wallSegmentSelected(_ node: SKShapeNode) {
        UIView.animate(withDuration: 0.3) {
            self.wallEditingTray.isHidden = false
            self.wallEditingTray.alpha = 1.0
        }
    }

    func wallSegmentDeselected() {
        UIView.animate(withDuration: 0.3, animations: {
            self.wallEditingTray.alpha = 0.0
        }, completion: { done in
            self.wallEditingTray.isHidden = true
        })
    }
}

extension ViewController: WallEditingDelegate {
    func rotateWallSegment() {
        scene.rotateWallSegment()
    }

    func adjustlength(feet: Double) {
        scene.adjustlength(feet: feet)
    }
}

extension ViewController: DesignTrayDelegate {
    func addNewShapePressed() {
        let vc = NewShapeModalViewController()
        vc.delegate = self
        present(vc, animated: true)

    }
}

extension ViewController: NewShapeModalViewDelegate {
    func newShapeModalViewDelegate(add shape: DesignTrayShapeItemModel) {
        designTray.addDesignItem(shape)
    }
}

extension ViewController: UIDropInteractionDelegate {
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: DesignTrayShapeItemModel.self)
    }

    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {

        return UIDropProposal(operation: .copy)
    }

    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        for item in session.items {
            let itemProvider = item.itemProvider
            guard itemProvider.canLoadObject(ofClass: DesignTrayShapeItemModel.self)
            else {continue}

            itemProvider.loadObject(ofClass: DesignTrayShapeItemModel.self, completionHandler: { (object, error) in
                if let model = object as? DesignTrayShapeItemModel,
                    let node = self.createNodeFromModel(model, point: session.location(in: self.skview)) {

                    DispatchQueue.main.async {
                        self.scene.addNewNode(node)
                    }
                }
            })
        }
    }
}

