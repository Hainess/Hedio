//
//  Date+.swift
//  HHFoundationKit
//
//  Created by whh on 2023/7/31.
//

import Foundation

public extension Date {

    init(timestamp: TimeInterval) {
        self.init(timeIntervalSince1970: timestamp)
    }
    
    /// 时间戳(整数)
    var timestamp: Int {
        return Int(timeIntervalSince1970)
    }
    
    /// 处理时间对象
    var calendar: Calendar {
        return Calendar(identifier: Calendar.current.identifier)
    }
    
    /// 根据当前时间设置年份
    var year: Int {
        get {
            return calendar.component(.year, from: self)
        }
        set {
            guard newValue > 0 else { return }
            let currentYear = calendar.component(.year, from: self)
            let yearsToAdd = newValue - currentYear
            if let date = calendar.date(byAdding: .year, value: yearsToAdd, to: self) {
                self = date
            }
        }
    }
    
    /// 根据当前时间设置月份
    var month: Int {
        get {
            return calendar.component(.month, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .month, in: .year, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentMonth = calendar.component(.month, from: self)
            let monthsToAdd = newValue - currentMonth
            if let date = calendar.date(byAdding: .month, value: monthsToAdd, to: self) {
                self = date
            }
        }
    }
    
    /// 根据当前时间设置天
    var day: Int {
        get {
            return calendar.component(.day, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .day, in: .month, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentDay = calendar.component(.day, from: self)
            let daysToAdd = newValue - currentDay
            if let date = calendar.date(byAdding: .day, value: daysToAdd, to: self) {
                self = date
            }
        }
    }
    
    /// 根据当前时间设置小时
    var hour: Int {
        get {
            return calendar.component(.hour, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .hour, in: .day, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentHour = calendar.component(.hour, from: self)
            let hoursToAdd = newValue - currentHour
            if let date = calendar.date(byAdding: .hour, value: hoursToAdd, to: self) {
                self = date
            }
        }
    }
    
    /// 根据当前时间设置分钟
    var minute: Int {
        get {
            return calendar.component(.minute, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .minute, in: .hour, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentMinutes = calendar.component(.minute, from: self)
            let minutesToAdd = newValue - currentMinutes
            if let date = calendar.date(byAdding: .minute, value: minutesToAdd, to: self) {
                self = date
            }
        }
    }
    
    /// 根据当前时间设置秒
    var second: Int {
        get {
            return calendar.component(.second, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .second, in: .minute, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentSeconds = calendar.component(.second, from: self)
            let secondsToAdd = newValue - currentSeconds
            if let date = calendar.date(byAdding: .second, value: secondsToAdd, to: self) {
                self = date
            }
        }
    }
    
    /// 是否是周末
    var isInWeekend: Bool {
        return calendar.isDateInWeekend(self)
    }
    
    /// 获取星期几。 周日是1，周一是2，周六是7
    var weekday: Int {
        calendar.component(.weekday, from: self)
    }
    
    /// 把 weekday 转 中文的一、二...日
    var weekdayChina: String {
        let mapping: [String] = ["日", "一", "二", "三", "四", "五", "六"]
        let day = weekday
        if day > mapping.count || day == 0 {
            return mapping.first!
        }
        return mapping[day - 1]
    }
    
    /// 判断两个日期是否同一天
    func isSameDay(with another: Date) -> Bool {
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        let anotherComponents = calendar.dateComponents([.year, .month, .day], from: another)
        if components.year == anotherComponents.year,
           components.month == anotherComponents.month,
           components.day == anotherComponents.day {
            return true
        }
        return false
    }
    
    /// 把秒数按指定格式转化为 字符串
    /// - Parameters:
    ///   - seconds: 秒数
    ///   - format: 格式
    /// - Returns: 按照格式转换出的时间
    static func convert(seconds: Int, format: String = "mm:ss") -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(seconds))
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }

}

// MARK: - 格式化
public extension Date {
    
    /// 把时间格式化成字符串
    /// - Parameter format: 字符串格式. 如: yyyy-MM-dd
    /// - Returns: 格式化后的时间字符串
    func string(with format: String) -> String {
        let df = DateFormatter()
        df.dateFormat = format
        let today = df.string(from: self)
        return today
    }

}

