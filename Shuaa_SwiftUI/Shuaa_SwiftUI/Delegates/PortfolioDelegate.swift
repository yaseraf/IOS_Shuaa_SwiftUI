//
//  PortfolioDelegate.swift
//  QSC_SwiftUI
//
//  Created by FIT on 28/09/2025.
//

import Foundation

protocol PortfolioDelegate {
    func onPortfolioReceive(data: [GetPortfolioSignalRUIModel])
}
