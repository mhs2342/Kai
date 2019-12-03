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

    var designTray = DesignTray()

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

        setup()
    }

    private func setup() {
        NSLayoutConstraint.activate([
            designTray.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            designTray.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }


}

