//
//  ShapeSelectionSegmentedControl.swift
//  Kai
//
//  Created by Matthew Sanford on 12/6/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import UIKit
protocol ShapeSelectionSegmentedControlItemDelegate: class {
    func ShapeSelectionSegmentedControlItemDelegate(selected option: ShapeSelectionControlItem)
}
protocol ShapeSelectionSegmentedControlDelegate: class {
    func shapeSelectionSegmentedControlDelegate(selected option: ShapeSelection)
}

class ShapeSelectionSegmentedControl: UIView {
    private var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.alignment = .bottom
        return view
    }()

    weak var delegate: ShapeSelectionSegmentedControlDelegate?
    var setDefaultSelection = false
    var selected: ShapeSelection?
    init() {
        super.init(frame: .zero)

        addSubview(stackView)
        stackView.anchorToParentsSafeAreaEdges()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Shape Options
    var options: Set<ShapeSelectionControlItem> = []

    func add(_ option: ShapeSelectionControlItem) {
        options.insert(option)
        stackView.addArrangedSubview(option)
        option.delegate = self

        if !setDefaultSelection {
            option.showSelection()
            selected = option.shapeSelection
            setDefaultSelection.toggle()
        }
    }
}

extension ShapeSelectionSegmentedControl: ShapeSelectionSegmentedControlItemDelegate {
    func ShapeSelectionSegmentedControlItemDelegate(selected option: ShapeSelectionControlItem) {
        option.showSelection()
        options.filter({$0 != option }).forEach({ $0.hideSelection() })
        selected = option.shapeSelection
        delegate?.shapeSelectionSegmentedControlDelegate(selected: option.shapeSelection)
    }


}
