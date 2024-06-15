//
//  ProductCell.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 17.04.24.
//

import SwiftUI
import UIKit


 
struct ProductCell: View {
    
    var product: Product
    
    @State var uiImage = UIImage(named: "bg")
    
    var body: some View {
        VStack {
            
            Image(uiImage: uiImage!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 170, height: 168)
                .cornerRadius(20)
              
            
            HStack {
                Text(product.title)
                    .font(.custom("AvenirNext-regular", size: 15))
                Spacer()
                
                Text("\(product.price) $.")
                    .font(.custom("AvenirNext-bold", size: 15))
                    
            }.padding(.bottom, 2)
            
            
            
        }.frame(width: screen.width * 0.40, height: screen.height * 0.23)
            .padding(11)
            .background(Color.alpha1)
            .cornerRadius(23)
            .shadow(radius: 5)
            .onAppear {
                StorageService.shared.downloadProductImage(id: self.product.id) { result in
                    switch result {
                        
                    case .success(let data):
                        if let img = UIImage(data: data) {
                            self.uiImage = img
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        
                    }
                }
            }
            
            
    }
}

#Preview {
    ProductCell(product: Product(id: "1", title: "Фильтр", imageUrl: "bg", price: 41, discription: "Filtron /Ford Transit"))
}
