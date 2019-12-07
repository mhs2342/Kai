//
//  NewShapeModalViewController.swift
//  Kai
//
//  Created by Matthew Sanford on 12/6/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import UIKit

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

    private var inputStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        modalPresentationStyle = .formSheet
        setupViews()

        segmentControl.delegate = self
    }

    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(segmentControl)
        view.addSubview(inputStackView)

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

        segmentControl.add(ShapeSelectionControlItem(viewModel: .Circle))
        segmentControl.add(ShapeSelectionControlItem(viewModel: .Rectangle))
        segmentControl.add(ShapeSelectionControlItem(viewModel: .Square))

        firstInput.update(.square("Diameter", "16'"))
        secondInput.isHidden = true
    }

}

extension NewShapeModalViewController: ShapeSelectionSegmentedControlDelegate {

    func shapeSelectionSegmentedControlDelegate(selected option: ShapeSelection) {
        switch option {
        case .circle:
            firstInput.update(.circular("16'"))
            secondInput.isHidden = true
        case .square:
            firstInput.update(.square("Width", "12'"))
            secondInput.update(.square("Length", "12'"))
            secondInput.isHidden = false

        case .rectangle:
            firstInput.update(.square("Width", "12'"))
            secondInput.update(.square("Length", "18'"))
            secondInput.isHidden = false
        }
    }


}

enum ShapeSelection  {
    case circle
    case square
    case rectangle
}
