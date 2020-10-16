//
//  CalendarTableViewHeaderViewModel.swift
//  FinalProject
//
//  Created by bu on 10/15/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class CalendarTableViewHeaderViewModel {
    let title: String
    let isExpanded: Bool
    
    init(title: String, isExpanded: Bool) {
        self.title = title
        self.isExpanded = isExpanded
    }
}
