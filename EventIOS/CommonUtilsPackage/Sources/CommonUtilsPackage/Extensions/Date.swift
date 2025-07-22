//
//  Date.swift
//
//
//  Created by Duong Tuan on 20/07/2025.
//

import Foundation

extension Date {
    enum WeekDay: Int {
        case sunday = 1
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
        
        var weekDayDisplay: String {
            switch self {
            case .sunday:
                return "Sunday"
            case .monday:
                return "Monday"
            case .tuesday:
                return "Tuesday"
            case .wednesday:
                return "Wednesday"
            case .thursday:
                return "Thursday"
            case .friday:
                return "Friday"
            case .saturday:
                return "Saturday"
            }
        }
    }
    
    func getWeekDay() -> WeekDay {
        let calendar = Calendar.current
        let weekDay = calendar.component(Calendar.Component.weekday, from: self)
        return WeekDay(rawValue: weekDay)!
    }
    
    func toStringInUnitedStates(toFormat dateFormat: String) -> String {
        let formatter = DateFormatter.unitedStatesDateFormatter
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }
    
    func formattedString() -> String {
        let calendar = Calendar.current
        
        if calendar.isDateInYesterday(self) {
            return "Yesterday"
        } else if calendar.isDateInToday(self) {
            return "Today"
        } else if calendar.isDateInTomorrow(self) {
            return "Tomorrow"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, d MMM"
            return dateFormatter.string(from: self)
        }
    }
    
    var isWeekend: Bool {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: self)
        return weekday == 7 || weekday == 1
    }
}

extension Date {
    
    func startOfWeek(using calendar: Calendar = Calendar(identifier: .gregorian)) -> Date {
        let currentWeekday = calendar.component(.weekday, from: self)
        let daysToSubtract = (currentWeekday == 1 ? 6 : currentWeekday - 2)
        return calendar.date(byAdding: .day, value: -daysToSubtract, to: self) ?? self
    }
    
    func endOfWeek(using calendar: Calendar = Calendar(identifier: .gregorian), withDate date: Date = Date()) -> Date {
        let startOfWeek = self.startOfWeek(using: calendar)
        return calendar.date(byAdding: .day, value: 6, to: startOfWeek) ?? self
    }
    
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        dateformat.calendar = Calendar(identifier: .iso8601)
        dateformat.locale = Locale(identifier: "en_US")
        return dateformat.string(from: self)
    }
    
    func formattedDateStringNoLocale(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: self)
    }
    
    func toString(format: String = "yyyy-MM-dd", locale: Locale = Locale(identifier: "en_US_POSIX")) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        return formatter.string(from: self)
    }
    
    func timeComponents() -> (hour: Int, minute: Int, period: String) {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)! // Giữ UTC
        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        let period = hour < 12 ? "AM" : "PM"
        return (hour % 12 == 0 ? 12 : hour % 12, minute, period)
    }
    
    func durationString(to endDate: Date) -> String {
        let interval = Int(endDate.timeIntervalSince(self))
        let hours = interval / 3600
        let minutes = (interval % 3600) / 60
        return "\(hours)h \(minutes)m"
    }
}

// MARK: - Date static methods
extension DateFormatter {
    static var unitedStatesDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }
    
    static func unitedStatesDateFormatter(dateFormat: String) -> DateFormatter {
        let formatter = Self.unitedStatesDateFormatter
        formatter.dateFormat = dateFormat
        return formatter
    }
}
