//
//  CreateNewShapeViewController.swift
//  Kai
//
//  Created by Matthew Sanford on 12/3/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import UIKit

class CreateNewShapeViewController: UIViewController {
    var newShapeModal = NewShapeModal()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(newShapeModal)

        NSLayoutConstraint.activate([
            newShapeModal.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            newShapeModal.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newShapeModal.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            newShapeModal.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
