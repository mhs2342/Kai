//
//  Extensions.swift
//  Kai
//
//  Created by Matthew Sanford on 12/6/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import UIKit

extension Date {
    func getElapsedInterval() -> String {

        let interval = Calendar.current.dateComponents([.hour, .minute, .second], from: self, to: Date())

        if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour)" + " " + "hour ago" :
                "\(hour)" + " " + "hours ago"
        } else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute)" + " " + "minute ago" :
                "\(minute)" + " " + "minutes ago"
        } else if let second = interval.second, second < 30 {
            return "\(second)" + " " + "seconds ago"
        } else {
            return "a moment ago"

        }

    }
}

extension CGFloat {
    func nearestMultiple(_ of: CGFloat) -> CGFloat {
        var result = self + of / 2.0;
        result -= result.truncatingRemainder(dividingBy: of)
        print("\(self) -> \(result)")
        return result
    }
}

extension CGPoint {
    func snapToGridLine() -> CGPoint {
        return CGPoint(x: x.nearestMultiple(Scene.BLOCK_SIZE / 4),
                       y: y.nearestMultiple(Scene.BLOCK_SIZE / 4))
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat? = nil) {
        self.init(red: r / 255.0, green: g / 255, blue: b / 255, alpha: a ?? 1)
    }
}

extension UIView {
    func anchorToParentsSafeAreaEdges(_ padding: UIEdgeInsets? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        if let parent = superview?.safeAreaLayoutGuide {
            NSLayoutConstraint.activate([
                trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: padding?.right ?? 0),
                leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: padding?.left ?? 0),
                topAnchor.constraint(equalTo: parent.topAnchor, constant: padding?.top ?? 0),
                bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: padding?.bottom ?? 0)
            ])
        }
    }

    func centerWithin(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                centerXAnchor.constraint(equalTo: view.centerXAnchor),
                centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
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
