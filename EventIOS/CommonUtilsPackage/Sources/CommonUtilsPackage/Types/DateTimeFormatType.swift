//
//  DateTimeFormatType.swift
//
//
//  Created by Duong Tuan on 20/07/2025.
//

import Foundation

public enum DateTimeFormatType: String {
    case `default` = "YYYY-MM-dd"
    case publicationText = "hh:mma, dd MMM YYYY"
    case medium = "dd MMM YYYY"
    case shortenMedium = "d MMM YYYY"
    case hourAndMinute = "hh:mma"
    case time = "HH:mm:ss"
    case fullDate = "EEE dd MMM"
    case fullDateWithFullMonthFormat = "EEE dd MMMM"
    case fullDateAndYear = "EEE dd MMM YYYY"
    case weekDayDate = "E dd/MM/yyyy"
    case weekDayDateTime = "E dd/MM/yyyy hh:mm a"
    case fullDateTime = "dd MMM YYYY hh:mm a"
    case fullDateTime24hWithSlash = "dd/MM/YYYY HH:mm"
    case fullDateTime12hWithSlash = "dd/MM/YYYY hh:mm a"
    case fullDateTime12hWithSlashNoSpaceAmPm = "dd/MM/YYYY hh:mma"
    case fullDateTime24h = "dd MMM YYYY HH:mm"
    case date = "dd MMMM YYYY"
    case leaveTime = "HH:mm"
    case shortenLeaveTime = "H:mm"
    case hourAmPm = "hh:mm a"
    case normalDate = "dd/MM/YYYY"
    case normalTime = "h:mm a"
    case timeZ = "HH:mm:ssZ"
    case timeGlobal = "HH:mm:ss.SSSZ"
    case timeISO = "yyyy-MM-dd'T'HH:mm:ssZ"
    case dateTimeISOWithFractionalSeconds = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case dateTimePattern = "dd MMM yyyy - h:mm a"
    case dateTimeISOWithoutFractionalSeconds = "yyyy-MM-dd'T'HH:mm:ss"
    /// Ex: Fri, 02 Sep 2022
    case fullDateAndYear2 = "E, dd MMM YYYY"
    case ativityDate = "dd-MM-yyyy"
    case weekdayNameStandaloneShort = "EEE"
    case dayOnly = "dd"
    case dateAndTime = "YYYY-MM-dd,HH:mm"
    case dateAndTimeNew = "dd-MM-YYYY HH:mm"
    case dateAndMonth = "dd MMM"
    case dateMonth = "dd-MMM"
    case dateAndTimeWithSeparator = "dd MMM YYYY | hh:mm a"
    case dateTimeSlashWithSeparator = "YYYY/MM/dd | hh:mm a"
    case monthAndYear = "MMM yyyy"
}
