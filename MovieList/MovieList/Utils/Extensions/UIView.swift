//
//  UIView.swift
//  TaskDemo
//
//  Created by Devansh Vyas on 31/12/20.
//

import UIKit

extension UIView {

    ///To add line to view:-
    enum LinePosition {
        case top
        case bottom
    }

    ///To add line to view (Method)
    func addLineToView(position: LinePosition, color: UIColor, width: Double = 1.0) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        self.addSubview(lineView)
        let metrics = ["width": NSNumber(value: width)]
        let views = ["lineView": lineView]
        let options = NSLayoutConstraint.FormatOptions(rawValue: 0)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|",
                                                           options: options,
                                                           metrics: metrics,
                                                           views: views))
        switch position {
        case .top:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]",
                                                               options: options,
                                                               metrics: metrics,
                                                               views: views))
        case .bottom:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|",
                                                               options: options,
                                                               metrics: metrics,
                                                               views: views))
        }
    }

    /// to add rounded corner with default value
    func addCornerRadius(value: CGFloat = 6.0) {
        layer.cornerRadius = value
    }

    /// to add rounded corner with side and radius
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        DispatchQueue.main.async {
            let cgSize = CGSize(width: radius, height: radius)
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: cgSize)
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }

    /// to add shadow
    func addShadow(shadowOffSet: CGSize = CGSize(width: 5, height: 5), radius: CGFloat = 10) {
        layer.masksToBounds = false
        layer.shadowOffset = shadowOffSet
        layer.shadowRadius = radius
        layer.shadowOpacity = 0.2
        layer.shadowColor = UIColor.gray.cgColor
    }

    /// to add border
    func addBorder(width: CGFloat = 1, color: UIColor = #colorLiteral(red: 0.9098039216, green: 0.9215686275, blue: 0.9254901961, alpha: 1)) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }

}
