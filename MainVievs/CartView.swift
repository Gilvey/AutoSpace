//
//  CartView.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 17.04.24.
//

import SwiftUI

struct CartView: View {
    
   @StateObject var viewModel: CartViewModel
    @State private var isAlertPresented = false
    var alertMessage = "Заказ отправлен"
    
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.positions) {
                    position in
                    PositionCell(position: position)
                }
            }.listStyle(.plain)
                .navigationTitle("Корзина")
            
            
            VStack {
                HStack {
                    Text("Итого:")
                        .fontWeight(.bold)
                    Spacer()
                    Text("\(self.viewModel.cost) $")
                        .fontWeight(.bold)
                    
                }.padding()
                
                
                HStack {
                    Button {
                        viewModel.positions.removeAll()
                    } label: {
                        Text("Отменить")
                            .font(.title3)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(24)
                            .foregroundColor(.white)
                        
                    }
                    
                    Spacer()
                    
                    Button {
                    self.viewModel.setOrder()
                        viewModel.positions.removeAll()
                        isAlertPresented.toggle()
                    } label: {
                        Text("Заказать")
                            .font(.title3)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("autoblue"))
                            .cornerRadius(24)
                            .foregroundColor(.white)
                        
                        
                        
                    }
                    
                }.padding()
            }.padding()
            .background(Color.alpha1)
            .cornerRadius(25)
            .padding(.horizontal,8)
            .alert(alertMessage, isPresented: $isAlertPresented) { Button { } label: {
                Text("OK")
            }
            }
        }
    }
}

#Preview {
    CartView(viewModel: CartViewModel.shared)
}
