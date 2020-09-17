//
//  FontExtention.swift
//  CashD
//
//  Created by Phạm Hoà on 7/16/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import Foundation
import UIKit
import DeviceKit

extension UIFont {
    func autoResize() -> UIFont {
        var sizeScale: CGFloat = 1
        if Device.current.isPad {
            sizeScale = 1.4
        }else if Device.current.isOneOf([.iPhone6, .iPhone7]) {
            sizeScale = 0.95
        }else if Device.current.isOneOf([.iPhone5]) {
            sizeScale = 0.9
        }
        return UIFont(name: self.fontName, size: self.pointSize * sizeScale)!
    }
}
