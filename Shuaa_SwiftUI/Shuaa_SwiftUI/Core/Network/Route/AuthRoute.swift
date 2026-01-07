//
//  AuthRoute.swift
//  Shuaa
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
enum AuthRoute:APITargetType{
    

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
        }
    }
    
    var method: APIMethodType{
        get{
            switch self {
            }
        }
    }

    var requestType: APITypeOfRequest{
        switch self {
        }
    }}
