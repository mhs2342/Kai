//
//  ProjectCollectionViewCell.swift
//  Kai
//
//  Created by Matthew Sanford on 12/9/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import UIKit

class ProjectCollectionViewCell: UICollectionViewCell {
    @IBOutlet var designNameLabel: UILabel!
    @IBOutlet var lastOpenedLabel: UILabel!
    @IBOutlet var containerView: UIView!


    override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = 10.0
        clipsToBounds = true

    }
}
