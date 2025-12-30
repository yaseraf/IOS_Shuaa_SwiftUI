//
//  SelectSharesViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 03/08/2025.
//

import Foundation

class TradeConfirmationViewModel: ObservableObject {
    private var coordinator: TradeCoordinatorProtocol
    
    @Published var shares: String = ""
    @Published var price: String = ""
    @Published var value: String = ""
    @Published var expiryDate: String = ""
    @Published var selectedTypeOfTrade: TypeOfTrade
    @Published var orderPreview: OrderPreviewModel?
    @Published var riskManagementData: GetRiskManagementUIModel?
    
    @Published var sendOrdersAPIResult: APIResultType<SendOrdersUIModel>?
    
    
    private var isEditOrder:Bool

    init(coordinator: TradeCoordinatorProtocol, shares: String, price: String, value: String, expiryDate: String, selectedTypeOfTrade:TypeOfTrade, orderPreview: OrderPreviewModel, riskManagementData: GetRiskManagementUIModel, isEditOrder: Bool) {
        self.coordinator = coordinator
        self.shares = shares
        self.price = price
        self.value = value
        self.expiryDate = expiryDate
        self.selectedTypeOfTrade = selectedTypeOfTrade
        self.orderPreview = orderPreview
        self.riskManagementData = riskManagementData
        self.isEditOrder = isEditOrder
    }
    
    func onDismiss() {
        coordinator.dismiss()
    }
    
    func onEditTap() {
        coordinator.dismiss()
    }

    func onSendTap() {
        setOrder()
    }
    
    
}

// MARK: SignalR
extension TradeConfirmationViewModel {
    func sendAddOrderRequest(order: [String: String]){
        sendOrdersAPIResult = .onLoading(show: true)
        
        if Connection_Hub.shared.chatHub != nil {
            do {
                printToLog("test invoke sendAddOrderRequest")
                // Invoke server method and handle response
                
                var strData = "[{"
                //\"ClientID\": \"\(clientId)\" , \"Symbol\": \"\(symbol)\"  , \"WebUserID\": \"\(appDelegate.WebCode)\"}]"
                
                order.forEach { (key, value) in
                    strData += " \"\(key)\": \"\(value)\","
                }
                
                strData.removeLast()
                strData += "}]"
                debugPrint("sendAddOrderRequest strData: \(strData)")
                
                let data = strData.data(using: .utf8)!
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,String>] {
                        debugPrint("sendAddOrderRequest jsonArray:\(jsonArray)") // use the json here
                        
                        if jsonArray.count > 0 {
                            try Connection_Hub.shared.chatHub?.invoke(HubMethodType.sendAddOrderRequest.rawValue, arguments: [KeyChainController().username ?? "", jsonArray[0]]) { (result, error) in
                                if let e = error {
                                    debugPrint("sendAddOrderRequest invoke Error: \(e)")
                                } else {
                                    debugPrint("sendAddOrderRequest invoke, \([KeyChainController().username ?? "", jsonArray[0]]) Success!, appDelegate.userNameNotEncryptrd\("info3@fitmena.com")")
                                    
                                    UserDefaultController().price = nil
                                    UserDefaultController().qty = nil
                                    UserDefaultController().isMarketPrice = nil
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        self.sendOrdersAPIResult = .onLoading(show: false)
                                        self.coordinator.dismiss()
                                        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getTradeCoordinator().start()
                                    }
                                }
                            }
                        }
                        else {
                        }
                    } else {
                        debugPrint("sendAddOrderRequest bad json")
                    }
                } catch let error as NSError {
                    debugPrint("sendAddOrderRequest JSONSerialization error:\(error)")
                }
                
            } catch let error {
                debugPrint("sendAddOrderRequest chatHub error: \(error.localizedDescription)")
            }
          }
        }

}

// MARK: Functions
extension TradeConfirmationViewModel {
    func setOrder() {
        var msgCode = ""
        
        if self.selectedTypeOfTrade == .buy {
            msgCode = self.isEditOrder ? "C15" : "C11"
        } else {
            msgCode = self.isEditOrder ? "C14" : "C10"
        }
        
        let bracketOrderParam = BracketOrderParam(ReferencePrice: "1", isStopLoss: false, StopLossValue: 0, StopLossValueType: "1", isTakeProfit: false, TakeProfitValue: 0, TakeProfitValueType: "1")
        
        let conditionalParams: [ConditionalParameters] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en")
        
        
        let rqAccountID = orderPreview?.accountID
//        let rqAccountNameA = orderDetails?.AccountNameA
        let rqAccountNameA = ""
        let rqAccountNameE = orderPreview?.accountNameE
        let rqApprovalStatusCode = KeyChainController.shared().webCode
        let rqApprovalTypeCode = riskManagementData?.msValidation
        let rqAvgExePrice = "" // Empty
        let rqBEPrice = "" // Empty
        let rqBookCode = "0001"
        let rqBrokerID = KeyChainController.shared().brokerID
        let rqBuyerMember = "" // Empty
        let rqClientID = orderPreview?.clientID
//        let rqCustodianID = orderPreview?.custodianID
        let rqCustodianID = "-1"
        let rqEntryDate = isEditOrder ? orderPreview?.entryDate ?? Date().toString(dateFormat: .ddMMyyyyHHmmss) : Date().toString(dateFormat: .ddMMyyyyHHmmss) // NEW EDITED
        let rqExchange = orderPreview?.exchange
        let rqFixOrderID = orderPreview?.fIXOrderID // NEW EDIT
        let rqIPAddress = "109.107.237.83" // From Ubhar code
        let rqIntOrderID = "" // Empty
        let rqIsinCode = "" // Empty
        let rqLastUpdateTime = "0001-01-01T00:00:00" // weird
//        let rqLocalValue = orderPreview?.orderValue // Empty
        let rqLocalValue = "" // Empty
        let rqMarketOrderID = orderPreview?.marketOrderID // Default Empty
        let rqMarketTypeCode = orderPreview?.marketTypeCode
        let rqMaxTRPrice = orderPreview?.price
        let rqMinFillQty = orderPreview?.minFillQty
        let rqModifyDate = Date().toString(dateFormat: .ddMMyyyyHHmmss)
        let rqNin = orderPreview?.nin
        let rqOrderID = isEditOrder ? orderPreview?.orderID : ""
        let rqOrderTypeCode = orderPreview?.OrderTypeCode
        let rqOrigUserID = KeyChainController.shared().UCODE
        let rqOriginCode = "A"
        let rqPrice = UserDefaultController().isMarketPrice == true ? "0.0" : orderPreview?.price
        let rqProcSentFlag = "Y"
        let rqRejectReason = "" // Empty
        let rqRemaining = orderPreview?.remaining ?? ""
        let rqRemark = orderPreview?.remark // Default empty
        let rqSLPrice = orderPreview?.sLPrice
        let rqSPLOrderFlag = "N"
        let rqSellBuyFlag = orderPreview?.sellBuyFlag
        let rqSellerMember = "" // Empty
        let rqSenderCompanyID = "" // Empty
        let rqSenderSubID = "" // Empty
        let rqSettType = orderPreview?.settType?.replacingOccurrences(of: "T+", with: "")
        let rqSmartOrderID = "" // Empty
        let rqSource2Code = "c"
        let rqSourceCode = "c"
        let rqStatusCode = (isEditOrder ? orderPreview?.statusCode : "W") // NEW EDITED
        let rqStopLossPx = "" // Empty
        let rqSymbol = orderPreview?.symbol // This should not be empty
        let rqSymbolCode = orderPreview?.symbolCode // This should not be empty
        let rqSymbolLongName = "" // Empty
        let rqTPPrice = orderPreview?.tPPrice
        let rqtRPriceIsPerc = "" // Empty
        let rqTRPrice = "" // Empty
        // The modify issue is not from totalVolume
        
        let rqTotalVolume = isEditOrder ? orderPreview?.totalVolume ?? "" : orderPreview?.remaining ?? ""
        let rqTrxnID = orderPreview?.TrxnID // NEW EDIT
        let rqUserID = KeyChainController.shared().UCODE
        // Ensure that the validityCode is the same validityCode in the orderDetails
        let rqValidityCode = orderPreview?.validityCode
        let rqValidityDate = orderPreview?.validityDate
        let rqVisibilityQty = orderPreview?.visibleQty
        let rqMsgCode = msgCode
        let rqSmartOrderType = "" // Empty
        let rqIstConditionalParameters = conditionalParams
        let rqBracketOrdParam = bracketOrderParam
                
        let requestOrderHubItem = RequestOrderHubItem(accountID: rqAccountID, accountNameA: rqAccountNameA, accountNameE: rqAccountNameE, approvalStatusCode: rqApprovalStatusCode, approvalTypeCode: rqApprovalTypeCode, avgExePrice: rqAvgExePrice, bEPrice: rqBEPrice, bookCode: rqBookCode, brokerID: rqBrokerID, buyerMember: rqBuyerMember, clientID: rqClientID, custodianID: rqCustodianID, entryDate: rqEntryDate, exchange: rqExchange, fIXOrderID: rqFixOrderID, iPAddress: rqIPAddress, intOrderID: rqIntOrderID, isinCode: rqIsinCode, lastUpdateTime: rqLastUpdateTime, localValue: rqLocalValue, marketOrderID: rqMarketOrderID, marketTypeCode: rqMarketTypeCode, maxTRPrice: rqMaxTRPrice, minFillQty: rqMinFillQty, modifyDate: rqModifyDate, nIN: rqNin, orderID: rqOrderID, orderTypeCode: rqOrderTypeCode, origUserID: rqOrigUserID, originCode: rqOriginCode, price: rqPrice, procSentFlag: rqProcSentFlag, rejectReason: rqRejectReason, remaining: rqRemaining, remark: rqRemark, sLPrice: rqSLPrice, sPLOrderFlag: rqSPLOrderFlag, sellBuyFlag: rqSellBuyFlag, sellerMember: rqSellerMember, senderCompanyID: rqSenderCompanyID, senderSubID: rqSenderSubID, settType: rqSettType, smartOrderID: rqSmartOrderID, source2Code: rqSource2Code, sourceCode: rqSourceCode, statusCode: rqStatusCode, stopLossPx: rqStopLossPx, symbol: rqSymbol, symbolCode: rqSymbolCode, symbolLongName: rqSymbolLongName, tPPrice: rqTPPrice, tRPriceIsPerc: rqtRPriceIsPerc, tRPrice: rqTRPrice, totalVolume: rqTotalVolume, trxnID: rqTrxnID, userID: rqUserID, validityCode: rqValidityCode, validityDate: rqValidityDate, visibleQty: rqVisibilityQty, msgCode: rqMsgCode, SmartOrderType: rqSmartOrderType, lstConditionalParameters: rqIstConditionalParameters, bracketOrdParam: rqBracketOrdParam)
        
        if isEditOrder {
//            UserDefaultController().isModifyOrderNotification = true
            debugPrint("Request modify order hub item created with: \(requestOrderHubItem)")
        } else {
//            UserDefaultController().isModifyOrderNotification = false
            debugPrint("Request order hub item created with: \(requestOrderHubItem)")
        }
        sendAddOrderRequest(order: requestOrderHubItem.toDictData())
    }

}
