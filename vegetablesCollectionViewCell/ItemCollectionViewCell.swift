//
//  ItemCollectionViewCell.swift
//  Delivery App_UI Kit (Community)
//
//  Created by User on 26.03.25.
//

import UIKit
class ItemCollectionViewCell :UICollectionViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    struct Item: Codable{
        var title : String
    }
    
    func configure (item: Item){
        self.titleLabel.text = item.title
    }
    
}
