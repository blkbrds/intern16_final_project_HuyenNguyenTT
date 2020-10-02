//
//  CalendarViewController.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 10/2/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class CalendarViewController: UIViewController {

    @IBOutlet private var dayLabel: [UILabel]!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private var dayButton: [UIButton]!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavi()
        configUI()
    }
    
    private func configNavi() {
    }
    
    private func configUI() {
        
    }
    
    @IBAction private func chooseDayTouchUpInside(_ sender: UIButton) {}
}
