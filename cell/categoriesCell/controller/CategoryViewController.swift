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
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var categorylist:[CategoryItems] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CategoriesTableViewCell.nib, forCellReuseIdentifier: CategoriesTableViewCell.identifier)
         loadJSON()
        
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
        
        var type = categorylist [indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.identifier, for: indexPath)
                as? CategoriesTableViewCell else {
            return UITableViewCell()
        }
        switch type {
        case .categories(let model) :
            cell.configure(model)
        }
        return cell
    }
}
