//
//  DataViewController.swift
//  Delivery App_UI Kit (Community)
//
//  Created by User on 26.03.25.
//

import UIKit

enum Items:Codable {
    case select(SelectCollectionViewCell.Item)
    case items(ItemCollectionViewCell.Item)
}
enum DataItems :Codable {
    case data(DtaTableViewCell.DataItem)
}
class DataViewController:UIViewController {
    
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var categoriesNameLabel: UILabel!
    
    @IBOutlet weak var selectCollectionview: UICollectionView!
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    
    @IBOutlet weak var tableview :UITableView!
    
    var colloctionList:[Items] = []
    var dataList:[DataItems] = []
    
    
    var categoryName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesNameLabel.text = categoryName
        selectCollectionview.dataSource = self
        selectCollectionview.delegate = self
        itemsCollectionView.dataSource = self
        itemsCollectionView.delegate = self
        
        // tableview
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(DtaTableViewCell.nib, forCellReuseIdentifier: DtaTableViewCell.identifier)
        loadJSON()
        LoadCategoriesDataJSON()
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
    
    func LoadCategoriesDataJSON(){
         print("SALAM JSON")
        if let url = Bundle.main.url(forResource: "CategoriesData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decodedData = try JSONDecoder().decode(CategoryDataModel.self, from: data)
                
                dataList = decodedData.dataItems .map { .data($0) }
                
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                    
                }
            } catch {
                print("JSON error: \(error)")
        }
     }
  }
    @IBAction func dismissButton(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .push
        transition.subtype = .fromRight
        
        view.window?.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false, completion: nil)    }
}

extension DataViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DtaTableViewCell.identifier, for: indexPath) as? DtaTableViewCell else {
            return UITableViewCell()
        }
        let dataItem = dataList[indexPath.row]
                switch dataItem {
                case .data(let model):
                    cell.configure(model)
                }
                return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedItem = dataList[indexPath.row]
            switch selectedItem {
            case .data(let model):
                navigateToNextViewController(imageName: model.leftImage, title: model.title, subtitle: model.subtitle)
            }
        }
    func navigateToNextViewController(imageName: String?, title: String?, subtitle: String?) {
        guard let nextViewController = storyboard?.instantiateViewController(withIdentifier: ItemViewController.identifier ) as? ItemViewController else {
            return
        }
        nextViewController.headimage = imageName
        nextViewController.titles = title
        nextViewController.subtitle = subtitle
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated: true)

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
