//
//  AuthRepository.swift
//  QSC_SwiftUI
//
//  Created by FIT on 20/08/2025.
//

import Foundation
protocol HomeRepositoryProtocol {
    func GetAllProfilesLookupsByUserCode (route:HomeRoute, completion: @escaping(Result<[GetAllProfilesLookupsByUserCodeResponseModel], NetworkError>) -> Void) async
    func GetMarketWatchByProfileID(route: HomeRoute, completion: @escaping(Result<[GetMarketWatchByProfileIDResponseModel], NetworkError>) -> Void) async
    func GetExchangeSummary(route: HomeRoute, completion: @escaping(Result<[GetExchangeSummaryResponseModel], NetworkError>) -> Void) async
    func getUserAccounts(route: HomeRoute, completion: @escaping(Result<[GetUserAccountsResponseModel], NetworkError>) -> Void) async
    func getAllPushNotificationsByUser(route: HomeRoute, completion: @escaping(Result<[GetAllPushNotificationsByUserResponseModel], NetworkError>) -> Void) async
    func getAlertsByUserCode(route: HomeRoute, completion: @escaping(Result<[GetAlertByUserCodeResponseModel], NetworkError>) -> Void) async
    func GetAllMarketNewsBySymbol(route: HomeRoute, completion: @escaping(Result<[GetAllMarketNewsBySymbolResponseModel], NetworkError>) -> Void) async
    func GetMarketIndicies(route: HomeRoute, completion: @escaping(Result<[GetMarketIndiciesResponseModel], NetworkError>) -> Void) async
    func Reports(route: HomeRoute, completion: @escaping(Result<[String], NetworkError>) -> Void) async
    func GetRequiredUserDocuments(route: HomeRoute, completion: @escaping(Result<GetRequiredUserDocumentsResponseModel, NetworkError>) -> Void) async
    func GetExpiredAttachment(route: HomeRoute, completion: @escaping(Result<GetExpiredAttachmentResponseModel, NetworkError>) -> Void) async
    func UpdateIdValidity3(route: HomeRoute, completion: @escaping(Result<Bool, NetworkError>) -> Void) async
    func UploadClientDocument(route: HomeRoute, completion: @escaping(Result<Bool, NetworkError>) -> Void) async
    func SubmitCrmRequestRamz2(route: HomeRoute, completion: @escaping(Result<SubmitCrmRequestRamzResponseModel, NetworkError>) -> Void) async
    func SubmitShareTransferReq(route: HomeRoute, completion: @escaping(Result<Bool, NetworkError>) -> Void) async
    func GetB2bRequests(route: HomeRoute, completion: @escaping(Result<[GetB2bRequestResponseModel], NetworkError>) -> Void) async
    func GetShareTransferLogWithDetails(route: HomeRoute, completion: @escaping(Result<[GetShareTransferLogWithDetailsResponseModel], NetworkError>) -> Void) async
    func GetExpectedProfitLossSec(route: HomeRoute, completion: @escaping(Result<[GetExpectedProfitLossSecResponseModel], NetworkError>) -> Void) async
    func GetAccountTransferInfo(route: HomeRoute, completion: @escaping(Result<GetAccountTransferInfoResponseModel, NetworkError>) -> Void) async
    func GetBankIBAN(route: HomeRoute, completion: @escaping(Result<[GetBankIBANResponseModel], NetworkError>) -> Void) async
    func GetMarketWatchBySectorID(route: HomeRoute, completion: @escaping(Result<[GetMarketWatchBySectorIDResponseModel], NetworkError>) -> Void) async
    func ChangesPassword(route: HomeRoute, completion: @escaping(Result<ChangesPasswordResponseModel, NetworkError>) -> Void) async
    func AddMarketWatchProfileName(route: HomeRoute, completion: @escaping(Result<AddMarketWatchProfileNameResponseModel, NetworkError>) -> Void) async
    func AddMarketWatchProfileSymbols(route: HomeRoute, completion: @escaping(Result<[AddMarketWatchProfileSymbolsResponseModel], NetworkError>) -> Void) async
    func DeleteMarketWatchProfileSymbols(route: HomeRoute, completion: @escaping(Result<DeleteMarketWatchProfileSymbolsResponseModel, NetworkError>) -> Void) async

}

class HomeRepository: HomeRepositoryProtocol {
    func GetExchangeSummary(route: HomeRoute, completion: @escaping (Result<[GetExchangeSummaryResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: [GetExchangeSummaryResponseModel].self, completion: completion).requestApi()
    }
    func getUserAccounts(route: HomeRoute, completion: @escaping (Result<[GetUserAccountsResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetUserAccountsResponseModel].self, completion: completion).requestApi()
    }
    func GetAllProfilesLookupsByUserCode(route: HomeRoute, completion: @escaping (Result<[GetAllProfilesLookupsByUserCodeResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: [GetAllProfilesLookupsByUserCodeResponseModel].self, completion: completion).requestApi()
    }
    func GetMarketWatchByProfileID(route: HomeRoute, completion: @escaping (Result<[GetMarketWatchByProfileIDResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetMarketWatchByProfileIDResponseModel].self, completion: completion).requestApi()
    }
    func getAllPushNotificationsByUser(route: HomeRoute, completion: @escaping (Result<[GetAllPushNotificationsByUserResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetAllPushNotificationsByUserResponseModel].self, completion: completion).requestApi()
    }
    func getAlertsByUserCode(route: HomeRoute, completion: @escaping (Result<[GetAlertByUserCodeResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetAlertByUserCodeResponseModel].self, completion: completion).requestApi()
    }
    func GetAllMarketNewsBySymbol(route: HomeRoute, completion: @escaping (Result<[GetAllMarketNewsBySymbolResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetAllMarketNewsBySymbolResponseModel].self, completion: completion).requestApi()
    }
    func GetMarketIndicies(route: HomeRoute, completion: @escaping (Result<[GetMarketIndiciesResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetMarketIndiciesResponseModel].self, completion: completion).requestApi()
    }
    func Reports(route: HomeRoute, completion: @escaping (Result<[String], NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: [String].self, completion: completion).requestApi()
    }
    func GetRequiredUserDocuments(route: HomeRoute, completion: @escaping (Result<GetRequiredUserDocumentsResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: GetRequiredUserDocumentsResponseModel.self, completion: completion).requestApi()
    }
    func GetExpiredAttachment(route: HomeRoute, completion: @escaping (Result<GetExpiredAttachmentResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: GetExpiredAttachmentResponseModel.self, completion: completion).requestApi()
    }
    func UpdateIdValidity3(route: HomeRoute, completion: @escaping (Result<Bool, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: Bool.self, completion: completion).requestApi()
    }
    func UploadClientDocument(route: HomeRoute, completion: @escaping (Result<Bool, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: Bool.self, completion: completion).requestApi()
    }
    func SubmitCrmRequestRamz2(route: HomeRoute, completion: @escaping (Result<SubmitCrmRequestRamzResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: SubmitCrmRequestRamzResponseModel.self, completion: completion).requestApi()
    }
    func SubmitShareTransferReq(route: HomeRoute, completion: @escaping (Result<Bool, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: Bool.self, completion: completion).requestApi()
    }
    func GetB2bRequests(route: HomeRoute, completion: @escaping (Result<[GetB2bRequestResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: [GetB2bRequestResponseModel].self, completion: completion).requestApi()
    }
    func GetShareTransferLogWithDetails(route: HomeRoute, completion: @escaping (Result<[GetShareTransferLogWithDetailsResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: [GetShareTransferLogWithDetailsResponseModel].self, completion: completion).requestApi()
    }
    func GetExpectedProfitLossSec(route: HomeRoute, completion: @escaping (Result<[GetExpectedProfitLossSecResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: [GetExpectedProfitLossSecResponseModel].self, completion: completion).requestApi()
    }
    func GetAccountTransferInfo(route: HomeRoute, completion: @escaping (Result<GetAccountTransferInfoResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: GetAccountTransferInfoResponseModel.self, completion: completion).requestApi()
    }
    func GetBankIBAN(route: HomeRoute, completion: @escaping (Result<[GetBankIBANResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: [GetBankIBANResponseModel].self, completion: completion).requestApi()
    }
    func GetMarketWatchBySectorID(route: HomeRoute, completion: @escaping (Result<[GetMarketWatchBySectorIDResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetMarketWatchBySectorIDResponseModel].self, completion: completion).requestApi()
    }
    func ChangesPassword(route: HomeRoute, completion: @escaping (Result<ChangesPasswordResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: ChangesPasswordResponseModel.self, completion: completion).requestApi()
    }
    func AddMarketWatchProfileName(route: HomeRoute, completion: @escaping (Result<AddMarketWatchProfileNameResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: AddMarketWatchProfileNameResponseModel.self, completion: completion).requestApi()
    }
    func AddMarketWatchProfileSymbols(route: HomeRoute, completion: @escaping (Result<[AddMarketWatchProfileSymbolsResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [AddMarketWatchProfileSymbolsResponseModel].self, completion: completion).requestApi()
    }
    func DeleteMarketWatchProfileSymbols(route: HomeRoute, completion: @escaping (Result<DeleteMarketWatchProfileSymbolsResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: DeleteMarketWatchProfileSymbolsResponseModel.self, completion: completion).requestApi()
    }
}
