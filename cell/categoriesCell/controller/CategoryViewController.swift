//
//  CategoryViewController.swift
//  Delivery App_UI Kit (Community)
//
//  Created by User on 21.03.25.
//

import UIKit

enum CategoryItems: Codable{
    case categories(CategoriesTableViewCell.Item)
}
class CategoryViewController:UIViewController {
    
    
    @IBOutlet weak var categoriesNameLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var categorylist:[CategoryItems] = []
    var categoryName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesNameLabel.text = categoryName
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CategoriesTableViewCell.nib, forCellReuseIdentifier: CategoriesTableViewCell.identifier)
         loadJSON()
        
}
    
    @IBAction func dismissButton(_ sender: Any) {
        let transition = CATransition()
           transition.duration = 0.5
           transition.type = .fade
           transition.subtype = .fromLeft
           view.window?.layer.add(transition, forKey: kCATransition)
           self.dismiss(animated: false, completion: nil)   
    }
    func loadJSON() {
        if let url = Bundle.main.url(forResource: "Categories", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decodedData = try JSONDecoder().decode(CategoriesModel.self, from: data)
                categorylist = decodedData.categories.map { .categories($0) }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("JSON error: \(error)")
            }
        }
    }
}

extension CategoryViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorylist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let type = categorylist [indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.identifier, for: indexPath)
                as? CategoriesTableViewCell else {
            return UITableViewCell()
        }
        switch type {
        case .categories(let model) :
            cell.delegate = self
            cell.configure(model)
            
        }
        return cell
    }
}

extension CategoryViewController: CategoriesTableViewCellDelegate {
    func didSelectCollectionItem(item: CategoriesCollectionViewCell.Item) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: DataViewController.identifier) as? DataViewController {
            detailVC.categoryName = item.name 
            detailVC.modalPresentationStyle = .fullScreen
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = .push
            transition.subtype = .fromRight
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut) 
            view.window?.layer.add(transition, forKey: kCATransition)
            self.present(detailVC, animated: true)
        }
    }
}

