//
//  DtaTableViewCell.swift
//  Delivery App_UI Kit (Community)
//
//  Created by User on 27.03.25.
//

import UIKit

class DtaTableViewCell: UITableViewCell {

    @IBOutlet weak var leftImageView :UIImageView!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var subtitleLablel:UILabel!
    
    @IBOutlet weak var lovelyButton:UIButton!
    @IBOutlet weak var basketButton:UIButton!
    
    
    struct DataItem :Codable{
        var leftImage:String
        var title:String
        var subtitle:String
    }
    
    func configure(_ item: DataItem ){
        leftImageView.image = UIImage(named: item.leftImage)
        titleLabel.text = item.title
        subtitleLablel.text = item.subtitle
    print ("SALAMM CONFIGURE")
}
    override func awakeFromNib() {
        super.awakeFromNib()
        lovelyButton.layer.borderWidth = 1
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
