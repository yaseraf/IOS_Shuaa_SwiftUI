//
//  EnvironmentConfiguration.swift
//  Shuaa
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation

class NetworkConfiguration {
    private(set) var basePath:String
    private var signalRDomain:String
    static let api:String = "api/"
    static let version:String = "v2/"
    
    // SignalR
    private let mobileServices:String = "MobileServices/"
    private let sr:String = "sr/"
    private let signalr:String = "signalr/"
    private let hubs: String = "hubs"

    
   var signalRBasePath:String {
        get{
             signalRDomain + sr +  signalr + hubs
        }
    }

    init(basePath: String,signalRDomain:String) {
        self.basePath = basePath
        self.signalRDomain = signalRDomain
    }

    static let development:NetworkConfiguration = .init(
      basePath: "https://test.qatar-securities.com/EtradeService/", signalRDomain: "https://test.qatar-securities.com/EtradeService/" // QSC UAT

    )

    static let preProduction:NetworkConfiguration = .init(
        basePath: "https://test.qatar-securities.com/EtradeService/", signalRDomain: "https://test.qatar-securities.com/EtradeService/" // QSC UAT
    )

    static let production:NetworkConfiguration = .init(
        basePath: "https://test.qatar-securities.com/EtradeService/", signalRDomain: "https://test.qatar-securities.com/EtradeService/" // QSC UAT
    )
}
