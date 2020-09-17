//
//  Extension.swift
//  VocabularyEnglish
//
//  Created by Cata on 8/14/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

extension UIButton {
    func tapAnimation() {
        let tap = CASpringAnimation(keyPath: "opacity")
        tap.damping = 0.5
        tap.fromValue = 1
        tap.toValue = 0.7
        tap.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        tap.autoreverses = true
        tap.repeatCount = 1
        layer.add(tap, forKey: nil)
    }
    
    func setColorIcon(btn: UIButton, nameImage: String, colorIcon: UIColor) {
        let origImage = UIImage(named: nameImage)
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        btn.setImage(tintedImage, for: .normal)
        btn.tintColor = colorIcon
    }
    
}

extension UICollectionViewCell {
    func tapAnimation() {
        let tap = CASpringAnimation(keyPath: "opacity")
        tap.damping = 5
        tap.fromValue = 1
        tap.toValue = 0.7
        tap.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        tap.autoreverses = true
        tap.repeatCount = 1
        contentView.layer.add(tap, forKey: nil)
    }
}

extension UILabel {
    func pulse() {
        let pul = CASpringAnimation(keyPath: "transfom.scale")
        pul.duration = 0.6
        pul.fromValue = 0.5
        pul.toValue = 1
        pul.autoreverses = true
        pul.repeatCount = 2
        pul.initialVelocity = 0.5
        pul.damping = 1
        layer.add(pul, forKey: nil)
    }
}


