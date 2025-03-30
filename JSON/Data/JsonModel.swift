//
//  JsonModel.swift
//  Delivery App_UI Kit (Community)
//
//  Created by User on 24.03.25.
//

import UIKit
import Foundation

struct JsonModel:Codable {
    var basket: [BasketTableViewCell.Item]
    var selectItem :[SelectCollectionViewCell.Item]
    var item: [ItemCollectionViewCell.Item]
//    var categories: [CategoriesCollectionViewCell.Item]
}
