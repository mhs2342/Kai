//
//  SaveButton.swift
//  Kai
//
//  Created by Matthew Sanford on 12/7/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import UIKit

class SaveButton: UIButton {
    private var insets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)

    init() {
        super.init(frame: .zero)
        contentEdgeInsets = insets
        backgroundColor = UIColor(r: 42, g: 116, b: 255)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel?.textColor = .white
        setTitle("Save", for: .normal)
        layer.cornerRadius = 2
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
