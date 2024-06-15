//
//  Product.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 17.04.24.
//

import Foundation
import FirebaseFirestore


struct Product {
    
    
    
    
    
    var id: String
    var title: String
    var imageUrl: String = ""
    var price: Int
    var discription: String

//  var ordersCount: Int
    var isRecommended: Bool = false
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["title"] = self.title
        repres["price"] = self.price
        repres["description"] = self.discription
        repres["isRecommended"] = self.isRecommended
        return repres
    }
    
    internal init(id: String = UUID().uuidString, title: String, imageUrl: String = "", price: Int, discription: String, isRecommended: Bool = false) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.price = price
        self.discription = discription
        self.isRecommended = isRecommended
    }
    
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        
        guard let id = data["id"] as? String else { return nil }
        guard let title = data["title"] as? String else { return nil }
        guard let price = data["price"] as? Int else { return nil }
        guard let discription = data["description"] as? String else { return nil }
        guard let isRecommended = data["isRecommended"] as? Bool else { return nil }
        
        self.id = id
        self.title = title
        self.price = price
        self.discription = discription
        self.isRecommended = isRecommended
    }
    
}

