//
//  OrderDetailsDelegate.swift
//  QSC_SwiftUI
//
//  Created by FIT on 09/10/2025.
//

import Foundation

protocol OrderDetailsDelegate {
    func onCancelOrder()
    func onEditOrder(order: OrderListUIModel)
}
