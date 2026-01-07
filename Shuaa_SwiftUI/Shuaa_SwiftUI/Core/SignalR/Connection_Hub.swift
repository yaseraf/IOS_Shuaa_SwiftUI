//
//  Constants.swift

//  Copyright (c) IDS 2017  All rights reserved.

import UIKit
import WebKit

class Connection_Hub {
    static let shared = Connection_Hub()
    var onConnected: (() -> Void)?

    var chatHub: Hub?
    var connection: SignalR?
    var connectionDelegate: ConnectionDelegate?
    var userDefaultController = UserDefaultController.instance

   private func restartConnection(){
        if Connection_Hub.shared.connection != nil {
            Connection_Hub.shared.connection?.stop()
            Connection_Hub.shared.connection?.start()
        } else {
            Connection_Hub.shared.setupHubSignalR()
        }
    }

    func isConnected()->Bool {
       return connection?.state == .connected
    }

    func setupHubSignalR() {
        let chatHub = Hub("MyHub")
        
        bindingReceiverFunction(chatHub: chatHub)
        
        // Client
        let  connection = SignalR(AppEnvironmentController.currentNetworkConfiguration.signalRBasePath, connectionType: .hub)
        connection.useWKWebView = true
        connection.signalRVersion = .v2_2_2 // v2_2_0 v2_1_0
        connection.transport = .auto // webSockets //.webSockets //.serverSentEvents // longPolling
        connection.addHub(chatHub)

        self.connection = connection
        self.chatHub = chatHub


        connection.queryString = [
            "ischat": true
            , "username": "" //HubUtility.shared.userName // "FIT"
            , "password": "" //HubUtility.shared.password // "FIT"
            , "webCode": "" //Int(HubUtility.shared.WebCode) ?? 0
            , "baseurl": "123"
            , "key":  "\(KeyChainController().loginCookieName ?? "-")"
            , "value":  "\(KeyChainController().loginCookieValue ?? "-")"
            // , "cookies": cookieSession
        ]
        
        //MARK: SignalR events
        connection.starting = {
            debugPrint("Connection starting...")
            HubUtility.shared.hubConnectionStatus = HubConnectionStatus.starting
            debugPrint("Connection starting success")
        }
        
        connection.reconnecting = {
            debugPrint("Connection reconnecting...")
            HubUtility.shared.hubConnectionStatus = HubConnectionStatus.reconnecting
            debugPrint("Connection reconnecting success")
        }
        
        connection.reconnected = {
            debugPrint("Connection reconnected")
            HubUtility.shared.hubConnectionStatus = HubConnectionStatus.reconnected
            debugPrint("Connection reconnected success")
        }
        
        connection.disconnected = {
            debugPrint("Connection disconnected...")
            HubUtility.shared.hubConnectionStatus = HubConnectionStatus.disconnected
            debugPrint("Connection disconnected success")
            self.userDefaultController.signalRConnected = false
            self.connectionDelegate?.onDisconnect()
        }
        
        connection.connectionSlow = {
            debugPrint("Connection slow...")
            HubUtility.shared.hubConnectionStatus = HubConnectionStatus.connectionSlow
            debugPrint("Connection slow success")
        }
        
        connection.error = { error in
            HubUtility.shared.hubConnectionStatus = HubConnectionStatus.error
            debugPrint("Connection error Error: \(error ?? ["":""])")
            let errorModel = HubUtility.shared.decodeToModel(from: error, type: SignalRErrorResponseModel.self)
            debugPrint("errorModel:\(errorModel ?? SignalRErrorResponseModel())")

            guard  let errorModel = errorModel else {
                if SceneDelegate.getAppCoordinator()?.isUserLoggedIn ?? false {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){

                        debugPrint("connectionHub chatHub is alive ? \(Connection_Hub.shared.chatHub != nil)")
                        debugPrint("connectionHub connection is alive ? \(Connection_Hub.shared.connection != nil)")

                        self.restartConnection()

                        debugPrint("connectionHub chatHub is alive ? \(Connection_Hub.shared.chatHub != nil)")
                        debugPrint("connectionHub connection is alive ? \(Connection_Hub.shared.connection != nil)")
                    }
                }
                return
            }
                if errorModel.source == .timeoutException {
                    debugPrint("Connection timed out. Restarting...")

                    self.restartConnection()
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        debugPrint("connectionHub error chatHub is alive ? \(Connection_Hub.shared.chatHub != nil)")
                        debugPrint("connectionHub error connection is alive ? \(Connection_Hub.shared.connection != nil)")
                        self.restartConnection()

                        debugPrint("connectionHub error chatHub is alive ? \(Connection_Hub.shared.chatHub != nil)")
                        debugPrint("connectionHub error connection is alive ? \(Connection_Hub.shared.connection != nil)")

                    }
                }
        }
        
        connection.connected = {
            HubUtility.shared.hubConnectionStatus = HubConnectionStatus.connected
            if self.connection != nil {
                self.userDefaultController.signalRConnected = true
                self.connectionDelegate?.onConnect()
                self.onConnected?()
                self.onConnected = nil   // prevent multiple calls
            } else {
                debugPrint("SignalR Failed to connect")
            }
        }
        connection.start()
    }
    
    
    func bindingFunction<T:Decodable>(method:HubMethodType,type:T.Type,result:((T?)->Void)?){
        guard let chatHub  = chatHub else {return}
        Connection_Hub.shared.connection?.connect({
            print("reConnect")
        })
        
        if !Connection_Hub.shared.isConnected() {
            debugPrint("Reconnecting")
            Connection_Hub.shared.connection?.start()
        }
        
        chatHub.onReceive(method) { args in
            debugPrint("method with args: \(method) Args: \(args ?? [])")
            let responseModel =  HubUtility.shared.decodeToModel(from: args?.first, type: type)
            result?(responseModel)
        }
    }
    
    func bindingReceiverFunction(chatHub: Hub){
        
        //MARK: Tops
        chatHub.onReceive(.sendTopGainerObject) { args in
            debugPrint("chatHub.onReceive SendTopGainerObject ")

        }
        
        chatHub.onReceive(.sendTopLoserObject) { args in
            debugPrint("chatHub.onReceive SendTopLoserObject ")
            
        }
        
        chatHub.onReceive(.sendTopVolumeObject) { args in
            debugPrint("chatHub.onReceive SendTopVolumeObject ")
            
        }
        
        chatHub.onReceive(.sendTopValueObject) { args in
            debugPrint("chatHub.onReceive sendTopValueObject ")

        }
        
        chatHub.onReceive(.sendMostActiveObject) { args in
            debugPrint("chatHub.onReceive sendMostActiveObject ")
            
        }
        
        //========================================================
        //========================================================
        //========================================================

        //MARK: Market Exchange Status
        chatHub.onReceive(.sendExchangeMarketObject) { args in
            debugPrint("market args: \(args ?? [])")
            
        }
        
        chatHub.onReceive(.sendServerDateTimeVer2) { args in // it is stop called
        }
        
        //========================================================
        //========================================================
        //========================================================

        //MARK: Market T&S
        chatHub.onReceive(.getMarketTradesFullObject) { args in
            debugPrint("Get market trades full object args: \(args ?? [])")
            
        }
        
        //========================================================
        //========================================================
        //========================================================

        //MARK: Symbol Details
        chatHub.onReceive(.sendSymbolTradesFullObject) { args in // we stop use this
            debugPrint("Get symbol trades full object args: \(args ?? [])")

        }
        
        chatHub.onReceive(.getSymbolTradesFullObject) { args in
            debugPrint("Get symbol trades full object args: \(args ?? [])")
            
        }
        
        chatHub.onReceive(.getMarketTradesFullObject) { args in
            debugPrint("Get market trades full object args: \(args ?? [])")
            
        }
        
        chatHub.onReceive(.getSymbolTradesFullObjects) { args in
            debugPrint("Get symbol trades full object args: \(args ?? [])")
            
        }
        
        chatHub.onReceive(.sendSymbolTradesSummaryObject) { args in
            debugPrint("args send symbol: \(args ?? [])")
            
        }
        
        chatHub.onReceive(.sendMarketTradesFullObject) { args in
            debugPrint("chatHub.onReceive sendMarketTradesFullObject args ")
            
        }
        
        chatHub.onReceive(.sendSymbolDetails) { args in
            debugPrint("chatHub.onReceive sendSymbolDetails args ")

        }
        
        chatHub.onReceive(.SubscribeFullMDSymbol) { args in
            
        }
        
        chatHub.onReceive(.getFullMDSymbol) { args in
            
        }
        
        chatHub.onReceive(.getRelatedStocks) { args in
            
        }
        
        chatHub.onReceive(.getMostWatchStocks) { args in
            
        }
        
        //========================================================
        //========================================================
        //========================================================

        //MARK: Watch List
        chatHub.onReceive(.sendMarketWatchObject) { args in
            
        }
        
        chatHub.onReceive(.sendMarketIndexObject) { args in
            debugPrint("send market index object success")
            
        }
        
        chatHub.onReceive(.unSubscribeMarketWatchSymbols) { args in

        }
        
        //========================================================
        //========================================================
        //========================================================

        //MARK: Orders
        chatHub.onReceive(.sendOrders) { args in
            
        }
        
        chatHub.onReceive(.sendOrderDetails) { args in

        }
        
        chatHub.onReceive(.sendNotifyOrderObject) { args in
            
        }
        
        chatHub.onReceive(.sendAddOrderRequest) { args in
            
        }
        
        //========================================================
        //========================================================
        //========================================================

        //MARK: Notifications
        chatHub.onReceive(.sendUserAlertsObject) { args in
            
        }
        
        chatHub.onReceive(.sendUserPushAlertsObject) { args in

        }

        
        chatHub.onReceive(.sendNotifyMarketNewsObject) { args in

        }
        
        //========================================================
        //========================================================
        //========================================================

        //MARK: Portfolio
        chatHub.onReceive(.getPortfolioInitial) { args in

        }
    }
    
    func logout(withReload: Bool) {
        self.chatHub?.connection.stop()
        self.connection?.stop()

        self.connection = nil
        self.chatHub = nil
        
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {
                })
            }
            WKWebsiteDataStore.default().removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(),for: records, completionHandler: {
            })
        }
    }
}

public enum MessageType: Int, Codable {
    case Invocation = 1
    case StreamItem = 2
    case Completion = 3
    case StreamInvocation = 4
    case CancelInvocation = 5
    case Ping = 6
    case Close = 7
}
