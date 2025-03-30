//
//  BasketViewController.swift
//  Delivery App_UI Kit (Community)
//
//  Created by User on 21.03.25.
//

import UIKit

enum BasketItems {
    
}

class BasketViewController:UIViewController{
    
    @IBOutlet weak var basketTableviewController: UITableView!
    
    var basketList:[BasketItems] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        basketTableviewController.dataSource = self
        basketTableviewController.delegate = self
        basketTableviewController.register(BasketTableViewCell.nib, forCellReuseIdentifier: BasketTableViewCell.identifier)
    }
}

extension BasketViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = basketTableviewController.dequeueReusableCell(withIdentifier:BasketTableViewCell.identifier, for: indexPath) as? BasketTableViewCell else{
             return UITableViewCell()
        }
        return cell
    }
    
    
}
