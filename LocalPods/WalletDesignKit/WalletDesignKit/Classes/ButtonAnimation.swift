//
//  ButtonAnimation.swift
//  WalletDesignKit
//
//  Created by Владислава Гильде on 16.08.2022.
//

import Foundation

public struct KeyboardAnimationParameters {
    let duration: Double
    let keyboardCurve: UInt
    public let keyboardFrame: CGRect
    
    public init?(notification: NSNotification) {
        guard let durationNumber = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let keyboardCurveNumber = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
              let keyboard = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return nil}
        
        self.duration = durationNumber
        self.keyboardCurve = keyboardCurveNumber
        self.keyboardFrame = keyboard
    }
}

extension UIView {
    public static func animate(using keyboardParameters: KeyboardAnimationParameters, animations: @escaping () -> Void) {
        UIView.animate(withDuration: keyboardParameters.duration,
                       delay: 0,
                       options: UIView.AnimationOptions(rawValue: keyboardParameters.keyboardCurve),
                       animations: animations,
                       completion: nil)
    }
}
