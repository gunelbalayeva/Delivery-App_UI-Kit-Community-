//
//  BasketTableViewCell.swift
//  Delivery App_UI Kit (Community)
//
//  Created by User on 23.03.25.
//

import UIKit

class BasketTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var countryCityLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var rigthButton: UIButton!
    @IBOutlet weak var yesOrNotLabel: UILabel!
    @IBOutlet weak var checkSwitch: UISwitch!
    @IBOutlet weak var buttonHeadLabel: UILabel!

    struct Item: Codable {
        var yesOrNot: String?
        var switches: Bool
        var showYesOrNot: Bool
        var change: String?
        var head: String?
        var image: String?
        var items: String?
        var countryCityName: String?
        var adress: String?
        var rigrhButton: String?
        var showHead: Bool
        var showImage: Bool
        var showItems: Bool
        var showCountryCityName: Bool
        var showAdress: Bool
        var showRightButton: Bool
        var showChange: Bool
        var buttonHead:String
        var showButtonHead:Bool
    }

    func configure(item: Item) {
        self.changeButton.setTitle(item.showChange ? item.change : "", for: .normal)
        changeButton.isHidden = !item.showChange

        self.headLabel.text = item.showHead ? item.head : nil
        headLabel.isHidden = !item.showHead

        if item.showImage, let imageName = item.image {
            leftImage.image = UIImage(named: imageName)
            leftImage.isHidden = false
        } else {
            leftImage.isHidden = true
        }

        self.itemLabel.text = item.showItems ? item.items : nil
        itemLabel.isHidden = !item.showItems

        self.countryCityLabel.text = item.showCountryCityName ? item.countryCityName : nil
        countryCityLabel.isHidden = !item.showCountryCityName

        self.adressLabel.text = item.showAdress ? item.adress : nil
        adressLabel.isHidden = !item.showAdress

        self.rigthButton.setTitle(item.showRightButton ? item.rigrhButton : "", for: .normal)
        rigthButton.isHidden = !item.showRightButton

        if item.showYesOrNot, let yesOrNotText = item.yesOrNot {
            self.yesOrNotLabel.text = yesOrNotText
            yesOrNotLabel.isHidden = false
        } else {
            yesOrNotLabel.isHidden = true
        }

        self.checkSwitch.isOn = item.switches
        checkSwitch.isHidden = !item.showYesOrNot
        
        self.buttonHeadLabel.text = item.showButtonHead ? item.buttonHead : nil
           buttonHeadLabel.isHidden = !item.showButtonHead
    }
 
    @IBAction func didClickedRigthButton(_ sender: UIButton) {
        
           sender.isSelected.toggle()
                   
                   if sender.isSelected {
                       sender.setImage(UIImage(named: "Vector"), for: .normal)
                       sender.setTitleColor(UIColor(named: "morBG"), for: .normal)
                       sender.layer.borderColor = UIColor(named: "morBG")?.cgColor
                       sender.layer.borderWidth = 1
                       leftImage?.tintColor = UIColor(named: "morBG")
                       countryCityLabel.textColor = UIColor(named: "morBG")
                       rigthButton.isHidden = false
                   } else {
                       rigthButton.isHidden = true
            }
    }
    @IBAction func dodCheckSwitch(_ sender: UISwitch) {
        if yesOrNotLabel.text == "Yes" {
               yesOrNotLabel.text = "No"
           } else {
               yesOrNotLabel.text = "Yes"
           }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rigthButton.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
