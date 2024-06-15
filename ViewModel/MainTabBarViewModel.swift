//
//  MainTabBarViewModel.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 27.04.24.
//

import Foundation
import FirebaseAuth

class MainTabBarViewModel: ObservableObject {
    @Published var user: User
    init(user: User) {
        self.user = user
    }
}
