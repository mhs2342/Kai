//
//  DesignTrayShapeItem.swift
//  Kai
//
//  Created by Matthew Sanford on 12/8/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import UIKit

struct DesignTrayShapeItemModel {
    var name: String
    var width: Double?
    var length: Double?
    var diameter: Double?

    init(name: String, width: Double? = nil, length: Double? = nil, diameter: Double? = nil) {
        self.name = name
        self.width = width
        self.length = length
        self.diameter = diameter
    }
}

class DesignTrayShapeItem: UIView {
    private var image: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    private var dimensionsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(r: 255, g: 83, b: 0)
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private var shapeNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(r: 255, g: 83, b: 0)
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    init(_ model: DesignTrayShapeItemModel) {
        super.init(frame: .zero)
        setup()
        displayModel(model)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(image)
        addSubview(dimensionsLabel)
        addSubview(shapeNameLabel)
        image.anchor(leading: safeAreaLayoutGuide.leadingAnchor, top: safeAreaLayoutGuide.topAnchor, trailing: safeAreaLayoutGuide.trailingAnchor)
        dimensionsLabel.centerWithin(image)
        shapeNameLabel.anchor(leading: safeAreaLayoutGuide.leadingAnchor,
                              top: image.bottomAnchor,
                              trailing: safeAreaLayoutGuide.trailingAnchor,
                              bottom: safeAreaLayoutGuide.bottomAnchor,
                              padding: UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0))
    }

    private func displayModel(_ model: DesignTrayShapeItemModel) {
        if let w = model.width, let l = model.length {
            dimensionsLabel.text = "\(w)'\nx\n\(l)'"
        } else if let d = model.diameter {
            dimensionsLabel.text = "\(d)'"
        }
        shapeNameLabel.text = model.name
        image.image = UIImage(named: "Design Tray \(model.name)")
    }
}
