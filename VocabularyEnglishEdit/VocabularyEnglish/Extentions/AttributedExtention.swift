//
//  At.swift
//  FitnessCoach
//
//  Created by Nightmare on 7/21/20.
//  Copyright © 2020 Shapee Clound. All rights reserved.
//

import Foundation
import UIKit
extension NSMutableAttributedString {
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            self.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: foundRange)
            return true
        }
        return false
    }
}
