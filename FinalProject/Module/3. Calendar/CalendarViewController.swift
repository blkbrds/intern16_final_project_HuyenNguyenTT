//
//  CalendarViewController.swift
//  FinalProject
//
//  Created by bu on 10/13/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    enum <#name#> {
        case <#case#>
    }
    
    @IBOutlet private var weekdayLabels: [UILabel]!
    @IBOutlet private var weekdayButtons: [UIButton]!
    @IBOutlet private weak var selectedDateLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    private func configUI() {
        
    }
    
    @IBAction private func weekdayButtonTouchUpInside(_ sender: UIButton) {
        
    }
}
