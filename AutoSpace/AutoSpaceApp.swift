//
//  AutoSpaceApp.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 15.04.24.
//11111111

import SwiftUI
import Firebase
import FirebaseAuth

let screen = UIScreen.main.bounds

@main
    struct AutoSpaceApp: App {
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            if let user = AuthService.shared.currentUser {
                if user.uid == "AlCYAPDEd6f2E0ZrMYTqyf47SoL2" {
                    AdminOrdersView()
                } else {
                    let viewModel = MainTabBarViewModel(user: user)
                    TabBar(viewModel: viewModel)
                }
            } else {
                LunchView()
            }
        }
    }
    class AppDelegate: NSObject, UIApplicationDelegate {
        
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
           
            FirebaseApp.configure()	
            print("ok")
            return true
        }
    }
}
