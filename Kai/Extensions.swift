//
//  Extensions.swift
//  Kai
//
//  Created by Matthew Sanford on 12/6/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import UIKit

extension UIView {
    func anchorToParentsSafeAreaEdges() {
        translatesAutoresizingMaskIntoConstraints = false
        if let parent = superview?.safeAreaLayoutGuide {
            NSLayoutConstraint.activate([
                trailingAnchor.constraint(equalTo: parent.trailingAnchor),
                leadingAnchor.constraint(equalTo: parent.leadingAnchor),
                topAnchor.constraint(equalTo: parent.topAnchor),
                bottomAnchor.constraint(equalTo: parent.bottomAnchor)
            ])
        }
    }

    func centerWithinParentsFrame() {
        translatesAutoresizingMaskIntoConstraints = false
        if let parent = superview?.safeAreaLayoutGuide {
            NSLayoutConstraint.activate([
                centerXAnchor.constraint(equalTo: parent.centerXAnchor),
                centerYAnchor.constraint(equalTo: parent.centerYAnchor)
            ])
        }
    }

    func setSize(_ size: CGSize) {
        setHeight(size.height)
        setWidth(size.width)
    }

    func setMinimumHeight(_ height: CGFloat) {
        heightAnchor.constraint(greaterThanOrEqualToConstant: height).isActive = true
    }

    func setMinimumWidth(_ width: CGFloat) {
        widthAnchor.constraint(greaterThanOrEqualToConstant: width).isActive = true
    }

    func setHeight(_ height: CGFloat) {
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    func setWidth(_ width: CGFloat) {
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    func anchor(leading: NSLayoutXAxisAnchor? = nil,
                top: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                centerX: NSLayoutXAxisAnchor? = nil,
                centerY: NSLayoutYAxisAnchor? = nil,
                padding: UIEdgeInsets? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding?.left ?? 0).isActive = true
        }

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding?.top ?? 0).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: padding?.bottom ?? 0).isActive = true
        }

        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: padding?.right ?? 0).isActive = true
        }

        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }

        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
}