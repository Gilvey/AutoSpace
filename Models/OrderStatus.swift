//
//  OrderStatus.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 10.05.24.
//

import Foundation


enum OrderStatus: String, CaseIterable {
    case new = "Новый"
    case cooking = "Готовится"
    case delivery = "Доставляется"
    case completed = "Выполнен"
    case canceled = "Отменен"
}
