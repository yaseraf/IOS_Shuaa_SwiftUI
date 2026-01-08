//
//  HomeCoorindatorProtocol.swift
//  Shuaa


import Foundation
import FlagAndCountryCode

protocol HomeCoordinatorProtocol: AnyObject,Coordinator {
    func openHomeScene()
    func openSettingsScene()
    func openMarketOverviewScene()
    func openTopStocksScene()
}
