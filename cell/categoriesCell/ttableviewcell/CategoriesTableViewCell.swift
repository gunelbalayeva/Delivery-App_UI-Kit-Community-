//
//  CategoriesTableViewCell.swift
//  Delivery App_UI Kit (Community)
//
//  Created by User on 26.03.25.
//

import UIKit
protocol CategoriesTableViewCellDelegate {
    
    func didSelectCollectionItem(item: CategoriesCollectionViewCell.Item)
    
}

class CategoriesTableViewCell: UITableViewCell {

    var delegate: CategoriesTableViewCellDelegate?

    @IBOutlet weak var collectionview: UICollectionView!

    private var modelItems:[CategoriesCollectionViewCell.Item] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(CategoriesCollectionViewCell.nib, forCellWithReuseIdentifier:
                                    CategoriesCollectionViewCell.identifier)
        if let layout = collectionview.collectionViewLayout as? UICollectionViewFlowLayout {
                   layout.minimumLineSpacing = 10
                   layout.minimumInteritemSpacing = 10
                   layout.scrollDirection = .horizontal
                   let width = (collectionview.frame.width - 20) / 2
                   layout.itemSize = CGSize(width: width, height: width * 1.5)
               }
           }

           override func layoutSubviews() {
               super.layoutSubviews()
               if let layout = collectionview.collectionViewLayout as? UICollectionViewFlowLayout {
                   let width = (collectionview.frame.width - 20) / 2
                   layout.itemSize = CGSize(width: width, height: width * 1.5)
                   layout.invalidateLayout()
            }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure (_ item :Item ){
        self.modelItems = item.items
        collectionview.reloadData()
    }
}
extension CategoriesTableViewCell {
    
    struct Item : Codable {
        let items: [CategoriesCollectionViewCell.Item] 
    }
}
extension CategoriesTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoriesCollectionViewCell.identifier,
            for: indexPath
        ) as? CategoriesCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = modelItems[indexPath.row]
        cell.configure(item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = modelItems[indexPath.item]
        delegate?.didSelectCollectionItem(item: selectedItem)
    }
}

