//
//  CalendarTableViewHeader.swift
//  FinalProject
//
//  Created by bu on 10/14/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

protocol CalendarTableViewHeaderDelegate: class {
    func header(_ header: CalendarTableViewHeader, needsPerform action: CalendarTableViewHeader.Action)
}

final class CalendarTableViewHeader: UITableViewHeaderFooterView {
    
    enum Action {
        case didSelect(_ section: Int)
    }
    
    @IBOutlet private weak var titleLable: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    
    var section: Int = 0
    weak var delegate: CalendarTableViewHeaderDelegate?
    
    var viewModel: CalendarTableViewHeaderViewModel? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = #colorLiteral(red: 0.1293964982, green: 0.1294215322, blue: 0.1293910444, alpha: 1)
        contentView.layer.borderWidth = 1
        contentView.layer.backgroundColor = #colorLiteral(red: 0.1293964982, green: 0.1294215322, blue: 0.1293910444, alpha: 1)
    }
    
    private func updateView() {
        guard let viewModel = viewModel else { return }
        titleLable.text = viewModel.title
        imageView.image = viewModel.isExpanded ? #imageLiteral(resourceName: "ic-up-calendar") : #imageLiteral(resourceName: "ic-down-calendar")
    }
    
    @IBAction private func selectionButtonTouchUpInside(_ sender: UIButton) {
        delegate?.header(self, needsPerform: .didSelect(section))
    }
}
