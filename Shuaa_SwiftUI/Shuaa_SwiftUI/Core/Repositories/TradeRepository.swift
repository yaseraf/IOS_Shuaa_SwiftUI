//
//  AuthRepository.swift
//  QSC_SwiftUI
//
//  Created by FIT on 20/08/2025.
//

import Foundation
protocol TradeRepositoryProtocol {
    func GetAllMarketWatchBySymbol(route: TradeRoute, completion: @escaping(Result<GetAllMarketWatchBySymbolResponseModel, NetworkError>) -> Void) async
    func GetRiskManagement(route: TradeRoute, completion: @escaping(Result<GetRiskManagementResponseModel, NetworkError>) -> Void) async
    func CalculatesShares(route: TradeRoute, completion: @escaping(Result<String, NetworkError>) -> Void) async
}

class TradeRepository: TradeRepositoryProtocol {
    func GetAllMarketWatchBySymbol(route: TradeRoute, completion: @escaping (Result<GetAllMarketWatchBySymbolResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: GetAllMarketWatchBySymbolResponseModel.self, completion: completion).requestApi()
    }
    
    func GetRiskManagement(route: TradeRoute, completion: @escaping (Result<GetRiskManagementResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: GetRiskManagementResponseModel.self, completion: completion).requestApi()
    }
    
    func CalculatesShares(route: TradeRoute, completion: @escaping (Result<String, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: String.self, completion: completion).requestApi()
    }
}
