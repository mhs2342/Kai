//
//  ViewController.swift
//  Kai
//
//  Created by Matthew Sanford on 11/16/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    var skview: SKView!
    var scene: Scene!
    var camera = SKCameraNode()
    var scaleFactor: CGFloat = 1.0
    var designTray = DesignTrayView()

    override func viewDidLoad() {
        super.viewDidLoad()
        skview = SKView(frame: view.bounds)
        scene = Scene(size: skview.frame.size)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        camera.position = CGPoint(x: 0.5, y: 0.5)

        scene.camera = camera
        scene.addChild(camera)
        skview.presentScene(scene)

        view.addSubview(skview)

        view.addSubview(designTray)
        setupSubviews()

    }

    func setupSubviews() {
        designTray.anchor(trailing: view.safeAreaLayoutGuide.trailingAnchor,
                          centerY: view.safeAreaLayoutGuide.centerYAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -16))
    }


}

