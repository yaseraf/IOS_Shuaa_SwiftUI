//
//  LoginUseCase.swift
//  QSC_SwiftUI
//
//  Created by FIT on 20/08/2025.
//

import Foundation
protocol PortfolioUseCaseProtocol{
    func getPortfolio(requestModel: GetPortfolioRequestModel, completion: @escaping(Result<GetPortfolioUIModel, NetworkError>) -> Void) async
    func getUserAccounts(requestModel: GetUserAccountsRequestModel, completion: @escaping(Result<[GetUserAccountsUIModel], NetworkError>) -> Void) async
}

class PortfolioUseCase {
    private let repository: PortfolioRepositoryProtocol
    init(repository: PortfolioRepositoryProtocol = PortfolioRepository()) {
        self.repository = repository
    }
}

extension PortfolioUseCase: PortfolioUseCaseProtocol {
    func getPortfolio(requestModel: GetPortfolioRequestModel, completion: @escaping (Result<GetPortfolioUIModel, NetworkError>) -> Void) async {
        let route = PortfolioRoute.getPortfolio(requestModel: requestModel)
        await repository.getPortfolio(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetPortfolioUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func getUserAccounts(requestModel: GetUserAccountsRequestModel, completion: @escaping (Result<[GetUserAccountsUIModel], NetworkError>) -> Void) async {
        let route = PortfolioRoute.getUserAccounts(requestModel: requestModel)
        await repository.getUserAccounts(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel =    responseModel.map({
                   GetUserAccountsUIModel.mapToUIModel($0)

                })
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

}
