//
//  NewShapeModalViewController.swift
//  Kai
//
//  Created by Matthew Sanford on 12/6/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import UIKit

class NewShapeModalViewController: UIViewController {
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Add New Shape"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    var segmentControl = ShapeSelectionSegmentedControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        modalPresentationStyle = .formSheet

        view.addSubview(titleLabel)
        view.addSubview(segmentControl)

        let guide = view.safeAreaLayoutGuide
        titleLabel.anchor(top: guide.topAnchor,
                          centerX: guide.centerXAnchor,
                          padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))

        segmentControl.anchor(top: titleLabel.bottomAnchor,
                              centerX: guide.centerXAnchor,
                              padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
        segmentControl.setMinimumHeight(90)
        segmentControl.setMinimumWidth(40)
        segmentControl.add(ShapeSelectionControlItem(viewModel: .Circle))
        segmentControl.add(ShapeSelectionControlItem(viewModel: .Rectangle))
        segmentControl.add(ShapeSelectionControlItem(viewModel: .Square))



        
    }


}
