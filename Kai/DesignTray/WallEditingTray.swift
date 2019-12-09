//
//  WallEditingTray.swift
//  Kai
//
//  Created by Matthew Sanford on 12/9/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import UIKit

protocol WallEditingDelegate: class {
    func rotateWallSegment()
    func adjustlength(feet: Double)
}

class WallEditingTray: UIView {
    weak var delegate: WallEditingDelegate?
    @objc var sandwichStepper: SandwichStepper!
    var observation: NSKeyValueObservation?

    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 50
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 9, leading: 76, bottom: 9, trailing: 76)
        return stackView
    }()

    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        stackView.layer.cornerRadius = 4
        stackView.clipsToBounds = true

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 8
        layer.cornerRadius = 8
        backgroundColor = .white
        setMinimumWidth(250)
        setMinimumHeight(60)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(stackView)
        stackView.anchorToParentsSafeAreaEdges()

        let wallLengthAttribute = WallEditingAttributeView()
        self.sandwichStepper = SandwichStepper()
        wallLengthAttribute.label.text = "Length"
        wallLengthAttribute.stackView.addArrangedSubview(sandwichStepper)
        stackView.addArrangedSubview(wallLengthAttribute)

        let rotateAttribute = WallEditingAttributeView()
        rotateAttribute.label.text = "Rotate"
        let rotateButton = UIButton()
        rotateButton.setImage(UIImage(named: "Rotate Button"), for: .normal)
        rotateButton.setTitle(nil, for: .normal)
        rotateButton.addTarget(self, action: #selector(rotateTapped(_:)), for: .touchUpInside)
        rotateAttribute.stackView.addArrangedSubview(rotateButton)
        stackView.addArrangedSubview(rotateAttribute)

        observation = observe(
            \.sandwichStepper.currentValue,
            options: [.old, .new]
        ) { object, change in
            self.delegate?.adjustlength(feet: change.newValue!)
        }
    }

    @objc private func rotateTapped(_ sender: UIButton) {
         delegate?.rotateWallSegment()
    }
}

class WallEditingAttributeView: UIView {
    var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()

    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        return label
    }()

    init() {
        super.init(frame: .zero)
        addSubview(stackView)
        stackView.anchorToParentsSafeAreaEdges()
        stackView.addArrangedSubview(label)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SandwichStepper: UIView {
    private var field: UITextField = {
        let field = UITextField()
        field.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        field.textColor = .black
        field.textAlignment = .center
        field.keyboardType = .decimalPad
        field.returnKeyType = .done
        return field
    }()

    private var decrementButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Decrement Button"), for: .normal)
        button.setTitle(nil, for: .normal)
        return button
    }()

    private var incrementButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Increment Button"), for: .normal)
        button.setTitle(nil, for: .normal)
        return button
    }()

    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 3.0
        return stackView
    }()

    @objc dynamic var currentValue = 1.0

    init() {
        super.init(frame: .zero)
        setup()

        decrementButton.addTarget(self, action: #selector(decrementTapped(_:)), for: .touchUpInside)
        incrementButton.addTarget(self, action: #selector(incrementTapped(_:)), for: .touchUpInside)
        field.text = "\(currentValue)'"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(stackView)
        stackView.anchorToParentsSafeAreaEdges()
        stackView.addArrangedSubview(decrementButton)
        stackView.addArrangedSubview(field)
        stackView.addArrangedSubview(incrementButton)
        field.delegate = self
    }

    @objc func incrementTapped(_ sender: UIButton) {
        guard currentValue < 40.0 else { return }
        currentValue += 0.25
        field.text = "\(currentValue)'"
    }

    @objc func decrementTapped(_ sender: UIButton) {
        guard currentValue > 1.0 else { return }
        currentValue -= 0.25
        field.text = "\(currentValue)'"
    }
}

extension SandwichStepper: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text,
            let num = Double(text) {
            textField.text?.append("'")
            currentValue = num
        } else {
            textField.text = nil
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let text = textField.text, text.count == 4, text.last == "'" {
            textField.text = String(text[text.startIndex..<text.endIndex])
        }
    }
}
