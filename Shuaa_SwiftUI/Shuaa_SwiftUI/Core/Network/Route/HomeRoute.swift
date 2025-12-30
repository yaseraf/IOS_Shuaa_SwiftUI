//
//  AuthRoute.swift
//  QSC
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
enum HomeRoute:APITargetType{
    
//    case updateInvestmentType(requestModel: UpdateInvestmentTypeRequestModel)
    case GetAllProfilesLookupsByUserCode(requestModel: GetAllProfilesLookupsByUserCodeRequestModel)
    case GetMarketWatchByProfileID(requestModel: GetMarketWatchByProfileIDRequestModel)
    case GetExchangeSummary(requestModel: GetExchangeSummaryRequestModel)
    case getUserAccounts(requestModel: GetUserAccountsRequestModel)
    case getAllPushNotificationsByUser(requestModel: GetAllPushNotificationsByUserRequestModel)
    case getAlertByUserCode(requestModel: GetAlertByUserCodeRequestModel)
    case GetAllMarketNewsBySymbol(requestModel: GetAllMarketNewsBySymbolRequestModel)
    case GetMarketIndicies(requestModel: GetMarketIndiciesRequestModel)
    case DailyReports(reportsType : String)
    case GetRequiredUserDocuments(requestModel: GetRequiredUserDocumentsRequestModel)
    case GetExpiredAttachment(requestModel: GetExpiredAttachmentRequestModel)
    case UpdateIdValidity3(requestModel: UpdateIdValidity3RequestModel)
    case UploadClientDocument(requestModel: UploadClientDocumentsRequestModel)
    case SubmitCrmRequestRamz2(requestModel: SubmitCrmRequestRamzRequestModel)
    case SubmitShareTransferReq(requestModel: SubmitShareTransferReqRequestModel)
    case GetB2bRequests(requestModel: GetB2bRequestsRequestModel)
    case GetShareTransferLogWithDetails(requestModel: GetShareTransferLogWithDetailsRequestModel)
    case GetExpectedProfitLossSec(requestModel: GetExpectedProfitLossSecRequestModel)
    case GetAccountTransferInfo(requestModel: GetAccountTransferInfoRequestModel)
    case GetBankIBAN(requestModel: GetBankIBANRequestModel)
    case GetMarketWatchBySectorID(requestModel: GetMarketWatchBySectorIDRequestModel)
    case ChangesPassword(requestModel: ChangesPasswordRequestModel)
    case AddMarketWatchProfileName(requestModel: AddMarketWatchProfileNameRequestModel)
    case AddMarketWatchProfileSymbols(requestModel: AddMarketWatchProfileSymbolsRequestModel)
    case DeleteMarketWatchProfileSymbols(requestModel: DeleteMarketWatchProfileSymbolsRequestModel)

    var baseURL: URL{
        get{
            return URL(string: AppEnvironmentController.currentNetworkConfiguration.basePath
                       + path)!
        }
    }
    
    var headers: [String : String]{
        get{
            switch self {
                
            default:
                return  NetworkUtility.getHeader(.withoutToken)
                
            }
        }
    }
    
    func getCurrentDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyyHHmmss"
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        return dateString
    }

    
    var path: String{
        switch self {
        case .GetAllProfilesLookupsByUserCode:
            return "MarektWServices/GetAllProfilesLookupsByUSerCode/\(KeyChainController().webCode ?? "")"
        case .GetMarketWatchByProfileID:
            return "MarektWServices/GetMarketWatchByProfileID/\(UserDefaultController().profileID ?? "")/\(KeyChainController().webCode ?? "")"
        case .GetExchangeSummary:
            return "MarektWServices/GetExchangeSummary/\(KeyChainController().webCode ?? "")"
        case .getUserAccounts:
            return "GeneralWServices/GetUserAccounts/\(KeyChainController().webCode ?? "")"
        case .getAllPushNotificationsByUser:
            return "NotificationWServices/GetAllPushNotificationsByUser/\(KeyChainController().webCode ?? "")"
        case .getAlertByUserCode:
            return "NotificationWServices/GetAlertByUSerCode/\(KeyChainController().webCode ?? "")"
        case .GetAllMarketNewsBySymbol:
            return "GeneralWServices/GetAllMarketNewsBySymbol/\(UserDefaultController().selectedSymbol ?? "")/\(KeyChainController().webCode ?? "")"
        case .GetMarketIndicies:
            return "MarektWServices/GetMarketIndicies/\(UserDefaultController().exchangeID ?? "")/\(KeyChainController().webCode ?? "")"
        case .DailyReports(let ReportsType) :
            return "GeneralWServices/GetDailyReports/\(ReportsType)"
        case .GetRequiredUserDocuments:
            return "GeneralWServices/GetRequiredUserDocuments2/\(KeyChainController().webCode ?? "")/\(KeyChainController().mainClientID ?? "")"
        case .GetExpiredAttachment:
            return "GeneralWServices/GetExpiredAttachment/\(KeyChainController().webCode ?? "")/\(KeyChainController().mainClientID ?? "")"
        case .UpdateIdValidity3:
            return "GeneralWServices/UpdateIdValidity3"
        case .UploadClientDocument:
            return "GeneralWServices/UploadClientDocuments"
        case .SubmitCrmRequestRamz2:
            return "FinancialWServices/SubmitCrmRequestRamz2"
        case .SubmitShareTransferReq:
            return "FinancialWServices/SubmitShareTransferReq"
        case .GetB2bRequests:
            return "FinancialWServices/GetB2bRequests/\(KeyChainController().webCode ?? "")/\(KeyChainController().mainClientID ?? "")"
        case .GetShareTransferLogWithDetails:
            return "FinancialWServices/GetShareTransferLogWithDetails/-1/\(KeyChainController().webCode ?? "")/\(KeyChainController().mainClientID ?? "")"
        case .GetExpectedProfitLossSec:
            return "FinancialWServices/GetExpectedProfitLossSec/\(KeyChainController().mainClientID ?? "")/\(KeyChainController().clientID ?? "")/\(KeyChainController().webCode ?? "")/\(getCurrentDateString())/\(KeyChainController().brokerID ?? "")/\(UserDefaultController().exchangeID ?? "")"
        case .GetAccountTransferInfo:
            return "FinancialWServices/GetAccountTransferInfo"
        case .GetBankIBAN:
            return "FinancialWServices/GetBankIBAN/\(KeyChainController().clientID ?? "")/\(KeyChainController().webCode ?? "")"
        case .GetMarketWatchBySectorID:
            return "MarektWServices/GetMarketWatchBySectorID"
        case .ChangesPassword:
            return "GeneralWServices/ChangesPassword"
        case .AddMarketWatchProfileName:
            return "MarektWServices/AddMarketWatchProfileName/\(KeyChainController().webCode ?? "")/\(UserDefaultController().profileName ?? "")"
        case .AddMarketWatchProfileSymbols:
            return "MarektWServices/AddMarketWatchProfileSymbols"
        case .DeleteMarketWatchProfileSymbols:
            return "MarektWServices/DeleteMarketWatchProfileSymbols"

        }
    }
    
    var method: APIMethodType {
        get {
            switch self {
            case .GetAllProfilesLookupsByUserCode, .GetMarketWatchByProfileID, .GetExchangeSummary, .getUserAccounts, .getAllPushNotificationsByUser, .getAlertByUserCode, .GetAllMarketNewsBySymbol, .GetMarketIndicies, .DailyReports, .GetRequiredUserDocuments, .GetExpiredAttachment, .GetExpectedProfitLossSec, .GetBankIBAN, .GetB2bRequests, .GetShareTransferLogWithDetails:
                return .get
            case .UpdateIdValidity3, .UploadClientDocument, .SubmitCrmRequestRamz2, .SubmitShareTransferReq, .GetAccountTransferInfo, .GetMarketWatchBySectorID, .ChangesPassword, .AddMarketWatchProfileName, .AddMarketWatchProfileSymbols, .DeleteMarketWatchProfileSymbols:
                return .post
            }
        }
    }
    
    var requestType: APITypeOfRequest{
        switch self {
        case .GetAllProfilesLookupsByUserCode, .GetMarketWatchByProfileID, .GetExchangeSummary, .getUserAccounts, .getAllPushNotificationsByUser, .getAlertByUserCode, .GetAllMarketNewsBySymbol, .GetMarketIndicies, .DailyReports, .GetRequiredUserDocuments, .GetExpiredAttachment, .GetExpectedProfitLossSec, .GetBankIBAN, .GetB2bRequests, .GetShareTransferLogWithDetails:
                .requestPlain
        case .UpdateIdValidity3(let requestModel):
                .requestJsonEncodable(requestModel)
        case .UploadClientDocument(let requestModel):
                .requestJsonEncodable(requestModel)
        case .SubmitCrmRequestRamz2(let requestModel):
                .requestJsonEncodable(requestModel)
        case .SubmitShareTransferReq(let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetAccountTransferInfo(let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetMarketWatchBySectorID(let requestModel):
                .requestJsonEncodable(requestModel)
        case .ChangesPassword(let requestModel):
                .requestJsonEncodable(requestModel)
        case .AddMarketWatchProfileName(let requestModel):
                .requestJsonEncodable(requestModel)
        case .AddMarketWatchProfileSymbols(let requestModel):
                .requestJsonEncodable(requestModel)
        case .DeleteMarketWatchProfileSymbols(let requestModel):
                .requestJsonEncodable(requestModel)
        }
    }
}
