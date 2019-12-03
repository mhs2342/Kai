//
//  DesignTray.swift
//  Kai
//
//  Created by Matthew Sanford on 12/2/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import UIKit

class DesignTray: UIView {
    var stackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .center
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var shapeTray: UIStackView = {
        let view = UIStackView()
        view.alignment = .center
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var newShapeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "Plus Button"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init() {
        super.init(frame: .zero)

        stackView.addArrangedSubview(shapeTray)
        stackView.addArrangedSubview(newShapeButton)

        addSubview(stackView)
        setup()
        style()

        newShapeButton.addTarget(self, action: #selector(addNewShapedTapped(_:)), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func style() {
        backgroundColor = UIColor.white
        layer.cornerRadius = 18
        translatesAutoresizingMaskIntoConstraints = false

        layer.shadowOpacity = 0.8
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 4, height: 4)
    }

    private func setup() {
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -15),

            newShapeButton.heightAnchor.constraint(equalToConstant: 35.0),
            newShapeButton.widthAnchor.constraint(equalToConstant: 35.0),

            heightAnchor.constraint(greaterThanOrEqualToConstant: 70),
            widthAnchor.constraint(greaterThanOrEqualToConstant: 70)
        ])
    }

    @objc private func addNewShapedTapped(_ sender: UIButton) {

    }
}
