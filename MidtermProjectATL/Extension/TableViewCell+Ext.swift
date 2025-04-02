//
//  TableViewCell+Ext.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 20.03.25.
//

import UIKit

extension UITableViewCell{
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    static var nib: UINib {
        return UINib(nibName: self.reuseIdentifier, bundle: nil)
    }
}
