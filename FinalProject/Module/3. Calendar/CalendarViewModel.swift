//
//  CalendarViewModel.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 10/13/20.
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
            return "Th 2"
        case .tuesday:
            return "Th 3"
        case .wednesday:
            return "Th 4"
        case .thursday:
            return "Th 5"
        case .friday:
            return "Th 6"
        case .saturday:
            return "Th 7"
        case .sunday:
            return "CN"
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
    var locations: [Location] = []
    var movie: Movie

    init(movie: Movie) {
        self.movie = movie
        let calendar = Calendar.current
        for i in 0 ... 6 {
            if let date = calendar.date(byAdding: .day, value: i, to: Date()),
                let weekday = Weekday(rawValue: calendar.component(.weekday, from: date)) {
                calendarData.append(CalendarInfo(weekday: weekday, isToday: i == 0, date: date))
            }
        }
    }

    func getLocation(date: String, completion: @escaping (APIResult) -> Void) {
        apiProvider.getShowtime(sku: movie.sku, date: date) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let locations):
                this.locations = locations
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func convertDateToString() -> String {
        let nowDate = Date()
        return nowDate.toString(format: "dd") +
            nowDate.toString(format: "MM") +
            nowDate.toString(format: "yyyy")
    }
    func numberOfSections() -> Int {
        return locations.count
    }

    func numberOfItems(inSection section: Int) -> Int {
        guard let location = locations[safeIndex: section],
            location.isExpanded else { return 0 }
        return location.cinemas.count
    }
    
    func viewModelForItems(at indexPath: IndexPath) -> CalendarTableViewCellViewModel? {
        guard let location = locations[safeIndex: indexPath.section],
            let cinema = location.cinemas[safeIndex: indexPath.row] else { return nil }
        return CalendarTableViewCellViewModel(cinema: cinema)
    }
    
    func viewModelForHeader(inSection section: Int) -> CalendarTableViewHeaderViewModel? {
        guard let location = locations[safeIndex: section] else { return nil }
        return CalendarTableViewHeaderViewModel(title: location.name, isExpanded: location.isExpanded)
    }
}
