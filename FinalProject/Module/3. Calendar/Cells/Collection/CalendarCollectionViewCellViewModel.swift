//
//  CalendarCollectionViewCellViewModel.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 10/15/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class CalendarCollectionViewCellViewModel {
    var session: Session
    var time: String {
        return session.time
    }
    
    init(session: Session) {
        self.session = session
    }
}
