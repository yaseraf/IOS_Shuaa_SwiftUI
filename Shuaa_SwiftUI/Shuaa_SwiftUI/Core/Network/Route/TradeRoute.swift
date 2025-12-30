//
//  AuthRoute.swift
//  QSC
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation

enum TradeRoute:APITargetType{
    
    case GetAllMarketWatchBySymbol(requestModel: GetAllMarketWatchBySymbolRequestModel)
    case GetRiskManagement(requestModel: GetRiskManagementRequestModel)
    case CalculatesShares(requestModel: CalculatesSharesRequestModel)
    
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
        case .GetAllMarketWatchBySymbol:
            return "MarektWServices/GetALLMarketWatchBySymbol/\(KeyChainController().webCode ?? "")/\(UserDefaultController().selectedSymbol ?? "")/\(UserDefaultController().selectedSymbolType ?? "")"
        case .GetRiskManagement:
//            return "TradingWServices/GetRsikManagment/\(KeyChainController().mainClientID ?? "")/\(KeyChainController().accountID ?? "")/\(KeyChainController().nin ?? "")/\(UserDefaultController().selectedSymbol ?? "")/\(UserDefaultController().orderType ?? "")/\(UserDefaultController().qty ?? "")/\(UserDefaultController().price ?? "")/\(UserDefaultController().orderId ?? "")/\(UserDefaultController().userCat ?? "")/\(UserDefaultController().UCODE ?? "")/\(UserDefaultController().PORTMANG ?? "")/\(UserDefaultController().MEMBERID ?? "")/\(UserDefaultController().COMPINIT ?? "")/\(KeyChainController().clientID ?? "")/\(UserDefaultController().TYPECODE ?? "")/\(UserDefaultController().VALIDITYCODE ?? "")/\(UserDefaultController().VALIDITY ?? "")/\(UserDefaultController().SETT_TYPE ?? "")/\(UserDefaultController().CUSTODYID ?? "")/\(KeyChainController().webCode ?? "")"
            return "TradingWServices/GetRsikManagment/\(KeyChainController().mainClientID ?? "")/\(KeyChainController().accountID ?? "")/\(KeyChainController().nin ?? "")/\(UserDefaultController().selectedSymbol ?? "")/\(UserDefaultController().orderType ?? "")/\(UserDefaultController().qty ?? "0")/\(UserDefaultController().isMarketPrice == true ? "0" : UserDefaultController().price ?? "0")/\(UserDefaultController().orderId ?? "")/\(KeyChainController().userType ?? "")/\(KeyChainController().UCODE ?? "")/\(KeyChainController().brokerID ?? "")/\(KeyChainController().brokerID ?? "")/\(KeyChainController().compInit ?? "")/\(KeyChainController().clientID ?? "")/\(UserDefaultController().selectedSymbolType ?? "")/-1/-1/-1/-1/\(KeyChainController().webCode ?? "")"
        case .CalculatesShares:
            return "TradingWServices/CalculatesShares/\(KeyChainController().mainClientID ?? "")/\(KeyChainController().accountID ?? "")/\(KeyChainController().nin ?? "")/\(UserDefaultController().selectedSymbol ?? "")/\(UserDefaultController().orderType ?? "")/\(UserDefaultController().cash ?? "")/\(UserDefaultController().price ?? "")/\(UserDefaultController().orderId ?? "")/\(KeyChainController().userType ?? "")/\(KeyChainController().UCODE ?? "")/\(KeyChainController().brokerID ?? "")/\(KeyChainController().brokerID ?? "")/\(KeyChainController().compInit ?? "")/\(KeyChainController().clientID ?? "")/\(UserDefaultController().selectedSymbolType ?? "")/-1/-1/\(UserDefaultController().orderType ?? "")/\(KeyChainController().webCode ?? "")"
        }
    }
    
    var method: APIMethodType{
        get{
            switch self {
            case .GetAllMarketWatchBySymbol, .GetRiskManagement, .CalculatesShares:
                return .get
            }
        }
    }
    
    var requestType: APITypeOfRequest{
        switch self {
        case .GetAllMarketWatchBySymbol, .GetRiskManagement, .CalculatesShares:
                .requestPlain
        }
    }
}
