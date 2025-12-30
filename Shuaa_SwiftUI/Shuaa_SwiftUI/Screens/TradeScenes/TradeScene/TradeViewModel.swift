//
//  OrderListViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 11/08/2025.
//

import Foundation

class TradeViewModel: ObservableObject {
    private let coordinator: TradeCoordinatorProtocol
    private var useCase: TradeUseCaseProtocol

    @Published var getAllMarketWatchBySymbolAPIResult:APIResultType<GetAllMarketWatchBySymbolUIModel>?
    @Published var getRiskManagementAPIResult:APIResultType<GetRiskManagementUIModel>?
    @Published var calculateSharesAPIResult:APIResultType<String>?
    @Published var subscribleMarketWatchSymbolsAPIResult:APIResultType<[GetMarketWatchByProfileIDUIModel]>?

    @Published var userData: GetUserAccountsUIModel?
    @Published var orderListData: [OrderListUIModel]?
    @Published var selectedStock: GetCompaniesLookupsUIModel
    @Published var tillCancelToggle:Bool
    @Published var marketPriceToggle:Bool
    @Published var typeOfTrade: TypeOfTrade = .buy
    @Published var orderType: ChooseOrderType = .limitOrder
    @Published var riskManagementData: GetRiskManagementUIModel?
    @Published var calculatedShares: String?
    
    @Published var marketWatchData: GetAllMarketWatchBySymbolUIModel?
    
    @Published var shares: String = ""
    @Published var appearAmount: String = ""
    @Published var price: String = ""
    @Published var expiryDate: String = "one day"
    @Published var isEditOrder: Bool
    @Published var flagMessage: String = ""
    
    @Published var GTDId: String?
    @Published var GTCId: String?
    
    @Published var orderDetails: OrderListUIModel?

    init(coordinator: TradeCoordinatorProtocol, useCase: TradeUseCaseProtocol, selectedStock: GetCompaniesLookupsUIModel, typeOfTrade: TypeOfTrade, isEditOrder: Bool, orderDetails: OrderListUIModel) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.selectedStock = selectedStock
        self.typeOfTrade = typeOfTrade
        self.isEditOrder = isEditOrder
        self.orderDetails = orderDetails
        
        tillCancelToggle = false
        marketPriceToggle = false
        
        UserDefaultController().orderType = typeOfTrade == .buy ? "B" : "S"
        userData = UserDefaultController().selectedUserAccount
        
        if isEditOrder {
            shares = orderDetails.TotalVolume ?? ""
            price = orderDetails.Price ?? ""
            appearAmount = orderDetails.VisibleQty ?? ""
            
            UserDefaultController().qty = shares
            UserDefaultController().price = price
            UserDefaultController().orderId = orderDetails.OrderID
            
            if orderDetails.ValidityCode == "0002" || orderDetails.ValidityCode == "2" {
                tillCancelToggle = true
            }
            if orderDetails.OrderTypeCode == "1" {
                UserDefaultController().isMarketPrice = true
                marketPriceToggle = true
            }
        }
    }
}

// MARK: Routing
extension TradeViewModel {
    func onBackTap() {
        coordinator.popViewController()
    }
    
    func openSelectSharesScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openSelectSharesScene(delegate: self)
    }
    
    func onSendTap() {
        
        let doubleShares = Double(shares) ?? 0
        let doubleTotalVolume = Double(orderDetails?.TotalVolume ?? "") ?? 0
        let doubleRemaining = Double(orderDetails?.Remaining ?? "") ?? 0
        
        let orderPreview = OrderPreviewModel(
            accountID: KeyChainController().accountID ?? "",
            accountNameA: UserDefaultController().selectedUserAccount?.ClientNameA ?? "",
            accountNameE: UserDefaultController().selectedUserAccount?.ClientNameE ?? "",
            avgExePrice: "",
            clientID: KeyChainController().clientID ?? "",
            companyShortNameA: "", companyShortNameE: "",
            entryDate: isEditOrder ? orderDetails?.EntryDate : Date().toString(dateFormat: .ddMMyyyyHHmmss),
            exchange: selectedStock.exchange,
            execOrderComm: "",
            execQty: isEditOrder ? orderDetails?.ExecQty : shares,
            maxPrice: "",
            minFillQty: isEditOrder ? orderDetails?.MinFillQty : "0",
            minPrice: "",
            modifyDate: "",
            nin: KeyChainController().nin ?? "",
            ordComm: "",
            orderID: isEditOrder ? orderDetails?.OrderID: "",
            orderValue: isEditOrder ? orderDetails?.OrderValue: riskManagementData?.orderValue ?? "",
            OrderTypeCode: orderType == .limitOrder ? "2" : "1", originCode: "",
            precision: "",
            price: price,
            rejectReason: "",
            remaining: shares,
            remark: "",
            smartorderid: "",
            sellBuyFlag: typeOfTrade == .buy ? "B" : "S",
            statusCode: isEditOrder ? orderDetails?.StatusCode : "",
            stopLossPx: "",
            symbol: selectedStock.symbol,
            totalVolume: isEditOrder ? String(doubleShares + (doubleTotalVolume - doubleRemaining)) : shares,
            validityCode: tillCancelToggle ? UserDefaultController().tifList?.filter({$0.id?.lowercased() == "0002"}).first?.id : UserDefaultController().tifList?.filter({$0.id?.lowercased() == "0001"}).first?.id, // !!!!
            validityDate: Date().toString(dateFormat: .ddMMyyyyHHmmss), // !!!!
            visibleQty: appearAmount,
            bANKACCOUNTNO: "",
            smartOrderID: "",
//            settType: typeOfTrade == .buy ? "2" : "1", // !!!!
            settType: "", // !!!!
//            custodianID: "-1", // !!!!
            custodianID: UserDefaultController().CUSTODYID ?? "", // !!!!
            curCode: "",
            TrxnID: isEditOrder ? orderDetails?.TrxnID != nil ? orderDetails?.TrxnID : "0" : "0",
            symbolCode: selectedStock.symbolID ?? "",
            bookCode: "",
            brokerID: "",
            sourceCode: "",
            userID: "",
            origUserID: "",
            marketTypeCode: selectedStock.marketType ?? "",
            source2Code: "",
            procSentFlag: "",
            marketOrderID: isEditOrder ? orderDetails?.MarketOrderID : "",
            intOrderID: "",
            msgCode: "",
            senderSubID: "",
            buyerMember: "",
            sellerMember: "",
            isinCode: "",
            fIXOrderID: isEditOrder ? orderDetails?.FIXOrderID : "",
            tPPrice: isEditOrder ? orderDetails?.TP_price : "0",
            sLPrice: isEditOrder ? orderDetails?.SL_price : "0",
            tRPrice: "",
            maxTRPrice: "0.0",
            tRPriceIsPerc: "",
            bEPrice: "",
            sPLOrderFlag: "",
            approvalStatusCode: "",
            approvalTypeCode: "",
            senderCompanyID: "",
            localValue: "",
            symbolLongName: "",
            bOutOfMarketType: "",
            bOutOfMarketDate: "",
            bGroupName: "",
            iPAddress: "",
            lastUpdateTime: "",
            SmartOrderTypeDesc_E: "",
            SmartOrderTypeDesc_A: "")
        
        coordinator.openTradeConfrimationScene(shares: shares, price: price, value: riskManagementData?.orderValue ?? "", expiryDate: expiryDate, selectedTypeOfTrade: typeOfTrade, orderPreview: orderPreview, riskManagementData: riskManagementData ?? .initializer(), isEditOrder: isEditOrder)
    }
    
    func openQuantityCalculatorScene() {
        if UserDefaultController().isMarketPrice ?? false {
            UserDefaultController().price = marketWatchData?.lastTradePrice
        } else {
            UserDefaultController().price = price
        }

        coordinator.openQuantityCalculatorScene(delegate: self, lastTradePrice: marketWatchData?.lastTradePrice ?? "")
    }
    
    func openSelectPortfolioScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openSelectPortfolioScene(delegate: self, selectedUser: userData)
    }
    
    
    func getUserData() {
//        userData = UserUIModel(userID: "398235", nameEn: "AlSaed Younes", nameAr: "السيد يونس", purchasingPower: 41914134, purchasingValue: 41914134, commission: 41914134, totalValue: 41914134)
    }
}


// MARK: API Calls
extension TradeViewModel {
    func callGetAllMarketWatchBySymbolAPI() {
        let requestModel = GetAllMarketWatchBySymbolRequestModel()
        
        getAllMarketWatchBySymbolAPIResult = .onLoading(show: true)
        Task.init {
            await useCase.GetAllMarketWatchBySymbol(requestModel: requestModel) {[weak self] result in
                self?.getAllMarketWatchBySymbolAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    
                    self?.marketWatchData = success
                    
                    self?.callGetRiskManagementAPI()
                    self?.SubscribeMarketWatchSymbolsSignalR()
                    
                    self?.getAllMarketWatchBySymbolAPIResult = .onSuccess(response: success)
                    
                case .failure(let failure):

                    self?.getAllMarketWatchBySymbolAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
    
    func callGetRiskManagementAPI() {
        let requestModel = GetRiskManagementRequestModel()
        
        UserDefaultController().orderId = "-1"
        
        getRiskManagementAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetRiskManagement(requestModel: requestModel) {[weak self] result in
                self?.getRiskManagementAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    
                    self?.riskManagementData = success
                    
                    self?.getRiskManagementAPIResult = .onSuccess(response: success)
                    
                case .failure(let failure):

                    self?.getRiskManagementAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
    
//    func callCalculatesSharesAPI() {
//        let requestModel = CalculatesSharesRequestModel()
//        
//        UserDefaultController().orderId = "-1"
//        
//        calculateSharesAPIResult = .onLoading(show: true)
//        
//        Task.init {
//            await useCase.CalculatesShares(requestModel: requestModel) {[weak self] result in
//                self?.calculateSharesAPIResult = .onLoading(show: false)
//                switch result {
//                case .success(let success):
//                    
//                    self?.calculatedShares = success
//                    
//                    self?.calculateSharesAPIResult = .onSuccess(response: success)
//                    
//                case .failure(let failure):
//
//                    self?.calculateSharesAPIResult = .onFailure(error: failure)
//               
//                }
//            }
//        }
//    }

}

// MARK: SignalR
extension TradeViewModel {
    func SubscribeMarketWatchSymbolsSignalR(){
        
        subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  true)
            
        if Connection_Hub.shared.chatHub != nil {
            do {
                printToLog("test invoke subscribeMarketWatchSymbols '\(self.marketWatchData?.symbol ?? "")'")

                try Connection_Hub.shared.chatHub?.invoke(HubMethodType.subscribeMarketWatchSymbols.rawValue, arguments: [KeyChainController().username ?? "", self.marketWatchData?.symbol ?? ""]) { (result, error) in
                    if let e = error {
                        printToLog("SubscribeMarketWatchSymbols invoke '\(self.marketWatchData?.symbol ?? "")' Error: \(e)")
                        self.subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  false)

                    } else {
                        printToLog("SubscribeMarketWatchSymbols invoke '\(self.marketWatchData?.symbol ?? "")' Success!, appDelegate.userNameNotEncryptrd\("info3@fitmena.com")")
                        self.subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  false)
                    }
                }
            } catch let error {
                printToLog("SubscribeMarketWatchSymbols chatHub '\(self.marketWatchData?.symbol ?? "")' error: \(error.localizedDescription)")
                self.subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  false)

            }
        } else {
            debugPrint("Chathub is nil")
        }
    }
}

// MARK: Functions
extension TradeViewModel {
    func onTypeOfTradeChange(typeOfTrade: TypeOfTrade) {
        UserDefaultController().orderType = typeOfTrade == .buy ? "B" : "S"
        self.typeOfTrade = typeOfTrade
    }
    
    func onAppearChange() {
        
    }
    
    func onPriceChange() {
        UserDefaultController().price = price
        if CheckPriceWithinRange() && !price.isEmpty && !shares.isEmpty {
            callGetRiskManagementAPI()
        }
    }
    
    func onSharesChange() {
        UserDefaultController().qty = shares
        if CheckPriceWithinRange() && (!price.isEmpty || UserDefaultController().isMarketPrice == true) && !shares.isEmpty {
            callGetRiskManagementAPI()
        }
    }
    
    func onTillCancelToggle() {
        
    }
    
    func onMarketPriceToggle() {
        UserDefaultController().isMarketPrice = marketPriceToggle
        if marketPriceToggle {
            orderType = .marketOrder
        } else {
            orderType = .limitOrder
        }
        if CheckPriceWithinRange() {
            callGetRiskManagementAPI()            
        }
    }
    
    func CheckPriceWithinRange() -> Bool {
        if UserDefaultController().isMarketPrice == true {
            flagMessage = ""
            return true
        }
        
        if Double(price) ?? 0 >= Double(marketWatchData?.minPrice ?? "") ?? 0 && Double(price) ?? 0 <= Double(marketWatchData?.maxPrice ?? "") ?? 0 {
            flagMessage = ""

            return true
        } else {
            flagMessage = AppUtility.shared.isRTL ? "يجب أن يكون السعر المحدد بين \(marketWatchData?.minPrice ?? "") و \(marketWatchData?.maxPrice ?? "")" : "Limit price must be between \(marketWatchData?.minPrice ?? "") and \(marketWatchData?.maxPrice ?? "")"
            
            return false
        }
    }
    
    
}

// MARK: Delegates
extension TradeViewModel: SelectPortfolioDelegate {
    func onSelect(user: GetUserAccountsUIModel?) {
        userData = user
    }
}

extension TradeViewModel: QuantityCalculatorDelegate {
    func onCalculate(amount: String) {
        shares = amount
//        UserDefaultController().cash = amount
//        callCalculatesSharesAPI()
    }
}

extension TradeViewModel: SelectSharesDelegate {
    func onSelect(share: GetCompaniesLookupsUIModel?) {         
        selectedStock = share ?? .testUIModel()
        UserDefaultController().selectedSymbol = share?.symbol
        UserDefaultController().selectedSymbolType = share?.marketType
        callGetAllMarketWatchBySymbolAPI()
    }
}

extension TradeViewModel: MarketWatchDelegate {
    func onSubscribeMDSymbol(data: SubscribeMarketWatchSymbolsUIModel) {
        
    }
    
    func onWatchlistDataReceive(data: GetMarketWatchByProfileIDUIModel) {
        guard var existing = marketWatchData else { return }

        existing.accumlossFlags   = (data.accumlossFlags?.isEmpty == false) ? data.accumlossFlags : existing.accumlossFlags
        existing.allowdBuyLimit   = (data.allowdBuyLimit?.isEmpty == false) ? data.allowdBuyLimit : existing.allowdBuyLimit
        existing.avgPrice         = (data.avgPrice?.isEmpty == false) ? data.avgPrice : existing.avgPrice
        existing.bidPrice         = (data.bidPrice?.isEmpty == false) ? data.bidPrice : existing.bidPrice
        existing.bidVolume        = (data.bidVolume?.isEmpty == false) ? data.bidVolume : existing.bidVolume
        existing.buyCashFlowPerc  = (data.buyCashFlowPerc?.isEmpty == false) ? data.buyCashFlowPerc : existing.buyCashFlowPerc
        existing.curCode          = (data.curCode?.isEmpty == false) ? data.curCode : existing.curCode
        existing.closePrice       = (data.closePrice?.isEmpty == false) ? data.closePrice : existing.closePrice
        existing.companyA         = (data.companyA?.isEmpty == false) ? data.companyA : existing.companyA
        existing.companyE         = (data.companyE?.isEmpty == false) ? data.companyE : existing.companyE
        existing.dayRange         = (data.dayRange?.isEmpty == false) ? data.dayRange : existing.dayRange
        existing.depthBuyOrder    = (data.depthBuyOrder?.isEmpty == false) ? data.depthBuyOrder : existing.depthBuyOrder
        existing.depthByPrice     = (data.depthByPrice?.isEmpty == false) ? data.depthByPrice : existing.depthByPrice
        existing.eps              = (data.eps?.isEmpty == false) ? data.eps : existing.eps
        existing.exchange         = (data.exchange?.isEmpty == false) ? data.exchange : existing.exchange
        existing.executed         = (data.executed?.isEmpty == false) ? data.executed : existing.executed
        existing.highPrice        = (data.highPrice?.isEmpty == false) ? data.highPrice : existing.highPrice
//        existing.islM             = (data.islM?.isEmpty == false) ? data.islM : existing.islM
        existing.isCryptoSymbol   = (data.isCryptoSymbol?.isEmpty == false) ? data.isCryptoSymbol : existing.isCryptoSymbol
//        existing.isUSOnline       = (data.isUSOnline?.isEmpty == false) ? data.isUSOnline : existing.isUSOnline
        existing.indicator        = (data.indicator?.isEmpty == false) ? data.indicator : existing.indicator
        existing.isInAlerts       = (data.isInAlerts?.isEmpty == false) ? data.isInAlerts : existing.isInAlerts
        existing.isInPortfolio    = (data.isInPortfolio?.isEmpty == false) ? data.isInPortfolio : existing.isInPortfolio
        existing.isMargin         = (data.isMargin?.isEmpty == false) ? data.isMargin : existing.isMargin
        existing.lastTradePrice   = (data.lastTradePrice?.isEmpty == false) ? data.lastTradePrice : existing.lastTradePrice
        existing.lastTradeVolume  = (data.lastTradeVolume?.isEmpty == false) ? data.lastTradeVolume : existing.lastTradeVolume
        existing.losses           = (data.losses?.isEmpty == false) ? data.losses : existing.losses
        existing.lowPrice         = (data.lowPrice?.isEmpty == false) ? data.lowPrice : existing.lowPrice
        existing.marketType       = (data.marketType?.isEmpty == false) ? data.marketType : existing.marketType
        existing.maxPrice         = (data.maxPrice?.isEmpty == false) ? data.maxPrice : existing.maxPrice
        existing.minPrice         = (data.minPrice?.isEmpty == false) ? data.minPrice : existing.minPrice
        existing.netChange        = (data.netChange?.isEmpty == false) ? data.netChange : existing.netChange
        existing.netChangePerc    = (data.netChangePerc?.isEmpty == false) ? data.netChangePerc : existing.netChangePerc
        existing.offerPrice       = (data.offerPrice?.isEmpty == false) ? data.offerPrice : existing.offerPrice
        existing.offerVolume      = (data.offerVolume?.isEmpty == false) ? data.offerVolume : existing.offerVolume
        existing.openPrice        = (data.openPrice?.isEmpty == false) ? data.openPrice : existing.openPrice
        existing.pe               = (data.pe?.isEmpty == false) ? data.pe : existing.pe
        existing.pivotPoint       = (data.pivotPoint?.isEmpty == false) ? data.pivotPoint : existing.pivotPoint
        existing.precision        = (data.precision?.isEmpty == false) ? data.precision : existing.precision
        existing.profileID        = (data.profileID?.isEmpty == false) ? data.profileID : existing.profileID
        existing.resistance1      = (data.resistance1?.isEmpty == false) ? data.resistance1 : existing.resistance1
        existing.resistance2      = (data.resistance2?.isEmpty == false) ? data.resistance2 : existing.resistance2
        existing.sectorA          = (data.sectorA?.isEmpty == false) ? data.sectorA : existing.sectorA
        existing.sectorCode       = (data.sectorCode?.isEmpty == false) ? data.sectorCode : existing.sectorCode
        existing.sectorE          = (data.sectorE?.isEmpty == false) ? data.sectorE : existing.sectorE
        existing.support1         = (data.support1?.isEmpty == false) ? data.support1 : existing.support1
        existing.support2         = (data.support2?.isEmpty == false) ? data.support2 : existing.support2
        existing.symbol           = (data.symbol?.isEmpty == false) ? data.symbol : existing.symbol
        existing.symbolCapital    = (data.symbolCapital?.isEmpty == false) ? data.symbolCapital : existing.symbolCapital
        existing.symbolNameA      = (data.symbolNameA?.isEmpty == false) ? data.symbolNameA : existing.symbolNameA
        existing.symbolNameArabic = (data.symbolNameArabic?.isEmpty == false) ? data.symbolNameArabic : existing.symbolNameArabic
        existing.symbolNameE      = (data.symbolNameE?.isEmpty == false) ? data.symbolNameE : existing.symbolNameE
        existing.symbolNameEnglish = (data.symbolNameEnglish?.isEmpty == false) ? data.symbolNameEnglish : existing.symbolNameEnglish
        existing.symbolWithIcon   = (data.symbolWithIcon?.isEmpty == false) ? data.symbolWithIcon : existing.symbolWithIcon
        existing.topPrice         = (data.topPrice?.isEmpty == false) ? data.topPrice : existing.topPrice
        existing.totalBidVolume   = (data.totalBidVolume?.isEmpty == false) ? data.totalBidVolume : existing.totalBidVolume
        existing.totalOfferVolume = (data.totalOfferVolume?.isEmpty == false) ? data.totalOfferVolume : existing.totalOfferVolume
        existing.totalValue       = (data.totalValue?.isEmpty == false) ? data.totalValue : existing.totalValue
        existing.totalVolume      = (data.totalVolume?.isEmpty == false) ? data.totalVolume : existing.totalVolume
        existing.updateDateTime   = (data.updateDateTime?.isEmpty == false) ? data.updateDateTime : existing.updateDateTime
        existing.webCode          = (data.webCode?.isEmpty == false) ? data.webCode : existing.webCode
        existing.recid            = (data.recid?.isEmpty == false) ? data.recid : existing.recid
        existing.wk52High         = (data.wk52High?.isEmpty == false) ? data.wk52High : existing.wk52High
        existing.wk52Low          = (data.wk52Low?.isEmpty == false) ? data.wk52Low : existing.wk52Low
        existing.wk52Range        = (data.wk52Range?.isEmpty == false) ? data.wk52Range : existing.wk52Range

        marketWatchData = existing
        
    }
}
