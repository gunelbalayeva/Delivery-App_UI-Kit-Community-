//
//  ItemViewController.swift
//  Delivery App_UI Kit (Community)
//
//  Created by User on 23.03.25.
//

import UIKit

enum ItemVC {
    case items(ItemViewController.Item)
}
class ItemViewController:UIViewController {
    
    
    @IBOutlet weak var headImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    var itemList:[ItemVC] = []
    
    var headimage:String?
    var name:String?
    var titles: String?
    var subtitle:String?
    
    struct Item:Codable {
        var countryName:String
        var detail:String
    }
    
    func configure(_ item :Item) {
        countryNameLabel.text = item.countryName
        detailLabel.text = item.detail
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageName = headimage, let image = UIImage(named: imageName) {
                   headImageView.image = image
        }
        nameLabel.text = name ?? ""
        titleLabel.text = titles ?? ""
        subtitleLabel.text = subtitle ?? ""
        loadJSON()
        showFirstItem()
        
    }
    func showFirstItem() {
        guard let firstItem = itemList.first else {
            return
        }
        
        switch firstItem {
        case .items(let item):
            countryNameLabel.text = item.countryName
            detailLabel.text = item.detail
        }
    }

    func loadJSON() {
        if let url = Bundle.main.url(forResource: "Item", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decodedData = try JSONDecoder().decode(ItemDataModel.self, from: data)
                
                itemList = decodedData.items.map { .items($0) }
                
                DispatchQueue.main.async {
                    print ("HELLO ITEM JSON")
                }
            } catch {
                print("Error loading JSON: \(error)")
            }
        }
    }
    
    
    @IBAction func addToCard(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let newViewController = storyboard.instantiateViewController(withIdentifier: CardItemViewController.identifier) as? CardItemViewController {
            newViewController.modalPresentationStyle = .fullScreen
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = .push
            transition.subtype = .fromRight
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            view.window?.layer.add(transition, forKey: kCATransition)
            present(newViewController, animated: true)
        }
    }
}
