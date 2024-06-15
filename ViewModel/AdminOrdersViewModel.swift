//
//  AdminOrdersViewModel.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 10.05.24.
//

import Foundation
import FirebaseFirestore


class AdminOrdersViewModel: ObservableObject{
    
    @Published var orders = [Order]()
    
    var currentOrder = Order(userID: "111", date: Date(), status: "В обработке")
    
    func removeOrder(at offsets: IndexSet) {
        let db = Firestore.firestore()
        let oldOrders = offsets.map { orders[$0] }
        
        oldOrders.forEach { order in
            db.collection("Orders").document(order.id).delete()
        }
        getOrders()
    }
    
    func getOrders() {
        DataBaseService.shared.getOrders(by: nil) { result in
            switch result {
                
            case .success(let orders):
                self.orders = orders
                for (index, order) in self.orders.enumerated() {
                    DataBaseService.shared.getPositions(by: order.id) { result in
                        switch result {
                            
                        case .success(let positions):
                            self.orders[index].positions = positions
                            print(self.orders[index].cost)

                        case .failure(let error):
                            print(error.localizedDescription)

                        }
                    }
                }
                print("Всего заказов: \(orders.count)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
