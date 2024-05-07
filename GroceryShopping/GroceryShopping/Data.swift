//
//  Data.swift
//  GroceryShopping
//
//  Created by Ankit Bansal on 2/5/2024.
//

import Foundation
import FirebaseFirestoreSwift
/*
struct GroceryItem: Codable, Identifiable {
   // var id: String
    var name: String
    var price: Double
    var category: String
    var quantity: Int // New field for quantity in the basket
}*/

struct GroceryItem: Codable, Identifiable {
    var id: String
    var name: String
    var price: Double
    var category: String
    var quantity: Int
    var description: String?  // Optional property

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case category
        case quantity
        case description
    }

    init(id: String, name: String, price: Double, category: String, quantity: Int, description: String? = nil) {
        self.id = id
        self.name = name
        self.price = price
        self.category = category
        self.quantity = quantity
        self.description = description
    }
}

struct OrderItem: Codable {
    let name: String
    let price: Double
    let quantity: Int
}

struct Order: Codable {
    let orderItems: [OrderItem]
    let totalAmount: Double
}