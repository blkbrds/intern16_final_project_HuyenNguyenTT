//
//  TableViewRegisterCell.Ext.swift
//  FinalProject
//
//  Created by bu on 9/28/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ aClass: T.Type, bundle bundleOrNil: Bundle? = nil) {
        let identifier = String(describing: aClass)
        if Bundle.main.path(forResource: identifier, ofType: "nib") != nil {
            register(UINib(nibName: identifier, bundle: bundleOrNil), forCellReuseIdentifier: identifier)
        } else {
            register(aClass, forCellReuseIdentifier: identifier)
        }
    }
    
    func register<T: UITableViewHeaderFooterView>(_ aClass: T.Type, bundle bundleOrNil: Bundle? = nil) {
        let identifier = String(describing: aClass)
        if Bundle.main.path(forResource: identifier, ofType: "nib") != nil {
            register(UINib(nibName: identifier, bundle: bundleOrNil), forHeaderFooterViewReuseIdentifier: identifier)
        } else {
            register(aClass, forHeaderFooterViewReuseIdentifier: identifier)
        }
    }
    
    func dequeue<T: UITableViewCell>(_ aClass: T.Type, indexPath: IndexPath) -> T {
        let identifier = String(describing: aClass)
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("\(identifier) is not registered")
        }
        return cell
    }
    
    func dequeue<T: UITableViewHeaderFooterView>(_ aClass: T.Type) -> T? {
        let identifier = String(describing: aClass)
        return dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T
    }
}
