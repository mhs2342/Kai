//
//  AddSeatsViewController.swift
//  Kai
//
//  Created by Matthew Sanford on 12/10/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import SpriteKit
import UIKit

protocol AddSeatsViewControllerDelegate: class {
    func add(seats: Int)
}

class AddSeatsViewController: UIViewController {

    private var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.spacing = 8
        return view
    }()

    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.text = "Add Seats"
        label.textAlignment = .center
        return label
    }()

    var currentAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.text = "1"
        label.textAlignment = .center
        return label
    }()

    lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 1
        stepper.maximumValue = 10
        stepper.stepValue = 1.0
        stepper.value = 1.0
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        return stepper
    }()

    weak var delegate: AddSeatsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        stackView.anchorToParentsSafeAreaEdges(UIEdgeInsets(top: 8, left: 8, bottom: -8, right: -8))
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(currentAmountLabel)
        stackView.addArrangedSubview(stepper)

//        view.translatesAutoresizingMaskIntoConstraints = false
//        self.view.widthAnchor.constraint(equalToConstant: 250).isActive = true
//        self.view.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }

    @objc func stepperValueChanged(_ sender: UIStepper) {
        currentAmountLabel.text = "\(Int(sender.value))"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.preferredContentSize = self.view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.add(seats: Int(stepper.value))
    }
}
