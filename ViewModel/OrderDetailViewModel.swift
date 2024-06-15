//
//  OrderDetailViewModel.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 10.05.24.
//

import Foundation

class OrderDetailViewModel: ObservableObject {
    
    @Published var order: Order
    @Published var user: MainUser = MainUser(id: "", name: "", phone: 12, adress: "")
    
    init(order: Order) {
        self.order = order
    }
    
    func getUserData() {
        DataBaseService.shared.getProfile(by: order.userID) { result in
            switch result {
                
            case .success(let user):
                self.user = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
