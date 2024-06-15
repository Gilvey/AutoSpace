//
//  ContentView.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 15.04.24.
//

import SwiftUI

struct AuthView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var isAuth = true
    @State private var confirmPassword = ""
    @State private var isTabVievShowed = false
    @State private var isAlertPresented = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            
            
            
            Text(isAuth ? "Авторизация" : "Регистрация")
                .padding(isAuth ? 20 : 17)
                .padding(.horizontal, 45)
                .background(Color("alpha"))
                .cornerRadius(20)
                
            
            
            
            
            
            VStack{
                TextField("Введите логин", text: $email)
                    .padding()
                    .padding(.horizontal, 35)
                    .background(Color("alpha"))
                    .cornerRadius(15)
                    .padding(5)
                
                SecureField("Введите пароль", text: $password)
                    .padding()
                    .padding(.horizontal, 35)
                    .background(Color("alpha"))
                    .cornerRadius(15)
                
                if !isAuth {
                    SecureField("Повторите пароль", text: $confirmPassword)
                        .padding()
                        .padding(.horizontal, 35)
                        .background(Color("alpha"))
                        .cornerRadius(15)
                }
                    
                Button {
                    if isAuth {
                        AuthService.shared.signIn(email: email, password: password) { result in
                            switch result {
                        
                            case .success(_):
                                self.isTabVievShowed.toggle()
                            case .failure(let error):
                                alertMessage = "Ошибка авторизации: \(error.localizedDescription)"
                                isAlertPresented.toggle()
                            }
                            
                        }
                        
                        
                    
                    } else {
                        
                        guard password == confirmPassword else {
                            self.alertMessage = "Пароли не совпадают"
                            self.isAlertPresented.toggle()
                            return
                        }
                        AuthService.shared.signUp(email: self.email, password: self.password) {
                            result in
                            switch result {
                                
                            case .success(let user):
                                self.alertMessage = "Вы зарегистрировались с email \(String(describing: user.email))"
                                self.email = ""
                                self .password = ""
                                self.confirmPassword = ""
                                self.isAuth.toggle()
                                self.isAlertPresented.toggle()
                                
                            case .failure(let error):
                                self.alertMessage = "Ошибка регистрации \(error.localizedDescription). Попробуйте еще раз"
                                self.isAlertPresented.toggle()
                                
                            }
                        }
                    
                    }
                    
                } label: {
                    Text(isAuth ? "Войти" : "Зарегистрироваться")
                        .padding()
                        .padding(.horizontal, isAuth ? 140 : 82)
                        .background(Color("autoblue"))
                        .cornerRadius(15)
                        .foregroundColor(.white)
                        .padding(.top, 10)
                       
                }
                
                Button {
                    isAuth.toggle()
                } label: {
                    Text(isAuth ? "Ещё не с нами?" : "Уже есть аккаунт!")
                        .padding()
                        
                
                       
                }
                
            }.padding(.top, isAuth ? 30 : 21)
                .alert(alertMessage, isPresented: $isAlertPresented) { Button { } label: {
                    Text("OK")
                }
                }
                
            
            
            
            
        }
        .padding()
        .background(Image("bg").resizable()
            .frame(width: 500, height: 300)
            .offset(y: -300))
        .animation(Animation.easeInOut(duration: 0.3), value: isAuth)
        .fullScreenCover(isPresented: $isTabVievShowed)
        {
            if AuthService.shared.currentUser?.uid == "AlCYAPDEd6f2E0ZrMYTqyf47SoL2" {
                AdminOrdersView()
            } else {
                let tabBarViewModel = MainTabBarViewModel(user: AuthService.shared.currentUser!)
               TabBar(viewModel: tabBarViewModel)
            }
            
        }
        
    }
}

#Preview {
    AuthView()
}
