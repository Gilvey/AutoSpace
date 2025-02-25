//
//  AdminOrdersView.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 10.05.24.
//

import SwiftUI

struct AdminOrdersView: View {
    
    @StateObject var viewModel = AdminOrdersViewModel()
    @State private var isDetailViewPresented = false
    @State private var isAuthviewPresented = false
    @State private var isShowAddProductView = false
    @State private var buttonAngle: Double = 0
    @State private var isSwiped = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    AuthService.shared.signOut()
                    isAuthviewPresented.toggle()
                } label: {
                    Text("Выход")
                        .font(.title3)
                        .foregroundColor(.red)
                }.padding(.horizontal, 8)
                Spacer()
                
                Button {
                    isShowAddProductView.toggle()
                } label: {
                    Text("Добавить")
                        .font(.title3)
                        .padding(8)
                        .foregroundColor(.autoblue)
                }.padding(.horizontal)
                
                Spacer()
                
                Button {
                    withAnimation(.interpolatingSpring(stiffness: 10, damping: 5)) {
                        viewModel.getOrders()
                        buttonAngle -= 360
                        isSwiped.toggle()
                    }
                    viewModel.getOrders()
                    buttonAngle -= 360
                } label: {
                   Image(systemName: "gobackward")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.autoblue)
                        .padding(.horizontal, 20)
                        .rotationEffect(.degrees(buttonAngle))
                        
                        
                    
                
                }
                
            }
            Divider()
            List() {
                ForEach(viewModel.orders, id: \.id) {
                    order in
                    OrderCell(order: order)
                        .swipeActions(edge: .trailing) {
                            
                            Button(role: .destructive){
                                viewModel.delete(at: order)
                            } label: {
                                Image(systemName: "trash")
                            }.tint(.red)

                        
                            
                            Button{
                                //
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }.tint(.blue)
                        }
                    
                    
                        .onTapGesture {
                            viewModel.currentOrder = order
                            isDetailViewPresented.toggle()
                        }
                }.onDelete(perform: viewModel.removeOrder)
                
                
                
            }.listStyle(.plain)
                .onAppear(){
                    viewModel.getOrders()
                }.sheet(isPresented: $isDetailViewPresented, content: {
                    let orderViewModel = OrderDetailViewModel(order: viewModel.currentOrder)
                    OrderDetailView(viewModel: orderViewModel)
                })
                .refreshable {
                    viewModel.getOrders()
                }
        }.fullScreenCover(isPresented: $isAuthviewPresented) {
            AuthView()
        }.sheet(isPresented: $isShowAddProductView, content: {
            AddProductView()
        })
    }
}

#Preview {
    AdminOrdersView()
}
