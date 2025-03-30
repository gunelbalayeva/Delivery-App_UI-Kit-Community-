//
//  CategoriesCollectionViewCell.swift
//  Delivery App_UI Kit (Community)
//
//  Created by User on 23.03.25.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
           super.awakeFromNib()
           imageView.contentMode = .scaleAspectFill
           imageView.clipsToBounds = true 
       }
    func configure(_ item :Item) {
        self.imageView.image = UIImage(named: item.image)
        self.nameLabel.text = item.name
    }
    struct Item :Codable {
        var image:String
        var name:String
    }
}


