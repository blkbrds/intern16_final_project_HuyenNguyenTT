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
        configTableView()
        configButton()
    }
    
    private func configNavi() {
    }
    
    private func configTableView() {
        tableView.register(TimeTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configButton() {
        for (index, button) in dayButton.enumerated() {
            button.tag = index
        }
    }
    
    @IBAction private func chooseDayTouchUpInside(_ sender: UIButton) {
        dayButton[sender.tag].layer.backgroundColor = #colorLiteral(red: 1, green: 0.6745098039, blue: 0.07450980392, alpha: 1)
    }
}

extension CalendarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(TimeTableViewCell.self, indexPath: indexPath)
        return cell
    }
}

extension CalendarViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
