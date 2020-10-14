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
            if let button = weekdayButtons.first(where: { $0.tag == selectedIndex }) {
                button.backgroundColor = #colorLiteral(red: 1, green: 0.6980392157, blue: 0.137254902, alpha: 1)
            }
            let info = viewModel.calendarData[selectedIndex]
            selectedDateLabel.text = info.weekday.valueDay + ", ngày " + info.date.toString(format: "dd") + " tháng " + info.date.toString(format: "MM") + " năm " + info.date.toString(format: "yyyy")
        }
    }
    var hiddenSections = Set<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configTableView()
    }
    
    private func configUI() {
        for label in weekdayLabels {
            let info = viewModel.calendarData[label.tag]
            if info.isToday {
                label.text = "Hôm nay"
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
    
    private func configTableView() {
        tableView.register(CalendarTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction private func weekdayButtonTouchUpInside(_ sender: UIButton) {
        selectedIndex = sender.tag
    }
    
    @objc private func handleSelection(_ sender: UIButton) {
        let section = sender.tag
        
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            
            for row in 0..<viewModel.tableViewData[section].count {
                indexPaths.append(IndexPath(row: row,
                                            section: section))
            }
            
            return indexPaths
        }
        
        if hiddenSections.contains(section) {
            hiddenSections.remove(section)
            tableView.insertRows(at: indexPathsForSection(), with: .fade)
        } else {
            hiddenSections.insert(section)
            tableView.deleteRows(at: indexPathsForSection(), with: .fade)
        }
    }
}

extension CalendarViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if hiddenSections.contains(section) {
            return 0
        }
        return viewModel.tableViewData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CalendarTableViewCell.self, indexPath: indexPath)
        cell.cinemaLabel.text = viewModel.tableViewData[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionButton = UIButton()
        
        sectionButton.setTitle(String(section), for: .normal)
        sectionButton.contentHorizontalAlignment = .leading
        sectionButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        
        sectionButton.backgroundColor = #colorLiteral(red: 0.1293964982, green: 0.1294215322, blue: 0.1293910444, alpha: 1)
        sectionButton.layer.borderWidth = 1
        sectionButton.tag = section
        
        sectionButton.addTarget(self, action: #selector(handleSelection(_:)), for: .touchUpInside)
        return sectionButton
    }
}

extension CalendarViewController: UITableViewDelegate { }
