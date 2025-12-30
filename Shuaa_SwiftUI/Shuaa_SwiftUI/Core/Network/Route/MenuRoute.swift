//
//  AuthRoute.swift
//  QSC
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation

enum MenuRoute:APITargetType{
    
    case GetAlertByUserCode(requestModel: GetAlertByUserCodeRequestModel)
    case getStatementOfAccount(requestModel: GetStatementOfAccountRequestModel)
    case getGroupedStatementOfAccount(requestModel: GetStatementOfAccountRequestModel)
    case addAlerts(requestModel: AddAlertsRequestModel)
    case addAlert(requestModel: AddAlertRequestModel)
    case modifyAlert(requestModel: ModifyAlertRequestModel)
    case deleteAlert(requestModel: DeleteAlertRequestModel)
    case UsersLogOff(requestModel: UsersLogOffRequestModel)

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
    
    var path: String{
        switch self {
        case .GetAlertByUserCode:
            return "NotificationWServices/GetAlertByUSerCode/\(KeyChainController().webCode ?? "")"
        case .getStatementOfAccount:
            return "FinancialWServices/GetStatmentOfAccount/\(KeyChainController().mainClientID ?? "")/\(KeyChainController().clientID ?? "")/\(KeyChainController().webCode ?? "")/\(UserDefaultController().dateFrom ?? "")/\(UserDefaultController().dateTo ?? "")"
        case .getGroupedStatementOfAccount:
            return "FinancialWServices/GetGroupedStatmentOfAccount/\(KeyChainController().mainClientID ?? "")/\(KeyChainController().clientID ?? "")/\(KeyChainController().webCode ?? "")/\(UserDefaultController().dateFrom ?? "")/\(UserDefaultController().dateTo ?? "")"
        case .addAlerts:
            return "NotificationWServices/AddAlerts/\(KeyChainController().webCode ?? "")/\(UserDefaultController().exchangeID ?? "")/\(UserDefaultController().selectedSymbol ?? "")/\(UserDefaultController().alertCriteria ?? "")/\(UserDefaultController().alertConditionValue ?? "")/\(UserDefaultController().alertConditionName ?? "")/\(UserDefaultController().alertValidity ?? "")/\(-1)/\(UserDefaultController().notificationAction ?? "")/\(-1)/\(-1)"
        case .addAlert:
            return "NotificationWServices/AddAlert/\(KeyChainController().webCode ?? "")/\(UserDefaultController().exchangeID ?? "")/\(UserDefaultController().selectedSymbol ?? "")/\(UserDefaultController().alertCondition ?? "")/\(UserDefaultController().alertConditionValue ?? "")/\(UserDefaultController().alertConditionName ?? "")/\(UserDefaultController().alertValidity ?? "")/\(-1)"
        case .modifyAlert:
            return "NotificationWServices/ModifyAlert"
        case .deleteAlert:
            return "NotificationWServices/DeleteAlertByAlertID/\(KeyChainController().webCode ?? "")/\(UserDefaultController().alertId ?? "")"
        case .UsersLogOff:
            return "GeneralWServices/UsersLogOff/\(KeyChainController().webCode ?? "")"

        }
    }
    
    var method: APIMethodType{
        get{
            switch self {
            case .GetAlertByUserCode, .getStatementOfAccount, .getGroupedStatementOfAccount:
                return .get
                
            case .addAlert, .addAlerts, .modifyAlert, .deleteAlert, .UsersLogOff:
                return .post
            }
        }
    }
    
    var requestType: APITypeOfRequest{
        switch self {
        case .GetAlertByUserCode, .getStatementOfAccount, .getGroupedStatementOfAccount, .UsersLogOff:
                .requestPlain
            
        case .addAlerts(let requestModel):
                .requestJsonEncodable(requestModel)
        case .addAlert(let requestModel):
                .requestJsonEncodable(requestModel)
        case .modifyAlert(let requestModel):
                .requestJsonEncodable(requestModel)
        case .deleteAlert(let requestModel):
                .requestJsonEncodable(requestModel)
        }
    }
}
