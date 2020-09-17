//
//  DateExtention.swift
//  TemplateProject
//
//  Created by Hoa on 7/1/19.
//  Copyright © 2019 Benoit PASQUIER. All rights reserved.
//

import Foundation

extension Date {
    func string(_ format: String,_ localeString: String = "en") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: localeString)
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self as Date)
    }
    
    func stringWithTimeZone(_ timeZone: String,_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self as Date)
    }
    
    var millisecondsSince1970: Double {
        return (self.timeIntervalSince1970 * 1000.0).rounded()
    }
    
    var secondsSince1970: Double {
        return (self.timeIntervalSince1970)
    }
    
    init(milliseconds: Double) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
    
    init(seconds: Double) {
        self = seconds == 0 ? Date() : Date(timeIntervalSince1970: TimeInterval(seconds))
    }
    
    init(string: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self = dateFormatter.date(from: string)!
    }
    
    init(MM_YYYY: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yyyy"
        self = dateFormatter.date(from: MM_YYYY)!
    }
    
    var startDate: Date {
        return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self) ?? self
    }
    var endDate: Date {
        return Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: self) ?? self
    }
    
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    var week: Int {
        return Calendar.current.component(.weekOfMonth, from: self)
    }
    
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    var totalDaysOfMonth: Int {
        let range = Calendar.current.range(of: .day, in: .month, for: Date())
        return range?.count ?? 0
    }
    
    // This Month Start
    func startMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components) ?? self
    }
    
    func endMonth() -> Date {
        let components:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: self) as NSDateComponents
        components.month += 1
        components.day = 1
        components.day -= 1
        return Calendar.current.date(from: components as DateComponents) ?? self
    }
    
    func startYear() -> Date {
        let year = Calendar.current.component(.year, from: Date())
        return Calendar.current.date(from: DateComponents(year: year, month: 1, day: 1)) ?? Date()
    }
}
extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
