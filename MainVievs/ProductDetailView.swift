//
//  ProductDetailView.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 20.04.24.
//

import SwiftUI
import UIKit

struct ProductDetailView: View {
    
    @StateObject var viewModel: ProductDetailVeiwModel
    @State private var location = "Минск"
    @State private var count = 1
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        
        VStack(alignment: .leading ){
            Image(uiImage: self.viewModel.image)
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: 300)
            
            HStack {
                Text(self.viewModel.product.title)
                    .font(.title2.bold())
                Spacer()
                Text("\(viewModel.markPrice(self.location)) $")
                    .font(.title2)
            }.padding(.horizontal)
                
            Text(viewModel.product.discription)
                .padding(.horizontal)
                .padding(.vertical, 8)
        
            
            VStack(alignment: .leading) {
                Text("Марка авто")
                Picker("Локация", selection: $location) {
                    ForEach(viewModel.shopLocations, id: \.self) { mark in
                        Text(mark)
                    }
                }.pickerStyle(.segmented)
            } .padding(8)
            
            HStack {
            
                Stepper("Количество", value: $count , in: 1...10)
                
                Text("\(self.count)")
                    .padding()
                    .background(Color.autoblue)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .padding(.leading, 24)
            }.padding(.horizontal)
            
            Button {
                var position = Position(id: UUID().uuidString,
                                        product: viewModel.product, count: self.count)
                
                position.product.price = viewModel.markPrice(location)
                
                CartViewModel.shared.addPosition(position)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("В корзину")
                    .font(.title3)
                    .padding()
                    .padding(.horizontal, 82)
                    .background(Color("autoblue"))
                    .cornerRadius(15)
                    .foregroundColor(.white)
                    .padding(.top, 10)
                    .padding(.leading, 58)
            }.onAppear {
                print("nen")
                self.viewModel.getImage()
            }
            
            Spacer()
        }
        
    }
}

#Preview {
    ProductDetailView(viewModel: ProductDetailVeiwModel(product: Product(id: "1", title: "Фильтр", imageUrl: "part", price: 41, discription: "Filtron /Ford Transit")))
}
