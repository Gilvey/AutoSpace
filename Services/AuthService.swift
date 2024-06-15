//
//  AuthService.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 27.04.24.
//

import Foundation
import FirebaseAuth



class AuthService {
    
    static let shared = AuthService()
    
    private init() { }
    
    private let auth = Auth.auth()
    
     var currentUser: User? {
        auth.currentUser
    }
    
    func signOut() {
       try! auth.signOut()
    }
    
    func signUp(email: String,
                password: String,
                completion:
                @escaping (Result<User, Error>) -> ()) {
        auth.createUser(withEmail: email, password: password) {
            result, error in
            
            if let result = result {
                let mainUser = MainUser(id: result.user.uid,
                                        name: "",
                                        phone: 0,
                                        adress: "")
                DataBaseService.shared.setProfile(user: mainUser) {
                    resultdb in
                    switch resultdb {
                        
                    case .success(_):
                        completion(.success(result.user))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
                
            }
            if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func signIn(email: String,
                password: String,
                completion:
                @escaping (Result<User, Error>) -> ()) {
        auth.signIn(withEmail: email, password: password) {
            result, error in
            
            if let result = result {
                completion(.success(result.user))
            }
            if let error = error {
                completion(.failure(error))
            }
            
            
        }
    }
}
