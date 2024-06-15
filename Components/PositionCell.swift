//
//  PositionCell.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 21.04.24.
//

import SwiftUI

struct PositionCell: View {
    
    let position: Position
    
    var body: some View {
        HStack {
            Image(self.position.product.imageUrl)
                .resizable()
                .frame(width: 50,height: 50)
            Text(self.position.product.title)
                .fontWeight(.bold)
            Spacer()
            Text("\(self.position.count) шт.")
                .font(.title3)
            Text("\(self.position.cost) $")
                .font(.title3)
                .frame(width: 65, alignment: .trailing)
                
        }.padding(15)
            .background(Color.alpha1)
            .cornerRadius(20)
            
    }
}

#Preview {
    PositionCell(position: Position(
        id: UUID().uuidString,
        product: Product(id: UUID().uuidString,
                         title: "Гайка колеса",
                         imageUrl: "part",
                         price: 17,
                         discription: "Universal / VAG"),
        count: 3))
}
