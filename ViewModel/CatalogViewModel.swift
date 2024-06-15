//
//  CatalogViewModel.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 20.04.24.
//

import Foundation


class CatalogViewModel: ObservableObject {
    
    static let shared = CatalogViewModel()
    
    
    
    
    @Published var carParts = [Product(id: "1", title: "Фильтр", imageUrl: "bg", price: 41, discription: "Filtron / Ford Transit"),
                               Product(id: "2", title: "Ступица", imageUrl: "bg", price: 320, discription: "Fuchs / Mondeo"),
                               Product(id: "3", title: "Датчик ABS", imageUrl: "bg", price: 15, discription: "Sasic / Toyota"),
                               Product(id: "4", title: "Пов. кулак", imageUrl: "bg", price: 160, discription: "Boshc / Audi"),
                               Product(id: "5", title: "Диск торм.", imageUrl: "bg", price: 70, discription: "FAE / Opel"),
                               Product(id: "6", title: "Щетки старт.", imageUrl: "bg", price: 65, discription: "Metaco/Ford Transit"),
                               Product(id: "7", title: "Топл. фильт.", imageUrl: "bg", price: 90, discription: "LPR / Renought"),
    ]
    
    @Published var popularProducts = [Product(id: "1", title: "Фильтр", imageUrl: "bg", price: 41, discription: "Filtron / Ford Transit",                                                          isRecommended: true),
                                                 Product(id: "2", title: "Ступица", imageUrl: "bg", price: 320, discription: "Fuchs / Mondeo", isRecommended: true),
                                                 Product(id: "3", title: "Датчик ABS", imageUrl: "bg", price: 15, discription: "Sasic / Toyota", isRecommended: true),
                                                 Product(id: "4", title: "Пов. кулак", imageUrl: "bg", price: 160, discription: "Boshc / Audi", isRecommended: true),
                                                 Product(id: "5", title: "Диск торм.", imageUrl: "bg", price: 70, discription: "FAE / Opel", isRecommended: true),
                                                 Product(id: "6", title: "Щетки старт.", imageUrl: "bg", price: 65, discription: "Metaco/Ford Transit", isRecommended: true),
                                                 Product(id: "7", title: "Топл. фильт.", imageUrl: "bg", price: 90, discription: "LPR / Renought", isRecommended: true),
                                                 Product(title: "Ступичный подшипник", price: 60, discription: "Mersedes", isRecommended: true)
                                      ]
    
    
    
    
    
    func getProducts() {
        DataBaseService.shared.getProducts { result in
            print("РАбота1")
            switch result {
                
            case .success(let products):
                self.carParts = products
                print("\(self.carParts)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
//        self.popularProducts = self.carParts.filter { $0.isRecommended }
       }
    
//         func getPopularProducts() -> () {
//        var result: [Product] = []
//        for item in self.carParts {
//            if item.isRecommended {
//                result.append(item)
//            }
//        }
//        
//        self.popularProducts = result
//        print("Популярные продукты отработало")
//    }
    
}
