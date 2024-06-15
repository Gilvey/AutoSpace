//
//  MainUser.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 30.04.24.
//

import Foundation


struct MainUser: Identifiable {
    var id: String
    var name: String
    var phone: Int
    var adress: String

    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["name"] = self.name
        repres["phone"] = self.phone
        repres["adress"] = self.adress
        return repres
    }
}
