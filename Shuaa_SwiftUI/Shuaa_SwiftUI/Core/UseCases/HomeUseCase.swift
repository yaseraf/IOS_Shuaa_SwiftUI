//
//  LoginUseCase.swift
//  QSC_SwiftUI
//
//  Created by FIT on 20/08/2025.
//

import Foundation
protocol HomeUseCaseProtocol{
    func GetAllProfilesLookupsByUserCode(requestModel: GetAllProfilesLookupsByUserCodeRequestModel , completion: @escaping(Result<[GetAllProfilesLookupsByUserCodeUIModel], NetworkError>) -> Void) async
    func GetMarketWatchByProfileID(requestModel: GetMarketWatchByProfileIDRequestModel , completion: @escaping(Result<[GetMarketWatchByProfileIDUIModel], NetworkError>) -> Void) async
    func GetExchangeSummary(requestModel: GetExchangeSummaryRequestModel , completion: @escaping(Result<[GetExchangeSummaryUIModel], NetworkError>) -> Void) async
    func getUserAccounts(requestModel: GetUserAccountsRequestModel, completion: @escaping(Result<[GetUserAccountsUIModel], NetworkError>) -> Void) async
    func getAllPushNotificationsByUser(requestModel: GetAllPushNotificationsByUserRequestModel, completion: @escaping(Result<[NotificationUIModel], NetworkError>) -> Void) async
    func getAlertByUserCode(requestModel: GetAlertByUserCodeRequestModel, completion: @escaping(Result<[GetAlertByUserCodeUIModel], NetworkError>) -> Void) async
    func GetAllMarketNewsBySymbol(requestModel: GetAllMarketNewsBySymbolRequestModel, completion: @escaping(Result<[GetAllMarketNewsBySymbolUIModel], NetworkError>) -> Void) async
    func GetMarketIndicies(requestModel: GetMarketIndiciesRequestModel, completion: @escaping(Result<[GetMarketIndiciesUIModel], NetworkError>) -> Void) async
    func Reports(reportsType : String , completion: @escaping(Result<[DailyReportsUIModel ], NetworkError>) -> Void) async
    func GetRequiredUserDocuments(requestModel: GetRequiredUserDocumentsRequestModel, completion: @escaping(Result<GetRequiredUserDocumentsUIModel, NetworkError>) -> Void) async
    func GetExpiredAttachment(requestModel: GetExpiredAttachmentRequestModel, completion: @escaping(Result<GetExpiredAttachmentUIModel, NetworkError>) -> Void) async
    func UpdateIdValidity3(requestModel: UpdateIdValidity3RequestModel, completion: @escaping(Result<Bool, NetworkError>) -> Void) async
    func UploadClientDocument(requestModel: UploadClientDocumentsRequestModel, completion: @escaping(Result<Bool, NetworkError>) -> Void) async
    func SubmitCrmRequestRamz2(requestModel: SubmitCrmRequestRamzRequestModel, completion: @escaping(Result<SubmitCrmRequestRamzUIModel, NetworkError>) -> Void) async
    func SubmitShareTransferReq(requestModel: SubmitShareTransferReqRequestModel, completion: @escaping(Result<Bool, NetworkError>) -> Void) async
    func GetB2bRequests(requestModel: GetB2bRequestsRequestModel, completion: @escaping(Result<[GetB2bRequestUIModel], NetworkError>) -> Void) async
    func GetShareTransferLogWithDetails(requestModel: GetShareTransferLogWithDetailsRequestModel, completion: @escaping(Result<[GetShareTransferLogWithDetailsUIModel], NetworkError>) -> Void) async
    func GetExpectedProfitLossSec(requestModel: GetExpectedProfitLossSecRequestModel, completion: @escaping(Result<[GetExpectedProfitLossSecUIModel], NetworkError>) -> Void) async
    func GetAccountTransferInfo(requestModel: GetAccountTransferInfoRequestModel, completion: @escaping(Result<GetAccountTransferInfoUIModel, NetworkError>) -> Void) async
    func GetBankIBAN(requestModel: GetBankIBANRequestModel, completion: @escaping(Result<[GetBankIBANUIModel], NetworkError>) -> Void) async
    func GetMarketWatchBySectorID(requestModel: GetMarketWatchBySectorIDRequestModel, completion: @escaping(Result<[GetMarketWatchBySectorIDUIModel], NetworkError>) -> Void) async
    func ChangesPassword(requestModel: ChangesPasswordRequestModel, completion: @escaping(Result<ChangesPasswordUIModel, NetworkError>) -> Void) async
    func AddMarketWatchProfileName(requestModel: AddMarketWatchProfileNameRequestModel, completion: @escaping(Result<AddMarketWatchProfileNameUIModel, NetworkError>) -> Void) async
    func AddMarketWatchProfileSymbols(requestModel: AddMarketWatchProfileSymbolsRequestModel, completion: @escaping(Result<[AddMarketWatchProfileSymbolsUIModel], NetworkError>) -> Void) async
    func DeleteMarketWatchProfileSymbols(requestModel: DeleteMarketWatchProfileSymbolsRequestModel, completion: @escaping(Result<DeleteMarketWatchProfileSymbolsUIModel, NetworkError>) -> Void) async
}

class HomeUseCase {
    private let repository: HomeRepositoryProtocol
    init(repository: HomeRepositoryProtocol = HomeRepository()) {
        self.repository = repository
    }
}

extension HomeUseCase: HomeUseCaseProtocol {
    func GetExchangeSummary(requestModel: GetExchangeSummaryRequestModel, completion: @escaping (Result<[GetExchangeSummaryUIModel], NetworkError>) -> Void) async {
        let route = HomeRoute.GetExchangeSummary(requestModel: requestModel)
        await repository.GetExchangeSummary(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let uiModel = responseModel.map({
                    GetExchangeSummaryUIModel.mapToUIModel($0)
                })
                
                completion(.success(uiModel))
                
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func getUserAccounts(requestModel: GetUserAccountsRequestModel, completion: @escaping (Result<[GetUserAccountsUIModel], NetworkError>) -> Void) async {
        let route = HomeRoute.getUserAccounts(requestModel: requestModel)
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
    
    func GetMarketWatchByProfileID(requestModel: GetMarketWatchByProfileIDRequestModel, completion: @escaping (Result<[GetMarketWatchByProfileIDUIModel], NetworkError>) -> Void) async {
        let route = HomeRoute.GetMarketWatchByProfileID(requestModel: requestModel)
        await repository.GetMarketWatchByProfileID(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let uiModel = responseModel.map({
                    GetMarketWatchByProfileIDUIModel.mapToUIModel($0)
                })
                
                completion(.success(uiModel))
                
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetAllProfilesLookupsByUserCode(requestModel: GetAllProfilesLookupsByUserCodeRequestModel, completion: @escaping (Result<[GetAllProfilesLookupsByUserCodeUIModel], NetworkError>) -> Void) async {
        let route = HomeRoute.GetAllProfilesLookupsByUserCode(requestModel: requestModel)
        await repository.GetAllProfilesLookupsByUserCode(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let uiModel = responseModel.map({
                    GetAllProfilesLookupsByUserCodeUIModel.mapToUIModel($0)
                })
                
                completion(.success(uiModel))
                
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func getAllPushNotificationsByUser(requestModel: GetAllPushNotificationsByUserRequestModel, completion: @escaping (Result<[NotificationUIModel], NetworkError>) -> Void) async {
        let route = HomeRoute.getAllPushNotificationsByUser(requestModel: requestModel)
        await repository.getAllPushNotificationsByUser(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel =    responseModel.map({
                    NotificationUIModel.mapToUIModel($0)
                    
                })
                completion(.success(uiModel))
                
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func getAlertByUserCode(requestModel: GetAlertByUserCodeRequestModel, completion: @escaping (Result<[GetAlertByUserCodeUIModel], NetworkError>) -> Void) async {
        let route = HomeRoute.getAlertByUserCode(requestModel: requestModel)
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
    
    func GetAllMarketNewsBySymbol(requestModel: GetAllMarketNewsBySymbolRequestModel, completion: @escaping (Result<[GetAllMarketNewsBySymbolUIModel], NetworkError>) -> Void) async {
        let route = HomeRoute.GetAllMarketNewsBySymbol(requestModel: requestModel)
        await repository.GetAllMarketNewsBySymbol(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel =    responseModel.map({
                    GetAllMarketNewsBySymbolUIModel.mapToUIModel($0)
                })
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetMarketIndicies(requestModel: GetMarketIndiciesRequestModel, completion: @escaping (Result<[GetMarketIndiciesUIModel], NetworkError>) -> Void) async {
        let route = HomeRoute.GetMarketIndicies(requestModel: requestModel)
        await repository.GetMarketIndicies(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel =    responseModel.map({
                    GetMarketIndiciesUIModel.mapToUIModel($0)
                })
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func Reports(reportsType : String , completion: @escaping (Result<[DailyReportsUIModel], NetworkError>) -> Void) async {
        let route =  HomeRoute.DailyReports(reportsType: reportsType)
        await repository.Reports(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let uiModel = responseModel.map({
                    DailyReportsUIModel.mapToUIModel($0, reportsType )})
                
                completion(.success(uiModel))
                
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetRequiredUserDocuments(requestModel: GetRequiredUserDocumentsRequestModel, completion: @escaping (Result<GetRequiredUserDocumentsUIModel, NetworkError>) -> Void) async {
        let route =  HomeRoute.GetRequiredUserDocuments(requestModel: requestModel)
        await repository.GetRequiredUserDocuments(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let uiModel = GetRequiredUserDocumentsUIModel.mapToUIModel(responseModel)

                completion(.success(uiModel))
                
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetExpiredAttachment(requestModel: GetExpiredAttachmentRequestModel, completion: @escaping (Result<GetExpiredAttachmentUIModel, NetworkError>) -> Void) async {
        let route =  HomeRoute.GetExpiredAttachment(requestModel: requestModel)
        await repository.GetExpiredAttachment(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let uiModel = GetExpiredAttachmentUIModel.mapToUIModel(responseModel)

                completion(.success(uiModel))
                
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func UpdateIdValidity3(requestModel: UpdateIdValidity3RequestModel, completion: @escaping (Result<Bool, NetworkError>) -> Void) async {
        let route =  HomeRoute.UpdateIdValidity3(requestModel: requestModel)
        await repository.UpdateIdValidity3(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let uiModel = responseModel

                completion(.success(uiModel))
                
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func UploadClientDocument(requestModel: UploadClientDocumentsRequestModel, completion: @escaping (Result<Bool, NetworkError>) -> Void) async {
        let route =  HomeRoute.UploadClientDocument(requestModel: requestModel)
        await repository.UploadClientDocument(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let uiModel = responseModel

                completion(.success(uiModel))
                
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func SubmitCrmRequestRamz2(requestModel: SubmitCrmRequestRamzRequestModel, completion: @escaping (Result<SubmitCrmRequestRamzUIModel, NetworkError>) -> Void) async {
        let route =  HomeRoute.SubmitCrmRequestRamz2(requestModel: requestModel)
        await repository.SubmitCrmRequestRamz2(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let uiModel = SubmitCrmRequestRamzUIModel.mapToUIModel(responseModel)

                completion(.success(uiModel))
                
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func SubmitShareTransferReq(requestModel: SubmitShareTransferReqRequestModel, completion: @escaping (Result<Bool, NetworkError>) -> Void) async {
        let route =  HomeRoute.SubmitShareTransferReq(requestModel: requestModel)
        await repository.SubmitShareTransferReq(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let uiModel = responseModel

                completion(.success(uiModel))
                
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetB2bRequests(requestModel: GetB2bRequestsRequestModel, completion: @escaping (Result<[GetB2bRequestUIModel], NetworkError>) -> Void) async {
        let route =  HomeRoute.GetB2bRequests(requestModel: requestModel)
        await repository.GetB2bRequests(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let uiModel = responseModel.map({
                    GetB2bRequestUIModel.mapToUIModel($0)
                })
                
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetShareTransferLogWithDetails(requestModel: GetShareTransferLogWithDetailsRequestModel, completion: @escaping (Result<[GetShareTransferLogWithDetailsUIModel], NetworkError>) -> Void) async {
        let route =  HomeRoute.GetShareTransferLogWithDetails(requestModel: requestModel)
        await repository.GetShareTransferLogWithDetails(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let uiModel = responseModel.map({
                    GetShareTransferLogWithDetailsUIModel.mapToUIModel($0)
                })
                
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }


    
    func GetExpectedProfitLossSec(requestModel: GetExpectedProfitLossSecRequestModel, completion: @escaping (Result<[GetExpectedProfitLossSecUIModel], NetworkError>) -> Void) async {
        let route =  HomeRoute.GetExpectedProfitLossSec(requestModel: requestModel)
        await repository.GetExpectedProfitLossSec(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let uiModel = responseModel.map({
                    GetExpectedProfitLossSecUIModel.mapToUIModel($0)
                })
                
                completion(.success(uiModel))
                
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetAccountTransferInfo(requestModel: GetAccountTransferInfoRequestModel, completion: @escaping (Result<GetAccountTransferInfoUIModel, NetworkError>) -> Void) async {
        let route =  HomeRoute.GetAccountTransferInfo(requestModel: requestModel)
        await repository.GetAccountTransferInfo(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let uiModel = GetAccountTransferInfoUIModel.mapToUIModel(responseModel)
                
                completion(.success(uiModel))
                
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetBankIBAN(requestModel: GetBankIBANRequestModel, completion: @escaping (Result<[GetBankIBANUIModel], NetworkError>) -> Void) async {
        let route =  HomeRoute.GetBankIBAN(requestModel: requestModel)
        await repository.GetBankIBAN(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let uiModel = responseModel.map({
                    GetBankIBANUIModel.mapToUIModel($0)
                })
                
                completion(.success(uiModel))
                
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

    func GetMarketWatchBySectorID(requestModel: GetMarketWatchBySectorIDRequestModel, completion: @escaping (Result<[GetMarketWatchBySectorIDUIModel], NetworkError>) -> Void) async {
        let route = HomeRoute.GetMarketWatchBySectorID(requestModel: requestModel)
        await repository.GetMarketWatchBySectorID(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = responseModel.map({
                    GetMarketWatchBySectorIDUIModel.mapToUIModel($0)
                })
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func ChangesPassword(requestModel: ChangesPasswordRequestModel, completion: @escaping (Result<ChangesPasswordUIModel, NetworkError>) -> Void) async {
        let route = HomeRoute.ChangesPassword(requestModel: requestModel)
        await repository.ChangesPassword(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = ChangesPasswordUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

    func AddMarketWatchProfileName(requestModel: AddMarketWatchProfileNameRequestModel, completion: @escaping (Result<AddMarketWatchProfileNameUIModel, NetworkError>) -> Void) async {
        let route = HomeRoute.AddMarketWatchProfileName(requestModel: requestModel)
        await repository.AddMarketWatchProfileName(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = AddMarketWatchProfileNameUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func AddMarketWatchProfileSymbols(requestModel: AddMarketWatchProfileSymbolsRequestModel, completion: @escaping (Result<[AddMarketWatchProfileSymbolsUIModel], NetworkError>) -> Void) async {
        let route = HomeRoute.AddMarketWatchProfileSymbols(requestModel: requestModel)
        await repository.AddMarketWatchProfileSymbols(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = responseModel.map({
                    AddMarketWatchProfileSymbolsUIModel.mapToUIModel($0)
                })
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func DeleteMarketWatchProfileSymbols(requestModel: DeleteMarketWatchProfileSymbolsRequestModel, completion: @escaping (Result<DeleteMarketWatchProfileSymbolsUIModel, NetworkError>) -> Void) async {
        let route = HomeRoute.DeleteMarketWatchProfileSymbols(requestModel: requestModel)
        await repository.DeleteMarketWatchProfileSymbols(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = DeleteMarketWatchProfileSymbolsUIModel.mapToUIModel(responseModel)

                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
}
