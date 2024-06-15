//
//  ProductDetailVeiwModel.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 20.04.24.
//

import Foundation
import UIKit

class ProductDetailVeiwModel: ObservableObject {
    
    @Published var product: Product
    @Published var shopLocations = ["Минск", "Гродно", "Витебск", "Брест", "Гомель", "Могилев"]
    @Published var count = 0
    @Published var image = UIImage(named: "bg")!
    
    init(product: Product) {
        self.product = product
    }
    
    func markPrice(_ location: String) -> Int {
        switch location {
            
        case "Минск": return Int(Double(product.price) * 1.11)
            
        case "Гродно": return Int(Double(product.price) * 1.19)
            
        case "Витебск": return Int(Double(product.price) * 1.09)
            
        case "Брест": return Int(Double(product.price) * 1.01)
            
        case "Гомель": return Int(Double(product.price) * 1.30)
            
        case "Могилев": return Int(Double(product.price) * 1.25)
        default:
            return 0
        }
    }
    func getImage() {
        StorageService.shared.downloadProductImage(id: product.id) { result in
            switch result{
                
            case .success(let data):
                if let image = UIImage(data: data) {
                    self.image = image
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
