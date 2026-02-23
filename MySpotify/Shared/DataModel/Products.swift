//
//  Products.swift
//  MySpotify
//
//  Created by Harikrishnan on 15/12/25.
//

import Foundation

struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

// MARK: - Product
struct Product: Codable , Identifiable{
    let id: Int
    let title, description, category: String
    let price, discountPercentage, rating: Double
    let stock: Int
    let tags: [String]
    let weight: Int
    let returnPolicy: String
    let minimumOrderQuantity: Int
    let thumbnail: String
    let images: [String]

    var firstImage : String {
        images.first ?? Constants.randomImage
    }
    
    static var mock : Product {
        Product(
            id: 1,
            title: "Apple",
            description: "This is a mock descriptin and can be quite long you know so prepare yourself for the banger to be handled",
            category: "Music",
            price: 999.99,
            discountPercentage: 12,
            rating: 4,
            stock: 88,
            tags: ["Nice"],
            weight: 10,
            returnPolicy: "No returns",
            minimumOrderQuantity: 4,
            thumbnail: "Apple products",
            images: [Constants.randomImage , Constants.randomImage]
        )
    }
}



struct ProductRow : Identifiable {
    let id : String = UUID().uuidString
    let title : String
    let products : [Product]
}
