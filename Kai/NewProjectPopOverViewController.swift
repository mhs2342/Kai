//
//  NewProjectPopOverViewController.swift
//  Kai
//
//  Created by Matthew Sanford on 12/10/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import UIKit

class NewProjectPopOverViewController: UIViewController {
    private var dataManager = ProjectDataManager.shared

    @IBOutlet var designNameLabel: UITextField!
    @IBOutlet var projectNameLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.widthAnchor.constraint(equalToConstant: 300).isActive = true
         self.view.heightAnchor.constraint(equalToConstant: 300).isActive = true

    }

    @IBAction func savePressed(_ sender: Any) {
        guard let projectName = self.projectNameLabel.text,
            let designName = self.designNameLabel.text else { return }
        dataManager.createNewProject(projectName, designName)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.preferredContentSize = self.view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
