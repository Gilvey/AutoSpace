//
//  PositionCell.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 21.04.24.
//

import SwiftUI
import os

struct PositionCell: View {
    
    let position: Position
    
    @State var uiImage = UIImage(named: "bg")
    
    var body: some View {
        HStack {
            Image(uiImage: uiImage!)
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
            .onAppear {
                StorageService.shared.downloadProductImage(id: self.position.product.id) { result in
                    switch result {
                    
                    case .success(let data):
                        if let image = UIImage(data: data) {
                            self.uiImage = image
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            
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
