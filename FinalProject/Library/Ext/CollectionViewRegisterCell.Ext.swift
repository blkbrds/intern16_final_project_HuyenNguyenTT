//
//  CollectionViewRegisterCell.Ext.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 9/23/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_ aClass: T.Type, bundle bundleOrNil: Bundle? = nil) {
        let identifier = String(describing: aClass)
        if Bundle.main.path(forResource: identifier, ofType: "nib") != nil {
            register(UINib(nibName: identifier, bundle: bundleOrNil), forCellWithReuseIdentifier: identifier)
        } else {
            register(aClass, forCellWithReuseIdentifier: identifier)
        }
    }
    
    func dequeue<T: UICollectionViewCell>(_ aClass: T.Type, at indexPath: IndexPath) -> T {
        let identifier = String(describing: aClass)
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("\(identifier) is not registered")
        }
        return cell
    }
}
