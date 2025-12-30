//
//  ShareDetailsDelegate.swift
//  QSC_SwiftUI
//
//  Created by FIT on 25/09/2025.
//

import Foundation

protocol ShareDetailsDelegate {
    func onSendSymbolTradesSummaryObject(data: [SendSymbolTradesSummaryObjectUIModel])
    func onGetSymbolTradesFullObject(data: [GetSymbolTradesFullObjectUIModel])
}
