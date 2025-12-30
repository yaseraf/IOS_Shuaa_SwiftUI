//
//  LoginUseCase.swift
//  QSC_SwiftUI
//
//  Created by FIT on 20/08/2025.
//

import Foundation
protocol MenuUseCaseProtocol{
    func getAlertByUserCode(requestModel: GetAlertByUserCodeRequestModel, completion: @escaping(Result<[GetAlertByUserCodeUIModel], NetworkError>) -> Void) async
    func getStatementOfAccount(requestModel: GetStatementOfAccountRequestModel, completion: @escaping(Result<[GetStatementOfAccountUIModel], NetworkError>) -> Void) async
    func getGroupedStatementOfAccount(requestModel: GetStatementOfAccountRequestModel, completion: @escaping(Result<[GetStatementOfAccountUIModel], NetworkError>) -> Void) async
    func AddAlerts(requestModel: AddAlertsRequestModel, completion: @escaping(Result<AddAlertsUIModel, NetworkError>) -> Void) async
    func AddAlert(requestModel: AddAlertRequestModel, completion: @escaping(Result<AddAlertUIModel, NetworkError>) -> Void) async
    func ModifyAlert(requestModel: ModifyAlertRequestModel, completion: @escaping(Result<ModifyAlertUIModel, NetworkError>) -> Void) async
    func DeleteAlert(requestModel: DeleteAlertRequestModel, completion: @escaping(Result<DeleteAlertUIModel, NetworkError>) -> Void) async
}

class MenuUseCase {
    private let repository: MenuRepositoryProtocol
    init(repository: MenuRepositoryProtocol = MenuRepository()) {
        self.repository = repository
    }
}

extension MenuUseCase: MenuUseCaseProtocol {
    func getAlertByUserCode(requestModel: GetAlertByUserCodeRequestModel, completion: @escaping (Result<[GetAlertByUserCodeUIModel], NetworkError>) -> Void) async {
        let route = MenuRoute.GetAlertByUserCode(requestModel: requestModel)
        await repository.getAlertsByUserCode(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel =    responseModel.map({
                    GetAlertByUserCodeUIModel.mapToUIModel($0)
                    
                })
                completion(.success(uiModel))
                
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func getStatementOfAccount(requestModel: GetStatementOfAccountRequestModel, completion: @escaping (Result<[GetStatementOfAccountUIModel], NetworkError>) -> Void) async {
        let route = MenuRoute.getStatementOfAccount(requestModel: requestModel)
        await repository.getStatementOfAccount(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel =    responseModel.map({
                   GetStatementOfAccountUIModel.mapToUIModel($0)

                })
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func getGroupedStatementOfAccount(requestModel: GetStatementOfAccountRequestModel, completion: @escaping (Result<[GetStatementOfAccountUIModel], NetworkError>) -> Void) async {
        let route = MenuRoute.getGroupedStatementOfAccount(requestModel: requestModel)
        await repository.getGroupedStatementOfAccount(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel =    responseModel.map({
                   GetStatementOfAccountUIModel.mapToUIModel($0)

                })
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func DeleteAlert(requestModel: DeleteAlertRequestModel, completion: @escaping (Result<DeleteAlertUIModel, NetworkError>) -> Void) async {
        let route = MenuRoute.deleteAlert(requestModel: requestModel)
        await repository.deleteAlert(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = DeleteAlertUIModel.mapToUIModel(responseModel)

                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func ModifyAlert(requestModel: ModifyAlertRequestModel, completion: @escaping (Result<ModifyAlertUIModel, NetworkError>) -> Void) async {
        let route = MenuRoute.modifyAlert(requestModel: requestModel)
        await repository.modifyAlert(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = ModifyAlertUIModel.mapToUIModel(responseModel)

                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func AddAlert(requestModel: AddAlertRequestModel, completion: @escaping (Result<AddAlertUIModel, NetworkError>) -> Void) async {
        let route = MenuRoute.addAlert(requestModel: requestModel)
        await repository.addAlert(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = AddAlertUIModel.mapToUIModel(responseModel)

                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func AddAlerts(requestModel: AddAlertsRequestModel, completion: @escaping (Result<AddAlertsUIModel, NetworkError>) -> Void) async {
        let route = MenuRoute.addAlerts(requestModel: requestModel)
        await repository.addAlerts(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = AddAlertsUIModel.mapToUIModel(responseModel)

                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

}
