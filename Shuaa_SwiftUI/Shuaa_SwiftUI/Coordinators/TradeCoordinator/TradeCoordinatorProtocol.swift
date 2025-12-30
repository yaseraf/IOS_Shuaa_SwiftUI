//
//  HomeCoorindatorProtocol.swift
//  mahfazati
//
//  Created by Mohammmed on 10/08/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation
import FlagAndCountryCode

protocol TradeCoordinatorProtocol: AnyObject,Coordinator {
    func openOrderListScene()
    func openTradeScene(stock: GetCompaniesLookupsUIModel, typeOfTrade: TypeOfTrade, isEditOrder: Bool, orderDetails: OrderListUIModel)
    func openQuantityCalculatorScene(delegate: QuantityCalculatorDelegate, lastTradePrice: String)
    func openTradeConfrimationScene(shares: String, price: String, value: String, expiryDate: String, selectedTypeOfTrade:TypeOfTrade, orderPreview: OrderPreviewModel, riskManagementData: GetRiskManagementUIModel, isEditOrder: Bool)
    func openOrderDetailsScene(orderDetails: OrderListUIModel, delegate: OrderDetailsDelegate)
}
