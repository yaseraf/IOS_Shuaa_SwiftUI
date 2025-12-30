//
//  AuthRepository.swift
//  QSC_SwiftUI
//
//  Created by FIT on 20/08/2025.
//

import Foundation
protocol MenuRepositoryProtocol {
    func getAlertsByUserCode(route: MenuRoute, completion: @escaping(Result<[GetAlertByUserCodeResponseModel], NetworkError>) -> Void) async
    func getStatementOfAccount(route: MenuRoute, completion: @escaping(Result<[GetStatementOfAccountResponseModel], NetworkError>) -> Void) async
    func getGroupedStatementOfAccount(route: MenuRoute, completion: @escaping(Result<[GetStatementOfAccountResponseModel], NetworkError>) -> Void) async
    func addAlerts(route: MenuRoute, completion: @escaping(Result<AddAlertsResponseModel, NetworkError>) -> Void) async
    func addAlert(route: MenuRoute, completion: @escaping(Result<AddAlertResponseModel, NetworkError>) -> Void) async
    func modifyAlert(route: MenuRoute, completion: @escaping(Result<ModifyAlertResponseModel, NetworkError>) -> Void) async
    func deleteAlert(route: MenuRoute, completion: @escaping(Result<DeleteAlertResponseModel, NetworkError>) -> Void) async
    func UsersLogOff(route: MenuRoute, completion: @escaping(Result<EmptyResponseModel, NetworkError>) -> Void) async
}

class MenuRepository: MenuRepositoryProtocol {
    func getAlertsByUserCode(route: MenuRoute, completion: @escaping (Result<[GetAlertByUserCodeResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetAlertByUserCodeResponseModel].self, completion: completion).requestApi()
    }
    func getStatementOfAccount(route: MenuRoute, completion: @escaping (Result<[GetStatementOfAccountResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetStatementOfAccountResponseModel].self, completion: completion).requestApi()
    }
    func getGroupedStatementOfAccount(route: MenuRoute, completion: @escaping (Result<[GetStatementOfAccountResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetStatementOfAccountResponseModel].self, completion: completion).requestApi()
    }
    func deleteAlert(route: MenuRoute, completion: @escaping (Result<DeleteAlertResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: DeleteAlertResponseModel.self, completion: completion).requestApi()
    }
    
    func modifyAlert(route: MenuRoute, completion: @escaping (Result<ModifyAlertResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: ModifyAlertResponseModel.self, completion: completion).requestApi()
    }
    
    func addAlert(route: MenuRoute, completion: @escaping (Result<AddAlertResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: AddAlertResponseModel.self, completion: completion).requestApi()
    }
    
    func addAlerts(route: MenuRoute, completion: @escaping (Result<AddAlertsResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: AddAlertsResponseModel.self, completion: completion).requestApi()
    }
    func UsersLogOff(route: MenuRoute, completion: @escaping (Result<EmptyResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: EmptyResponseModel.self, completion: completion).requestApi()
    }
}
