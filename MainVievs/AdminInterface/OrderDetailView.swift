//
//  OrderDetailView.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 10.05.24.
//

import SwiftUI

struct OrderDetailView: View {
    
    @StateObject var viewModel: OrderDetailViewModel
    
    var statuses: [String] {
        var status = [String]()
        for sts in OrderStatus.allCases {
            status.append(sts.rawValue)
        }
        return status
    }
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8 ){
            
            Text("\(viewModel.user.name)")
            Text("+ 375 \(viewModel.user.phone)")
            Text("\(viewModel.user.adress)")
            
            Picker(selection: $viewModel.order.status) {
                ForEach(statuses, id: \.self) { status in
                    Text(status)
                }
            } label: {
                Text("Статус заказа")
            }.onChange(of: viewModel.order.status) { newValue, oldValue in
                DataBaseService.shared.setOrder(order: viewModel.order) { result in
                    switch result {
                        
                    case .success(let order):
                        print(order.status)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }.pickerStyle(.segmented)

            
            List{
                ForEach(viewModel.order.positions, id: \.id) {
                    position in
                    PositionCell(position: position)
                }
                Text("Итого: \(viewModel.order.cost) $").bold()
            }
           
        }.padding()
            .onAppear() {
                viewModel.getUserData()
            }
    }
}

#Preview {
    OrderDetailView(viewModel: OrderDetailViewModel(order: Order(userID:"111", date: Date(), status: "Готов")))
}
