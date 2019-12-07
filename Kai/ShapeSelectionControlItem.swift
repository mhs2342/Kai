//
//  ShapeSelectionControlItem.swift
//  Kai
//
//  Created by Matthew Sanford on 12/6/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import UIKit



struct ShapeControlItemViewModel {
    var label: String
    var imageName: String
    var shape: ShapeSelection

    static var Circle = ShapeControlItemViewModel(label: "Circle", imageName: "Circle", shape: .circle)
    static var Rectangle = ShapeControlItemViewModel(label: "Rectangle", imageName: "Rectangle", shape: .rectangle)
    static var Square = ShapeControlItemViewModel(label: "Square", imageName: "Square", shape: .square)
}

class ShapeSelectionControlItem: UIView {
    weak var delegate: ShapeSelectionSegmentedControlItemDelegate?
    var shapeSelection: ShapeSelection
    private var button: CenteredButton = {
        let button = CenteredButton()
        return button
    }()

    private var label: UILabel = {
        let label = UILabel()

        return label
    }()

    fileprivate func setupViews() {
        let padding = UIEdgeInsets(top: 8, left: 16, bottom: -8, right: -16)
        button.anchor(leading: leadingAnchor,
                      top: topAnchor,
                      trailing: trailingAnchor,
                      padding: padding)
        label.anchor(leading: leadingAnchor,
                     top: button.bottomAnchor,
                     trailing: trailingAnchor,
                     bottom: bottomAnchor,
                     padding: padding)

        setMinimumHeight(100)
    }

    init(viewModel: ShapeControlItemViewModel) {
        self.shapeSelection = viewModel.shape
        super.init(frame: .zero)

        addSubview(button)
        addSubview(label)
        setupViews()
        setupView(viewModel)

        button.addTarget(self, action: #selector(wasTapped(_:)), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView(_ viewModel: ShapeControlItemViewModel) {
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.text = viewModel.label
        button.setImage(UIImage(named: viewModel.imageName), for: .normal)
        button.setTitleColor(.black, for: .normal)

        layer.borderColor = UIColor(r: 42, g: 116, b: 255).cgColor
        layer.cornerRadius = 2.0
    }

    func showSelection() {
        layer.borderWidth = 1.0
    }

    func hideSelection() {
        layer.borderWidth = 0.0
    }

    @objc private func wasTapped(_ sender: UIButton) {
        delegate?.shapeSelectionSegmentedControlDelegate(selected: self)
    }

}

class CenteredButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        centerTitleLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        centerTitleLabel()
    }

    private func centerTitleLabel() {
        self.titleLabel?.textAlignment = .center
    }
}
