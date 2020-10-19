//
//  CalendarViewController.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 10/13/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class CalendarViewController: UIViewController {
    
    @IBOutlet private var weekdayLabels: [UILabel]!
    @IBOutlet private var weekdayButtons: [UIButton]!
    @IBOutlet private weak var selectedDateLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel = CalendarViewModel(movie: Movie())
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
            getLocations()
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
                label.text = "Nay"
            } else {
                label.text = info.weekday.firstChar
            }
        }
        for button in weekdayButtons {
            let info = viewModel.calendarData[button.tag]
            button.setTitle("\(info.date.day)", for: .normal)
        }
        selectedIndex = 0
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for button in weekdayButtons {
            button.layer.cornerRadius = button.bounds.height / 2
        }
    }
    
    private func configTableView() {
        tableView.register(CalendarTableViewCell.self)
        tableView.register(CalendarTableViewHeader.self)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func getLocations() {
        let info = viewModel.calendarData[selectedIndex]
        let date = info.date.toString(format: "ddMMyyyy")
        viewModel.getLocation(date: date) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.tableView.reloadData()
            case .failure(let error):
                this.showAlert(alertText: "Error", alertMessage: error.localizedDescription)
            }
        }
    }
    
    @IBAction private func weekdayButtonTouchUpInside(_ sender: UIButton) {
        selectedIndex = sender.tag
    }
    
    @objc private func handleSelection(section: Int) {
        viewModel.locations[section].isExpanded = !viewModel.locations[section].isExpanded
        tableView.reloadSections([section], with: .automatic)
    }
}

extension CalendarViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CalendarTableViewCell.self, indexPath: indexPath)
        cell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.layer.borderWidth = 0.2
        cell.viewModel = viewModel.viewModelForItems(at: indexPath)
        return cell
    }
}

extension CalendarViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeue(CalendarTableViewHeader.self)
        header?.delegate = self
        header?.section = section
        header?.viewModel = viewModel.viewModelForHeader(inSection: section)
        return header
    }
}

extension CalendarViewController: CalendarTableViewHeaderDelegate {
    func header(_ header: CalendarTableViewHeader, needsPerform action: CalendarTableViewHeader.Action) {
        switch action {
        case .didSelect(let section):
            handleSelection(section: section)
        }
    }
}
