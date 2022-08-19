//
//  AnimationUtils.swift
//  Wallet
//
//  Created by Danila on 19.08.2022.
//

import Foundation
import UIKit

public extension UIView {
    func startShakeAnimation() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.08
        animation.repeatCount = 1
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x - 6, y: center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: center.x + 6, y: center.y))
        layer.add(animation, forKey: "position")
    }
}
