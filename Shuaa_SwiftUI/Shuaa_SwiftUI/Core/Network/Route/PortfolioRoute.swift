//
//  AuthRoute.swift
//  QSC
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation

enum PortfolioRoute:APITargetType{
    
    case getPortfolio(requestModel: GetPortfolioRequestModel)
    case getUserAccounts(requestModel: GetUserAccountsRequestModel)

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
        var dateComponents = DateComponents()
        dateComponents.day = -1
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        return dateString
    }
    
    var path: String{
        switch self {
        case .getPortfolio:
            return "FinancialWServices/GetPortfolioAndAccSumAndChart/\(KeyChainController().mainClientID ?? "")/\(KeyChainController().clientID ?? "")/\(KeyChainController().webCode ?? "")/\(getCurrentDateString())/\(KeyChainController().brokerID ?? "")/\(KeyChainController().UCODE ?? "")"
        case .getUserAccounts:
            return "GeneralWServices/GetUserAccounts/\(KeyChainController().webCode ?? "")"

        }
    }
    
    var method: APIMethodType{
        get{
            switch self {
            case .getPortfolio, .getUserAccounts:
                return .get
            }
        }
    }
    
    var requestType: APITypeOfRequest{
        switch self {
        case .getPortfolio, .getUserAccounts:
                .requestPlain
        }
    }
}
