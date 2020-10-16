//
//  CalendarTableViewCellViewModel.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 10/14/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class CalendarTableViewCellViewModel {
    var cinema: Cinema
    var name: String {
        return cinema.name
    }
    
    init(cinema: Cinema) {
        self.cinema = cinema
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        return cinema.sessions.count
    }
    
    func viewModelForItems(at indexPath: IndexPath) -> CalendarCollectionViewCellViewModel? {
        guard let session = cinema.sessions[safeIndex: indexPath.row] else { return nil }
        return CalendarCollectionViewCellViewModel(session: session)
    }
}
