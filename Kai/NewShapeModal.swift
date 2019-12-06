//
//  NewShapeModal.swift
//  Kai
//
//  Created by Matthew Sanford on 12/3/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import UIKit

class NewShapeModal: UIView {
    var shapeSelectionControl = ShapeSelectionControl()

    init() {
        super.init(frame: .zero)
        backgroundColor = .white

        addSubview(shapeSelectionControl)
        translatesAutoresizingMaskIntoConstraints = false
        setup()


    }

    private func setup() {
        NSLayoutConstraint.activate([
            shapeSelectionControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            shapeSelectionControl.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ShapeSelectionControlItem: UIView {
    var button: UIButton = {
        let button = UIButton()
        button.setTitle(nil, for: .normal)
        return button
    }()

    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init() {
        super.init(frame: .zero)

        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(label)

        addSubview(stackView)
        translatesAutoresizingMaskIntoConstraints = false

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func render(_ viewModel: ShapeControlItemViewModel) {
        switch viewModel {
        case .circle:
            button.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
            label.text = "Circle"
        case .rectangle:
            button.setBackgroundImage(UIImage(systemName: "rectangle"), for: .normal)
            label.text = "Rectangle"
        case .square:
            button.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
            label.text = "Square"
        }
    }

}

class ShapeSelectionControl: UIView {
    var circle = ShapeSelectionControlItem()
    var rectangle = ShapeSelectionControlItem()
    var square = ShapeSelectionControlItem()

    private var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init() {
        super.init(frame: .zero)
        circle.render(.circle)
        square.render(.square)
        rectangle.render(.rectangle)

        stackView.addArrangedSubview(circle)
        stackView.addArrangedSubview(square)
        stackView.addArrangedSubview(rectangle)

        addSubview(stackView)
        translatesAutoresizingMaskIntoConstraints = false

        setup()

    }

    private func setup() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum ShapeControlItemViewModel {
    case rectangle
    case circle
    case square
}

