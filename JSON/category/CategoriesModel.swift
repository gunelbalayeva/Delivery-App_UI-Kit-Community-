//
//  CategoriesModel.swift
//  Delivery App_UI Kit (Community)
//
//  Created by User on 26.03.25.
//

import UIKit

struct CategoriesModel: Codable {
    var categories: [CategoriesTableViewCell.Item]
}

struct Category: Codable {
    let name: String
    let items: [CategoriesCollectionViewCell.Item]
}
