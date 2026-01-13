//
//  HomeCoorindatorProtocol.swift
//  Shuaa


import Foundation
import FlagAndCountryCode

protocol HomeCoordinatorProtocol: AnyObject,Coordinator {
    func openHomeScene()
    func openMarketOverviewScene()
    func openTopStocksScene()
}
