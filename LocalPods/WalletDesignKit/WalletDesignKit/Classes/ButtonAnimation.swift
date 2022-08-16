//
//  ButtonAnimation.swift
//  WalletDesignKit
//
//  Created by Владислава Гильде on 16.08.2022.
//

import Foundation

public func buttonAnimation(notification: NSNotification, animation: @escaping (_ duration: Double, _ keyboardCurve: UInt, _ keyboard: CGRect) -> Void) {
    if
        let durationNumber = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
        let keyboardCurveNumber = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber,
        let keyboard = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
    {
        
        let duration = durationNumber.doubleValue
        let keyboardCurve = keyboardCurveNumber.uintValue
        
        animation(duration, keyboardCurve, keyboard)
    }
}
