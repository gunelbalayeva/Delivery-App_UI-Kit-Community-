//
//  Collectionview+exc.swift
//  Delivery App_UI Kit (Community)
//
//  Created by User on 26.03.25.
//

import UIKit

extension UICollectionViewCell {
    
    static var identifier:String {
        String(describing: self)
    }
    
    static var nib :UINib {
        return UINib(nibName: self.identifier, bundle: .main)
    }
}

