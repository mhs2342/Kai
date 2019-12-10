//
//  ProjectSectionHeaderView.swift
//  Kai
//
//  Created by Matthew Sanford on 12/9/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import UIKit

protocol ProjectSectionHeaderViewDelegate: class {
    func newDesignButtonWasPressed(_ projectName: String)
}

class ProjectSectionHeaderView: UICollectionReusableView {

    @IBOutlet var newDesignButton: UIButton!
    @IBOutlet var projectNameLabel: UILabel!

    weak var delegate: ProjectSectionHeaderViewDelegate?

    @IBAction func newDesignTapped(_ sender: UIButton) {
        delegate?.newDesignButtonWasPressed(projectNameLabel.text!)
    }
}
