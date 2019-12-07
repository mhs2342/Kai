//
//  ModalShapeInputview.swift
//  Kai
//
//  Created by Matthew Sanford on 12/6/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import UIKit

enum ModalShapeInputViewMode {
    case circular(String)
    case square(String, String)
}

class ModalShapeInputView: UIView {
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .black
        return label
    }()

    let textField: ModalShapeInputTextField = {
        let field = ModalShapeInputTextField()
        field.placeholder = "16'"
        field.clearButtonMode = .whileEditing
        return field
    }()

    private var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.isLayoutMarginsRelativeArrangement = true
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        view.spacing = UIStackView.spacingUseSystem
        return view
    }()

    init() {
        super.init(frame: .zero)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func update(_ mode: ModalShapeInputViewMode) {
        switch mode {
        case .circular(let placeholder):
            label.text = "Diameter"
            textField.placeholder = placeholder
        case .square(let dimension, let placeholder):
            label.text = dimension
            textField.placeholder = placeholder
        }
    }

    private func setupViews() {
        addSubview(stackView)
        stackView.anchorToParentsSafeAreaEdges()

        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)
    }

}

class ModalShapeInputTextField: UITextField {

}
