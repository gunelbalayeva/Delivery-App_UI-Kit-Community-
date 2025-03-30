//
//  DataViewController.swift
//  Delivery App_UI Kit (Community)
//
//  Created by User on 26.03.25.
//

import UIKit

enum Items {
    case select(SelectCollectionViewCell.Item)
    case items(ItemCollectionViewCell.Item)
    
}

class DataViewController:UIViewController {
    
    @IBOutlet weak var categoriesNameLabel: UILabel!
    
    @IBOutlet weak var selectCollectionview: UICollectionView!
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    
    var colloctionList:[Items] = []
    var categoryName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesNameLabel.text = categoryName
        selectCollectionview.dataSource = self
        selectCollectionview.delegate = self
        itemsCollectionView.dataSource = self
        itemsCollectionView.delegate = self
        loadJSON()
    }
    
    func loadJSON() {
            if let url = Bundle.main.url(forResource: "Data", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decodedData = try JSONDecoder().decode(JsonModel.self, from: data)
                    
                    colloctionList = decodedData.selectItem.map { .select($0) } +
                                     decodedData.item.map { .items($0) }
                    
                    DispatchQueue.main.async {
                        self.selectCollectionview.reloadData()
                        self.itemsCollectionView.reloadData()
                    }
                } catch {
                    print("JSON error: \(error)")
            }
        }
    }
}


extension DataViewController :UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colloctionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dataItems = colloctionList[indexPath.row]
        
        if collectionView == selectCollectionview {
            guard let cell = selectCollectionview.dequeueReusableCell(withReuseIdentifier: SelectCollectionViewCell.identifier, for: indexPath) as? SelectCollectionViewCell else {
                return UICollectionViewCell()
            }
            switch dataItems {
            case .select(let model):
                cell.configure(item: model)
            default:
                break
            }
            return cell
        } else if collectionView == itemsCollectionView {
            guard let cell = itemsCollectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as? ItemCollectionViewCell else {
                return UICollectionViewCell()
            }
            switch dataItems {
            case .items(let model):
                cell.configure(item: model)
            default:
                break
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
}
