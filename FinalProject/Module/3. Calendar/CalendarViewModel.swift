//
//  CalendarViewModel.swift
//  FinalProject
//
//  Created by bu on 10/13/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

enum Weekday: Int, CaseIterable {
    
    case monday = 1
    case tuesday = 2
    case wednesday = 3
    case thursday = 4
    case friday = 5
    case saturday = 6
    case sunday = 7
    
    var valueDay: String {
        switch self {
        case .monday:
            return "Thứ Hai"
        case .tuesday:
            return "Thứ Ba"
        case .wednesday:
            return "Thứ Tư"
        case .thursday:
            return "Thứ Năm"
        case .friday:
            return "Thứ Sáu"
        case .saturday:
            return "Thứ Bảy"
        case .sunday:
            return "Chủ nhật"
        }
    }
    var firstChar: String {
        switch self {
        case .monday:
            return "Mon"
        case .tuesday:
            return "Tue"
        case .wednesday:
            return "Wed"
        case .thursday:
            return "Thu"
        case .friday:
            return "Fri"
        case .saturday:
            return "Sat"
        case .sunday:
            return "Sun"
        }
    }
}

struct CalendarInfo {
    var weekday: Weekday
    var isToday: Bool = false
    var date: Date
}

final class CalendarViewModel {
    var calendarData: [CalendarInfo] = []
    
    init() {
        let calendar = Calendar.current
        for i in 0 ... 6 {
            if let date = calendar.date(byAdding: .day, value: i, to: Date()), let weekday = Weekday(rawValue: calendar.component(.weekday, from: date)) {
                calendarData.append(CalendarInfo(weekday: weekday, isToday: i == 0, date: date))
            }
        }
    }
}
