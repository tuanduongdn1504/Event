//
//  EventsModel.swift
//  Event Watch App
//
//  Created by Duong Tuan on 15/06/2025.
//

import Foundation

struct EventsModel: Codable {
    var id: String
    var title: String
    var startDate: String? = nil
    var endDate: String? = nil
    var location: String? = nil
    var link: String? = nil

    var displayStartTimeEndTime: String {
        return getDisplayStartTimeEndTime(startDate: self.startDate, endDate: self.endDate)
    }

    func getDisplayStartTimeEndTime(startDate: String?, endDate: String?) -> String {
        var displayStartTimeEndTime = ""
        if let startDate = startDate,
           let endDate = endDate {
            let (startYear, startMonth, startDay) = detachedDate(from: startDate)
            let (endYear, endMonth, endDay) = detachedDate(from: endDate)

            let isDiffYear = !startYear.isNil && !endYear.isNil && startYear != endYear
            let isDiffMonth = !startMonth.isNil && !endMonth.isNil && startMonth != endMonth
            let isDiffDay = !startDay.isNil && !endDay.isNil && startDay != endDay

            if  isDiffYear {
                // "2023-03-12" - "2024-01-01" -> "12 Mar 2023 - 01 Jan 2024"
                let startTimeByFullDateFormat = startDate.convertDateStrToDateStr(fromFormat: .default, toFormat: .medium)
                let endDateByFullDateFormat = endDate.convertDateStrToDateStr(fromFormat: .default, toFormat: .medium)
                displayStartTimeEndTime = startTimeByFullDateFormat + " - " + endDateByFullDateFormat
            } else if isDiffMonth {
                // "2024-03-01" - "2024-04-02" -> "01 Mar - 02 Apr"
                let startTimeByDateAndMonthFormat = startDate.convertDateStrToDateStr(fromFormat: .default, toFormat: .dateAndMonth)
                let endDateByDateAndMonthFormat = endDate.convertDateStrToDateStr(fromFormat: .default, toFormat: .dateAndMonth)
                displayStartTimeEndTime = startTimeByDateAndMonthFormat + " - " + endDateByDateAndMonthFormat
            } else if isDiffDay {
                // "2024-02-10" - "2024-02-12" -> "10 - 12 Feb"
                let startTimeByDayOnlyFormat = startDate.convertDateStrToDateStr(fromFormat: .default, toFormat: .dayOnly)
                let endDateByDateAndMonthFormat = endDate.convertDateStrToDateStr(fromFormat: .default, toFormat: .dateAndMonth)
                displayStartTimeEndTime = startTimeByDayOnlyFormat + " - " + endDateByDateAndMonthFormat
            } else {
                // "2024-05-05" - "2024-05-05" -> "05 May"
                displayStartTimeEndTime = startDate.convertDateStrToDateStr(fromFormat: .default, toFormat: .dateAndMonth)
            }
        }
        return displayStartTimeEndTime
    }

    func detachedDate(from date: String) -> (Int?, Int?, Int?) {
        let calendar = Calendar.current
        let dateTemp = calendar.dateComponents(
            [.year, .month, .day],
            from: date.convertDateStrToDate()
        )
        return (dateTemp.year, dateTemp.month, dateTemp.day)
    }
}
