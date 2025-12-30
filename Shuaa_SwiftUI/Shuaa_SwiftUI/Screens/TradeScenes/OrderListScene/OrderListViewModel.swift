//
//  OrderListViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 11/08/2025.
//

import Foundation
class OrderListViewModel: ObservableObject {
    private let coordinator: TradeCoordinatorProtocol
    private let useCase: LookupsUseCaseProtocol
    
    @Published var sendOrdersAPIResult: APIResultType<OrderListUIModel>?
    @Published var getLookupsAPIResult:APIResultType<[GetLookupsUIModel]>?
    @Published var getCompaniesLookupsAPIResult:APIResultType<[GetCompaniesLookupsUIModel]>?
    @Published var companiesLookups:[GetCompaniesLookupsUIModel]? = []

    @Published var userData: GetUserAccountsUIModel?
    @Published var orderListData: [OrderListUIModel]?
    @Published var filteredSymbol:String = ""
    @Published var ordersReceived:[OrderListUIModel]?
    @Published var getLookupsList: [GetLookupsUIModel]?
    @Published var filterOSSList: [GetLookupsUIModel]? = []
    
    @Published var isEditOrder: Bool = false
    
    var selectedTypeOfTrade: TypeOfTrade?
    var isTrading: Bool?

    init(coordinator: TradeCoordinatorProtocol, useCase: LookupsUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.callGetLookupsAPI()
        
        userData = UserDefaultController().selectedUserAccount
        
        Connection_Hub.shared.orderListDelegate = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.sendOrdersSignalR()
        }
        debugPrint("Here here")
    }
    
        
//    func filterLookUps() {
//        
//        // Filter on 3 types: OPT, EXT, TIF
//        for i in 0..<(getLookupsList?.count ?? 0) {
//            if getLookupsList?[i].type == type {
//            }
//        }
//    }
}

// MARK: API Calls
extension OrderListViewModel {
    func callGetLookupsAPI() {
        let requestModel = GetLookupsRequestModel()
        getLookupsAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetLookups(requestModel: requestModel) {[weak self] result in
                self?.getLookupsAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getLookupsAPIResult = .onSuccess(response: success)
                    self?.getLookupsList = success.filter({$0.type == "OSS"})
                    UserDefaultController().tifList = success.filter({$0.type == "TIF"})
                    UserDefaultController().CUSTODYID = success.filter({$0.type == "CUST"}).first?.id ?? ""
                    self?.filterOSSList = self?.getLookupsList
//                    self?.filterLookUps()

                case .failure(let failure):
                        self?.getLookupsAPIResult = .onFailure(error: failure)
                    debugPrint("get lookups failure: \(failure)")

                }
            }
        }
    }

    
    func GetCompaniesLookupsAPI(success:Bool) {
        
        UserDefaultController().searchResultSymbol = ""

        let requestModel = GetCompaniesLookupsRequestModel()
        getCompaniesLookupsAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetCompaniesLookups(requestModel: requestModel) {[weak self] result in
                self?.getCompaniesLookupsAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getCompaniesLookupsAPIResult = .onSuccess(response: success)

                    self?.companiesLookups = success
                    
                    
                case .failure(let failure):
                        self?.getCompaniesLookupsAPIResult = .onFailure(error: failure)
                    
                    debugPrint("search list failure: \(failure)")

                }
            }
        }
    }
}

// MARK: SignalRs
extension OrderListViewModel {
    func sendOrdersSignalR(){
        debugPrint("Trying signalR method")
        if Connection_Hub.shared.isConnected() {
            debugPrint("SignalR is connected")
        } else {
            debugPrint("SignalR is not connected")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.sendOrdersSignalR()
            }
        }
        sendOrdersAPIResult = .onLoading(show:  true)
        if Connection_Hub.shared.chatHub != nil {
            do {
                
                let string = "[{\"ClientID\": \"\(KeyChainController.shared().clientID ?? "")\" , \"WebUserID\": \"\(KeyChainController.shared().webCode ?? "")\" , \"Exchange\": \"\" , \"Symbol\": \"\" , \"OrderID\": \"\" , \"SellBuyFlag\": \"\"}]"
                
                let data = string.data(using: .utf8)!
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] {

                        try Connection_Hub.shared.chatHub?.invoke(HubMethodType.sendOrders.rawValue, arguments: [UserDefaultController().username ?? "", jsonArray[0]]) { (result, error) in
                            if let e = error {
                                printToLog("sendOrders invoke Error: \(e)")
                            } else {
                                self.sendOrdersAPIResult = .onLoading(show: false)
                                printToLog("sendOrders invoke, \([UserDefaultController().username ?? "", jsonArray[0]]) Success!")
//                                self.GetLookupsAPI(success: true)

                            }
                        }
                    } else {
                        printToLog("sendOrders bad json")
                    }
                } catch let error {
                        printToLog("sendOrders chatHub error: \(error.localizedDescription)")
                    }
                  }  catch let error {
                      printToLog("sendOrders chatHub error: \(error.localizedDescription)")
                  }
                }
        }

}

// MARK: Routing
extension OrderListViewModel {
    func onBackTap() {
        
    }
    
    func onResetTap() {
        filteredSymbol = ""
        UserDefaultController().selectedSymbol = ""
    }
    
    func openSelectSharesScene(typeOfTrade: TypeOfTrade, isTrading: Bool = false) {
        selectedTypeOfTrade = typeOfTrade
        self.isTrading = isTrading
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openSelectSharesScene(delegate: self)
    }

    func openOrderDetailsScene(orderDetails: OrderListUIModel) {
        coordinator.openOrderDetailsScene(orderDetails: orderDetails, delegate: self)
    }
    
    func openTradeScene(stock: OrderListUIModel, typeOfTrade: TypeOfTrade) {
        
        let selectedStock:GetCompaniesLookupsUIModel = AppUtility.shared.loadCompanies().filter({$0.symbol == stock.Symbol}).first ?? .testUIModel()
        UserDefaultController().selectedSymbol = stock.Symbol
        UserDefaultController().selectedSymbolType = selectedStock.marketType
        
        coordinator.openTradeScene(stock: selectedStock, typeOfTrade: typeOfTrade, isEditOrder: isEditOrder, orderDetails: stock)
    }
    
    func getUserData() {
//        userData = UserUIModel(userID: "398235", nameEn: "AlSaed Younes", nameAr: "السيد يونس", purchasingPower: 41914134, purchasingValue: 41914134, commission: 41914134, totalValue: 41914134)
    }
    
    func openSelectPortfolioScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openSelectPortfolioScene(delegate: self, selectedUser: userData)
    }

    
//    func getOrderListData() {
//        var data: [OrderListUIModel] = []
//
//        data.append(OrderListUIModel(symbol: "QNB", image: "ic_QNB", nameEn: "QNBK", nameAr: "بنك الوطني", buySellFlag: "buy".localized, time: "19:20", shares: 1000, price: 20.800, theRest: 900, remaining: 100, status: "refused".localized))
//        data.append(OrderListUIModel(symbol: "ABQK", image: "ic_ABQK", nameEn: "Ahli Bank", nameAr: "بنك الأهلي", buySellFlag: "sell".localized, time: "19:20", shares: 1000, price: 20.800, theRest: 900, remaining: 100, status: "deleted".localized))
//        data.append(OrderListUIModel(symbol: "DOHI", image: "ic_DOHI", nameEn: "Doha Insurance", nameAr: "مجموعة الدوحة للتأمين", buySellFlag: "sell".localized, time: "19:20", shares: 1000, price: 20.800, theRest: 900, remaining: 100, status: "expired".localized))
//        data.append(OrderListUIModel(symbol: "DUBK", image: "ic_DUBK", nameEn: "Dukhan Bank", nameAr: "بنك دخان", buySellFlag: "buy".localized, time: "19:20", shares: 1000, price: 20.800, theRest: 900, remaining: 100, status: "implemented".localized))
//        data.append(OrderListUIModel(symbol: "QIBK", image: "ic_QIB", nameEn: "Qatar Islamic Bank", nameAr: "المصرف", buySellFlag: "sell".localized, time: "19:20", shares: 1000, price: 20.800, theRest: 900, remaining: 100, status: "implemented".localized))
//        data.append(OrderListUIModel(symbol: "QATI", image: "ic_QATI", nameEn: "Qatar Insurance", nameAr: "قطر للتأمين", buySellFlag: "sell".localized, time: "19:20", shares: 1000, price: 20.800, theRest: 900, remaining: 100, status: "implemented".localized))
//
//        orderListData = data
//    }
}

// MARK: Functions
extension OrderListViewModel {
    
}

// MARK: Delegates
extension OrderListViewModel: SelectPortfolioDelegate {
    func onSelect(user: GetUserAccountsUIModel?) {
        userData = user
        sendOrdersSignalR()
    }
}

extension OrderListViewModel: SelectSharesDelegate {
    func onSelect(share: GetCompaniesLookupsUIModel?) {
        
        UserDefaultController().selectedSymbol = share?.symbol ?? ""
        
        if isTrading ?? false {
            let selectedStock:GetCompaniesLookupsUIModel = AppUtility.shared.loadCompanies().filter({$0.symbol == share?.symbol}).first ?? .testUIModel()
            UserDefaultController().selectedSymbol = share?.symbol
            UserDefaultController().selectedSymbolType = selectedStock.marketType
            
            coordinator.openTradeScene(stock: selectedStock, typeOfTrade: selectedTypeOfTrade ?? .buy, isEditOrder: false, orderDetails: .initializer())
        } else {
            filteredSymbol = share?.symbol ?? ""
        }
        
    }
}

extension OrderListViewModel:OrderListDelegate{
    func onOrderReceived(order: [OrderListUIModel]) {
        ordersReceived = order
        orderListData = order
    }
}

extension OrderListViewModel: OrderDetailsDelegate {
    func onCancelOrder() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.sendOrdersSignalR()
        }
    }
    func onEditOrder(order: OrderListUIModel) {
        isEditOrder = true
        openTradeScene(stock: order, typeOfTrade: order.SellBuyFlag?.lowercased() == "b" ? .buy : .sell)
    }
}
