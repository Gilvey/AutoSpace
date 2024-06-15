//
//  ProfileView.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 17.04.24.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var isAvaAlertPresented = false
    @State private var isQuitAlertPresented = false
    @State private var isAuthViewPresented = false
    
    @StateObject var viewModel: ProfileViewModel
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image("profile")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                    .onTapGesture {
                        isAvaAlertPresented.toggle()
                    }
                    .confirmationDialog("Откуда взять фотографию", isPresented: $isAvaAlertPresented) {
                        Button{
                            print("Библиотека")
                        } label: {
                            Text("Из галереи")
                        }
                        Button{
                            print("Камера")
                        } label: {
                            Text("Камера")
                        }
                        
                    }
                
                VStack {
                    TextField("Имя пользователя", text: $viewModel.profile.name)
                    
                    
                    HStack {
                        Text("+375 ")
                        TextField("Номер телефона", value: $viewModel.profile.phone, format: .number)
                    }
                }.padding()
            }
            VStack(alignment: .leading, spacing: 9 ){
                Text("Адрес доставки:")
                    .bold()
                TextField("Адрес", text: $viewModel.profile.adress)
            }.padding(.horizontal, 12)
            List {
                if viewModel.orders.count == 0 {
                    Text("Ваши заказы будут тут")
                } else {
                    ForEach(viewModel.orders, id: \.id) {
                        order in
                        OrderCell(order: order)
                    }
                }
                
            }.listStyle(.plain)
            
            Button{
                isQuitAlertPresented.toggle()
            } label: {
                Text("Выйти")
                    .font(.title3)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(24)
                    .foregroundColor(.white)
                    .padding(.horizontal, 150)
            }.confirmationDialog("Вы уверены, что хотите выйти?", isPresented: $isQuitAlertPresented) {
                Button{
                    isAuthViewPresented.toggle()
                } label: {
                    Text("Да")
                }
            }
           
            .onAppear{
                self.viewModel.getProfile()
                self.viewModel.getOrders()
            }
            Spacer()
        }.onSubmit {
            viewModel.setProfile()
        }
        .fullScreenCover(isPresented: $isAuthViewPresented, onDismiss: nil, content: {
            AuthView()
        })
    }
}


#Preview {
    ProfileView(viewModel: ProfileViewModel(profile: MainUser(id: "", name: "Николай Гильвей", phone: 296791754, adress: "г. Минск, ул. Одоевского 87, кв. 28")))
}
//viewModel: ProfileViewModel(profile: MainUser(id: "", name: "Николай Гильвей", phone: 2967914, adress: "г. Минск, ул. Одоевского 87, кв. 28"))
