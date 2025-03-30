//
//  Project+Ext.swift
//  Delivery App_UI Kit (Community)
//
//  Created by User on 23.03.25.
//
import UIKit

extension UITableViewCell {
    
    static var identifier :String {
        String(describing: self)
    }
    
    static var nib :UINib {
        return UINib(nibName: self.identifier, bundle: .main)
    }
}

