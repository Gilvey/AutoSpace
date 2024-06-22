//
//  OrderCell.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 9.05.24.
//


import SwiftUI
import Foundation

struct OrderCell: View {

    
    
    var order: Order
    
    
    var body: some View {
        HStack {
            Text("\(order.date.formatted(date: .numeric, time: .shortened))")
                .frame(width: 140)
            Text("\(order.cost) $")
                .bold()
                .frame(width: 90)
            Text("\(order.status)")
                .frame(width: 120)
                .foregroundColor(.green)
        }
    }
}

#Preview {
    OrderCell(order: Order(userID: "111", date: Date(), status: "Доставляется"))
}
