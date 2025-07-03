//
//  String.swift
//  Event Watch App
//
//  Created by Duong Tuan on 15/06/2025.
//

import Foundation

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        self?.isEmpty ?? true
    }
}

extension String {
    var length: Int {
        return count
    }
    
    subscript (index: Int) -> String {
        return self[index ..< index + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (ranger: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, ranger.lowerBound)),
                                            upper: min(length, max(0, ranger.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    func trundicate(max: Int) -> String {
        if self.count > max {
            return "\(self.prefix(max))..."
        }
        return self
    }
    
    func formatDecimalNumber(before: Int, after: Int) -> String {
        var tempText = self
        let isContainerComma = tempText.contains(",")
        let isContainerDot = tempText.contains(".")
        let separateBy = isContainerComma ? "," : "."
        
        let isContainDecimalSign = isContainerComma || isContainerDot
        if isContainDecimalSign {
            let components = tempText.components(separatedBy: separateBy)
            let numberAfterComma = components[1]
            let numberBeforeComma = components[0]
            let strimBeforeNumber = numberBeforeComma.substring(toIndex: before)
            
            if numberAfterComma.count > after {
                let strimAfterNumber = numberAfterComma.substring(toIndex: after)
                tempText = strimBeforeNumber + "." + strimAfterNumber
                return tempText
            }
            
            return strimBeforeNumber + "." + numberAfterComma
        } else if tempText.count > before {
            tempText = tempText.substring(toIndex: before)
            return tempText
        }
        return tempText
    }
}

extension String {
    func convertDateStrToDate(from dateFormat: DateTimeFormatType = .default) -> Date {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = dateFormat.rawValue
        timeFormatter.calendar = Calendar(identifier: .gregorian)
        timeFormatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        timeFormatter.locale = Locale(identifier: Locale.current.identifier)
        guard let time = timeFormatter.date(from: self) else {
            return Date()
        }
        return time
    }
    
    func convertTimeStrToDate() -> Date {
        let timeStr = self.substring(toIndex: 8)
        let timeArr = timeStr.components(separatedBy: ":")
        if timeArr.count == 3 {
            var dateComponents = DateComponents()
            dateComponents.year = 2000
            dateComponents.month = 1
            dateComponents.day = 1
            dateComponents.timeZone = TimeZone.current
            dateComponents.hour = Int(timeArr[0])
            dateComponents.minute = Int(timeArr[1])
            dateComponents.second = 0 // Int(timeArr[2])
            // Create date from components
            let userCalendar = Calendar(identifier: .gregorian) // since the components above (like year 1980) are for Gregorian
            let result = userCalendar.date(from: dateComponents) ?? Date()
            return result
        }
        return Date()
    }
    
    func convertDateStrToDateStr(fromFormat: DateTimeFormatType, toFormat: DateTimeFormatType, isConverToCurrentTimeZone: Bool = true) -> String {
        var fromTimeFormatter: DateFormatter
        if isConverToCurrentTimeZone {
            fromTimeFormatter = DateFormatter()
            fromTimeFormatter.calendar = Calendar(identifier: .gregorian)
            fromTimeFormatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
            fromTimeFormatter.locale = Locale(identifier: Locale.current.identifier)
        } else {
            fromTimeFormatter = .unitedStatesDateFormatter
        }
        let tempFromFormat = fromFormat
        var strDate = self
        if fromFormat == .leaveTime {
            strDate = "\(strDate):00"
        }
        if fromFormat == .time || fromFormat == .timeZ || fromFormat == .timeGlobal || fromFormat == .leaveTime {
            let tempDate = strDate.convertTimeStrToDate()
            let result = tempDate.getFormattedDate(format: toFormat.rawValue)
            return result
        }
        fromTimeFormatter.dateFormat = tempFromFormat.rawValue
        let time = fromTimeFormatter.date(from: strDate) ?? Date()
        return isConverToCurrentTimeZone ? time.getFormattedDate(format: toFormat.rawValue) : DateFormatter.unitedStatesDateFormatter(dateFormat: toFormat.rawValue).string(from: time)
    }
    
    func convertDateFormat(from inputFormat: DateTimeFormatType, to outputFormat: DateTimeFormatType) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat.rawValue
        
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        
        dateFormatter.dateFormat = outputFormat.rawValue
        return dateFormatter.string(from: date)
    }
    
    func toDate(format: String = "yyyy-MM-dd", locale: Locale = Locale(identifier: "en_US_POSIX")) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        return formatter.date(from: self)
    }
    
    func toTimeDate() -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withFullTime,
            .withFractionalSeconds,
            .withColonSeparatorInTime,
            .withTimeZone
        ]
        return formatter.date(from: self)
    }
}

extension String {
    static func formattedTimeRange(startTime: String, endTime: String) -> String? {
        guard let startDate = startTime.toTimeDate(),
              let endDate = endTime.toTimeDate() else { return nil }
        
        let start = startDate.timeComponents()
        let end = endDate.timeComponents()
        
        // Format hours and minutes
        let startMinuteStr = start.minute == 0 ? "" : ":\(String(format: "%02d", start.minute))"
        let endMinuteStr = end.minute == 0 ? "" : ":\(String(format: "%02d", end.minute))"
        
        let startTimeStr = "\(start.hour)\(startMinuteStr)"
        let endTimeStr = "\(end.hour)\(endMinuteStr)"
        
        // Determine AM/PM logic
        let timeRange: String
        if start.period == end.period {
            timeRange = "\(startTimeStr) - \(endTimeStr)\(end.period)"
        } else {
            timeRange = "\(startTimeStr)\(start.period) - \(endTimeStr)\(end.period)"
        }
        
        let duration = startDate.durationString(to: endDate)
        return "\(timeRange) (\(duration))"
    }
}
