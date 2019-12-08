//
//  NewShapeModalViewController.swift
//  Kai
//
//  Created by Matthew Sanford on 12/6/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import UIKit

protocol NewShapeModalViewDelegate: class {
    func newShapeModalViewDelegate(add shape: DesignTrayShapeItemModel)
}

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

    var firstInput = ModalShapeInputView()
    var secondInput = ModalShapeInputView()
    var saveButton = SaveButton()
    weak var delegate: NewShapeModalViewDelegate?

    private var inputStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        modalPresentationStyle = .popover
        setupViews()

        segmentControl.delegate = self
    }

    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(segmentControl)
        view.addSubview(inputStackView)
        view.addSubview(saveButton)

        inputStackView.addArrangedSubview(firstInput)
        inputStackView.addArrangedSubview(secondInput)

        let guide = view.safeAreaLayoutGuide
        titleLabel.anchor(top: guide.topAnchor,
                          centerX: guide.centerXAnchor,
                          padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))

        segmentControl.anchor(top: titleLabel.bottomAnchor,
                              centerX: guide.centerXAnchor,
                              padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))

        inputStackView.anchor(leading: view.safeAreaLayoutGuide.leadingAnchor,
                     top: segmentControl.bottomAnchor,
                     trailing: view.safeAreaLayoutGuide.trailingAnchor)
        saveButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          centerX: view.safeAreaLayoutGuide.centerXAnchor,
                          padding: UIEdgeInsets(top: 0, left: 0, bottom: -16, right: 0))

        segmentControl.add(ShapeSelectionControlItem(viewModel: .Circle))
        segmentControl.add(ShapeSelectionControlItem(viewModel: .Rectangle))
        segmentControl.add(ShapeSelectionControlItem(viewModel: .Square))

        firstInput.update(.square("Diameter (ft)", "16'"))
        secondInput.isHidden = true

        saveButton.addTarget(self, action: #selector(saveShape(_:)), for: .touchUpInside)
    }

    @objc private func saveShape(_ sender: UIButton) {
        switch segmentControl.selected! {
        case .circle:
            guard let text = firstInput.textField.text, let diameter = Double(text) else { return }
            let model = DesignTrayShapeItemModel(name: "Circle", diameter: diameter)
            delegate?.newShapeModalViewDelegate(add: model)
        default:
            guard let t1 = firstInput.textField.text,
                let t2 = secondInput.textField.text,
                let width = Double(t1),
                let length = Double(t2) else { return }
            let model = DesignTrayShapeItemModel(name: segmentControl.selected!.rawValue, width: width, length: length)
            delegate?.newShapeModalViewDelegate(add: model)
        }

        dismiss(animated: true)

    }

}

extension NewShapeModalViewController: ShapeSelectionSegmentedControlDelegate {

    func shapeSelectionSegmentedControlDelegate(selected option: ShapeSelection) {
        switch option {
        case .circle:
            firstInput.update(.circular("16'"))
            secondInput.isHidden = true
        case .square:
            firstInput.update(.square("Width (ft)", "12'"))
            secondInput.update(.square("Length (ft)", "12'"))
            secondInput.isHidden = false

        case .rectangle:
            firstInput.update(.square("Width (ft)", "12'"))
            secondInput.update(.square("Length (ft)", "18'"))
            secondInput.isHidden = false
        }
    }


}

enum ShapeSelection: String  {
    case circle = "Circle"
    case square = "Square"
    case rectangle = "Rectangle"
}
