//
//  AuthRepository.swift
//  QSC_SwiftUI
//
//  Created by FIT on 20/08/2025.
//

import Foundation
protocol PortfolioRepositoryProtocol {
    func getPortfolio(route: PortfolioRoute, completion: @escaping(Result<GetPortfolioResponseModel, NetworkError>) -> Void) async
    func getUserAccounts(route: PortfolioRoute, completion: @escaping(Result<[GetUserAccountsResponseModel], NetworkError>) -> Void) async
}

class PortfolioRepository: PortfolioRepositoryProtocol {
    func getPortfolio(route: PortfolioRoute, completion: @escaping (Result<GetPortfolioResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: GetPortfolioResponseModel.self, completion: completion).requestApi()
    }
    func getUserAccounts(route: PortfolioRoute, completion: @escaping (Result<[GetUserAccountsResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetUserAccountsResponseModel].self, completion: completion).requestApi()
    }
}
