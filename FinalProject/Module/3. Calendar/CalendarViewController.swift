//
//  CalendarViewController.swift
//  FinalProject
//
//  Created by bu on 10/13/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class CalendarViewController: UIViewController {
    
    @IBOutlet private var weekdayLabels: [UILabel]!
    @IBOutlet private var weekdayButtons: [UIButton]!
    @IBOutlet private weak var selectedDateLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    let viewModel = CalendarViewModel()
    private var selectedIndex: Int = 0 {
        didSet {
            for button in weekdayButtons {
                button.backgroundColor = .clear
            }
            if let button = weekdayButtons.first(where: { $0.tag == selectedIndex}) {
                button.backgroundColor = #colorLiteral(red: 1, green: 0.6980392157, blue: 0.137254902, alpha: 1)
            }
            let info = viewModel.calendarData[selectedIndex]
            selectedDateLabel.text = info.weekday.valueDay + ", ngày " + info.date.toString(format: "dd") + " tháng " + info.date.toString(format: "MM") + " năm " + info.date.toString(format: "yyyy")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    private func configUI() {
        for label in weekdayLabels {
            let info = viewModel.calendarData[label.tag]
            if info.isToday {
                label.text = "Today"
            } else {
                label.text = info.weekday.firstChar
            }
        }
        for button in weekdayButtons {
            let info = viewModel.calendarData[button.tag]
            button.layer.cornerRadius = button.bounds.height / 2
            button.setTitle("\(info.date.day)", for: .normal)
        }
        selectedIndex = 0
    }
    
    @IBAction private func weekdayButtonTouchUpInside(_ sender: UIButton) {
        selectedIndex = sender.tag
    }
}
