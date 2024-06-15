//
//  CartViewModel.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 21.04.24.
//

import Foundation


class CartViewModel: ObservableObject {
    
    static let shared = CartViewModel()
    
    private init() { }
    
   @Published var positions: [Position] = []
   var cost: Int {
        var sum = 0
        for price in positions {
            sum += price.cost
        }
       return sum
    }
    
  func setOrder() {
      DataBaseService.shared.setOrder(order: Order(id: UUID().uuidString, userID: AuthService.shared.currentUser!.uid, positions: self.positions, date: Date(), status: "в обработке")) { result in
            switch result {
                
            case .success(_):
                print("Заказ загружен")
            case .failure(let error):
                print("Ошибка отправки данных \(error.localizedDescription)")
            }
        }
    } 
    
    func addPosition(_ position: Position) {
        self.positions.append(position)
    }
}
