//
//  DesignTrayView.swift
//  Kai
//
//  Created by Matthew Sanford on 12/6/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import UIKit

protocol DesignTrayDelegate: class {
    func addNewShapePressed()
}

class DesignTrayView: UIView {

    private var containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.spacing = UIStackView.spacingUseSystem
        view.isLayoutMarginsRelativeArrangement = true
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8)
        return view
    }()

    private var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Plus Button"), for: .normal)
        button.setTitle(nil, for: .normal)
        return button
    }()

    private var shapeStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalSpacing
        return view
    }()
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 10.0

    weak var delegate: DesignTrayDelegate?

    init() {
        super.init(frame: .zero)

        setupViews()
        setupButtonTarget()

        addDesignItem(DesignTrayShapeItemModel(name: "Rectangle", width: 25, length: 25))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(containerView)
        containerView.addArrangedSubview(shapeStackView)
        containerView.addArrangedSubview(plusButton)
        containerView.anchorToParentsSafeAreaEdges()

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 8
        layer.cornerRadius = 8
        backgroundColor = .white
        containerView.layer.cornerRadius = 8

        containerView.clipsToBounds = true
    }

    private func setupButtonTarget() {
        plusButton.addTarget(self, action: #selector(plusButtonTapped(_:)), for: .touchUpInside)
    }

    @objc private func plusButtonTapped(_ sender: UIButton) {
         delegate?.addNewShapePressed()
    }

    func addDesignItem(_ item: DesignTrayShapeItemModel) {
        UIView.animate(withDuration: 0.3) {
            self.shapeStackView.addArrangedSubview(DesignTrayShapeItem(item))
            self.layoutIfNeeded()
        }
    }

}
