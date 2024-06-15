//
//  DataBaseService.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 30.04.24.
//

import Foundation
import FirebaseFirestore

class DataBaseService {
    static let shared = DataBaseService()
    
    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {return db.collection("Users")}
    
    private var orderRef: CollectionReference {return db.collection("Orders")}
    
    private var productsRef: CollectionReference { return db.collection("Products") }
    
    private init() { }
    
    
    func getProducts(completion: @escaping (Result<[Product], Error>) -> ()) {
        self.productsRef.getDocuments { qSnap, error in
            
            guard let qSnap = qSnap else {
                if let error = error {
                    
                    completion(.failure(error))
                }
                return
            }
            let docs = qSnap.documents
            
            var products = [Product]()
            
            for doc in docs {
                
                guard let product = Product(doc: doc) else { return }
                
                products.append(product)
                
            }
            completion(.success(products))
            
        }
    }
    
    func getOrders(by userID: String?, completion: @escaping (Result<[Order], Error>) -> ()) {
        self.orderRef.getDocuments {
            qSnap, error in
            if let qSnap = qSnap {
                var orders = [Order]()
                for doc in qSnap.documents {
                    if let userID = userID {
                        if let order = Order(doc: doc), order.userID == userID {
                            orders.append(order)
                        }
                    } else { //ветка Админа
                        if let order = Order(doc: doc) {
                            orders.append(order)
                        }
                    }
                }
                completion(.success(orders))
                } else { if let error = error {
                completion(.failure(error))
            }
            }
        }
    }
    
    func setOrder(order: Order, completion: @escaping (Result<Order, Error>) -> ()) {
        orderRef.document(order.id).setData(order.representation) {
            error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.setPositions(to: order.id, positions: order.positions) { result in
                    switch result {
                        
                    case .success(let positions):
                        print(positions.count)
                        completion(.success(order))
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func getPositions(by orderID: String, completion: @escaping (Result<[Position], Error>) -> ()) {
        let positionsRef = orderRef.document(orderID).collection("positions")
        
        positionsRef.getDocuments { qSnap, error in
            if let qSnap = qSnap {
                var positions = [Position]()
                for doc in qSnap.documents {
                    if let position = Position(doc: doc) {
                        positions.append(position)
                    }
                    
                }
                completion(.success(positions))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
     
    func setPositions(to orderID: String, positions: [Position], completion: @escaping (Result<[Position], Error>) -> ()) {
        
        let positionRef = orderRef.document(orderID).collection("positions")
        
        for position in positions {
            positionRef.document(position.id).setData(position.representation)
        }
        completion(.success(positions))
        
    }
    
    
    func setProfile(user: MainUser, completion: @escaping (Result<MainUser, Error>) -> ()) {
        usersRef.document(user.id).setData(user.representation) {
            error in
            if let error = error {
                completion(.failure(error))
                
            }
            else {
                completion(.success(user))
            }
        }
    }
    /// Получение профиля
    /// - Parameters:
    ///   - userID: id пользователя
    ///   - competion: результаты получения пользователя из firebase
    func getProfile(by userID: String? = nil, competion: @escaping (Result<MainUser, Error>) -> ()) {
        usersRef.document(userID != nil ? userID! : AuthService.shared.currentUser!.uid).getDocument { docSnapshot, error in
            guard let snap = docSnapshot else { return }
            guard let data = snap.data() else { return }
            guard let userName = data["name"] as? String else { return }
            guard let userId = data["id"] as? String else { return }
            guard let userPhone = data["phone"] as? Int else { return }
            guard let userAdress = data["adress"] as? String else { return }
            
            let user = MainUser(id: userId, name: userName, phone: userPhone, adress: userAdress)
            
            competion(.success(user))
        }
    }
    
    func setProduct(product: Product, image: Data, completion: @escaping (Result<Product, Error>) -> ()){
        
        StorageService.shared.apload(id: product.id, image: image) { result in
            switch result {
                
            case .success(let sizeInfo):
                print("\(sizeInfo)")
                
                self.productsRef.document(product.id).setData(product.representation) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(product))
                    }
                }
                
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
