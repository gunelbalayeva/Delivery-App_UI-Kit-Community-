//
//  BasketViewController.swift
//  Delivery App_UI Kit (Community)
//
//  Created by User on 21.03.25.
//

import UIKit

enum BasketItems {
    case basketItems(BasketTableViewCell.Item)
}

class BasketViewController:UIViewController{
    
    @IBOutlet weak var basketTableviewController: UITableView!
    
    var basketList:[BasketItems] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        basketTableviewController.dataSource = self
        basketTableviewController.delegate = self
        basketTableviewController.register(BasketTableViewCell.nib, forCellReuseIdentifier: BasketTableViewCell.identifier)
        loadJSON()
    }
    
   
    @IBAction func dismissButton(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .push
        transition.subtype = .fromRight
        
        view.window?.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false, completion: nil)
    }

    
    func loadJSON() {
        if let url = Bundle.main.url(forResource: "Data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decodedData = try JSONDecoder().decode(JsonModel.self, from: data)
                basketList = decodedData.basket.map { .basketItems($0) }
                
                DispatchQueue.main.async {
                    self.basketTableviewController.reloadData()
                }
            } catch {
                print("JSON error: \(error)")
            }
        }
    }
}
extension BasketViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basketList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let basketItem = basketList[indexPath.row]
        guard let cell = basketTableviewController.dequeueReusableCell(withIdentifier:BasketTableViewCell.identifier, for: indexPath) as? BasketTableViewCell else{
             return UITableViewCell()
        }
        switch basketItem {
        case .basketItems(let model):
            cell.configure(item: model)
        }
        return cell
    }
}
