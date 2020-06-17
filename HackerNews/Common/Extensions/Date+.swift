//
//  Date+.swift
//  HackerNews
//
//  Created by Никита Васильев on 29/09/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import Foundation

extension Date {
    // Returns the number of years
    func yearsCount(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    // Returns the number of months
    func monthsCount(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    // Returns the number of weeks
    func weeksCount(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    // Returns the number of days
    func daysCount(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    // Returns the number of hours
    func hoursCount(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    // Returns the number of minutes
    func minutesCount(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    // Returns the number of seconds
    func secondsCount(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }

    // Returns time ago by checking if the time differences between two dates are in year or months or weeks or days or hours or minutes or seconds
    func timeAgo(from date: Date) -> String {
        if yearsCount(from: date) > 0 { return "\(yearsCount(from: date)) years ago" }
        if monthsCount(from: date) > 0 { return "\(monthsCount(from: date)) months ago" }
        if weeksCount(from: date) > 0 { return "\(weeksCount(from: date)) weeks ago" }
        if daysCount(from: date) > 0 { return "\(daysCount(from: date)) days ago" }
        if hoursCount(from: date) > 0 { return "\(hoursCount(from: date)) hrs ago" }
        if minutesCount(from: date) > 0 { return "\(minutesCount(from: date)) min ago" }
        if secondsCount(from: date) > 0 { return "\(secondsCount(from: date)) sec ago" }
        return ""
    }
    
    func timeAgo(from seconds: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(seconds))
        return timeAgo(from: date)
    }
}
