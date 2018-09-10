//
//  UIView+Autolayout.swift
//  FidorBank-iOS
//
//  Created by Barbera Cordoba, Rafael on 20/12/16.
//  Copyright © 2016 GFT. All rights reserved.
//

import UIKit


extension UIImageView {
    static let passportIdentWidth = CGFloat(44)
    static let passportIdentHeight = CGFloat(30)
}

extension UIView {
    public func fit(to toView: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        NSLayoutConstraint.activate([
            leftAnchor.constraint(equalTo: toView.leftAnchor, constant: insets.left),
            rightAnchor.constraint(equalTo: toView.rightAnchor, constant: -insets.right),
            topAnchor.constraint(equalTo: toView.topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: toView.bottomAnchor, constant: -insets.bottom)
        ])
    }

    public func fit(toTop: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        NSLayoutConstraint.activate([
            leftAnchor.constraint(equalTo: toTop.leftAnchor, constant: insets.left),
            rightAnchor.constraint(equalTo: toTop.rightAnchor, constant: -insets.right),
            topAnchor.constraint(equalTo: toTop.topAnchor, constant: insets.top)
            ])
    }

    public func fit(toBottom: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        NSLayoutConstraint.activate([
            leftAnchor.constraint(equalTo: toBottom.leftAnchor, constant: insets.left),
            rightAnchor.constraint(equalTo: toBottom.rightAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: toBottom.bottomAnchor, constant: -insets.bottom)
            ])
    }

    public func fit(toLeft: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        NSLayoutConstraint.activate([
            leftAnchor.constraint(equalTo: toLeft.leftAnchor, constant: insets.left),
            topAnchor.constraint(equalTo: toLeft.topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: toLeft.bottomAnchor, constant: -insets.bottom)
            ])
    }

    public func fit(toRight: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        NSLayoutConstraint.activate([
            rightAnchor.constraint(equalTo: toRight.rightAnchor, constant: -insets.right),
            topAnchor.constraint(equalTo: toRight.topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: toRight.bottomAnchor, constant: -insets.bottom)
            ])
    }
    
    public func fit(horizontal: UIView, below: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        NSLayoutConstraint.activate([
            leftAnchor.constraint(equalTo: horizontal.leftAnchor, constant: insets.left),
            rightAnchor.constraint(equalTo: horizontal.rightAnchor, constant: -insets.right),
            topAnchor.constraint(equalTo: below.bottomAnchor, constant: insets.top)
            ])
    }

    public func center(into: UIView) {
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: into.centerXAnchor),
            centerYAnchor.constraint(equalTo: into.centerYAnchor)
        ])
    }
}

extension UIView {

    public static func compressible(height: CGFloat, priority: UILayoutPriority = UILayoutPriority(rawValue: 999)) -> UIView {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        let height = view.heightAnchor.constraint(equalToConstant: height)
        height.priority = priority
        height.isActive = true
        view.backgroundColor = UIColor.clear
        return view
    }

    public static func column(views: [UIView], spacing: CGFloat = 10,
                              priority: UILayoutPriority = UILayoutPriority(rawValue: 999)) -> UIView {
        var arranged = [UIView]()
        var spacers = [UIView]()
        let last = views.last
        views.forEach({
            arranged.append($0)
            if $0 != last {
                let spacer = UIView.compressible(height: spacing, priority: priority)
                spacers.append(spacer)
                arranged.append(spacer)
            }
        })
        let stack = UIStackView(arrangedSubviews: arranged)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        
        if let first = spacers.first {
            for view in spacers.dropFirst() {
                view.heightAnchor.constraint(equalTo: first.heightAnchor).isActive = true
            }
        }
        
        return stack
    }
}
