//
//  StringExtention.swift
//  FitnessCoach
//
//  Created by Shapee Hoa on 12/25/19.
//  Copyright © 2019 Shapee Clound. All rights reserved.
//

import Foundation
import Localize_Swift

extension String {
    var language: String {
        return self.localized()
    }
    
    func substring(from left: String, to right: String) -> String {
        if let match = range(of: "(?<=\(left))[^\(right)]+", options: .regularExpression) {
            return String(self[match])
        }
        return ""
    }
    
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
               value: NSUnderlineStyle.single.rawValue,
                   range:NSMakeRange(0,attributeString.length))
        return attributeString
    }
    
    func currency() -> String {
        let formatter = NumberFormatter()
        formatter.secondaryGroupingSize = 3
        formatter.groupingSize = 3
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        
        return formatter.string(from: NSNumber(value: Double(self.replacingOccurrences(of: ",", with: "")) != nil ? Double(self.replacingOccurrences(of: ",", with: ""))! : 0)) ?? "0"
    }
    
    func uncurrency() -> String? {
        return self.trim().replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ",", with: "")
    }
    
    func trim() -> String{
        return (self.trimmingCharacters(in: .whitespacesAndNewlines)).replacingOccurrences(of: "Không có", with: "")
    }
}
