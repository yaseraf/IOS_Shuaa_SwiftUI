//
//  LoginUseCase.swift
//  QSC_SwiftUI
//
//  Created by FIT on 20/08/2025.
//

import Foundation
protocol TradeUseCaseProtocol{
    func GetAllMarketWatchBySymbol(requestModel: GetAllMarketWatchBySymbolRequestModel, completion: @escaping(Result<GetAllMarketWatchBySymbolUIModel, NetworkError>) -> Void) async
    func GetRiskManagement(requestModel: GetRiskManagementRequestModel, completion: @escaping(Result<GetRiskManagementUIModel, NetworkError>) -> Void) async
    func CalculatesShares(requestModel: CalculatesSharesRequestModel, completion: @escaping(Result<String, NetworkError>) -> Void) async
}

class TradeUseCase {
    private let repository: TradeRepositoryProtocol
    init(repository: TradeRepositoryProtocol = TradeRepository()) {
        self.repository = repository
    }
}

extension TradeUseCase: TradeUseCaseProtocol {
    func GetAllMarketWatchBySymbol(requestModel: GetAllMarketWatchBySymbolRequestModel, completion: @escaping (Result<GetAllMarketWatchBySymbolUIModel, NetworkError>) -> Void) async {
        let route = TradeRoute.GetAllMarketWatchBySymbol(requestModel: requestModel)
        await repository.GetAllMarketWatchBySymbol(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetAllMarketWatchBySymbolUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetRiskManagement(requestModel: GetRiskManagementRequestModel, completion: @escaping (Result<GetRiskManagementUIModel, NetworkError>) -> Void) async {
        let route = TradeRoute.GetRiskManagement(requestModel: requestModel)
        await repository.GetRiskManagement(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetRiskManagementUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func CalculatesShares(requestModel: CalculatesSharesRequestModel, completion: @escaping (Result<String, NetworkError>) -> Void) async {
        let route = TradeRoute.CalculatesShares(requestModel: requestModel)
        await repository.CalculatesShares(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let uiModel = responseModel
                
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
