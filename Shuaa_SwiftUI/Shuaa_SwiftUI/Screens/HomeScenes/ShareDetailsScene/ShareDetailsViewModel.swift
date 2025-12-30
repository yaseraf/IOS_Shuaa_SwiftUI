//
//  ShareDetailsViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 27/07/2025.
//

import Foundation


class ShareDetailsViewModel: ObservableObject {
    private var coordinator: HomeCoordinatorProtocol
    private let useCase: TradeUseCaseProtocol
    private let homeUseCase: HomeUseCaseProtocol
    
//    @Published var selectedStock: GetMarketWatchByProfileIDUIModel
    @Published var depthByPriceData: [MarketDepthUIModel]?
    @Published var depthByOrderData: [MarketDepthUIModel]?
    @Published var wholeShareTradesData: [GetSymbolTradesFullObjectUIModel]?
    @Published var shareTradesSummaryData: [SendSymbolTradesSummaryObjectUIModel]?
    @Published var newsData: [NewsUIModel]?
    @Published var stockDetailsData:GetAllMarketWatchBySymbolUIModel?
    @Published var fullMDData: SubscribeMarketWatchSymbolsUIModel?
    @Published var marketNewsBySymbol:[GetAllMarketNewsBySymbolUIModel]?
    @Published var favoriteWatchlist:[GetMarketWatchByProfileIDUIModel] = []

    var fromSequence: Int = -1
    var toSequence: Int = 50
    
    @Published var subscribleMarketWatchSymbolsAPIResult:APIResultType<[GetMarketWatchByProfileIDUIModel]>?
    @Published var getAllMarketWatchBySymbolAPIResult:APIResultType<GetAllMarketWatchBySymbolUIModel>?
    @Published var getAllMarketNewsBySymbolAPIResult:APIResultType<[GetAllMarketNewsBySymbolUIModel]>?
    @Published var getAllProfilesLookupsByUserCodeAPIResult:APIResultType<[GetAllProfilesLookupsByUserCodeUIModel]>?
    @Published var addMarketWatchProfileNameAPIResult:APIResultType<AddMarketWatchProfileNameUIModel>?
    @Published var getMarketWatchByProfileIDAPIResult:APIResultType<[GetMarketWatchByProfileIDUIModel]>?
    @Published var AddMarketWatchProfileSymbolsAPIResult:APIResultType<[AddMarketWatchProfileSymbolsUIModel]>?
    @Published var DeleteMarketWatchProfileSymbolsAPIResult:APIResultType<DeleteMarketWatchProfileSymbolsUIModel>?

    
    init(coordinator: HomeCoordinatorProtocol, useCase: TradeUseCaseProtocol, homeUseCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.homeUseCase = homeUseCase
//        self.selectedStock = selectedStock
//        self.selectedStock = HomePortfolioUIModel.initializer()
        
        Connection_Hub.shared.marketWatchDelegate = self
        Connection_Hub.shared.shareDetailsDelegate = self
        
        depthByPriceData = []
        depthByOrderData = []
        wholeShareTradesData = []
        shareTradesSummaryData = []
        newsData = []
    }
    
        
}

// MARK: Mock Data
extension ShareDetailsViewModel {
    func getMarketDepthData() {
//        var depthData: [MarketDepthUIModel] = []
//        depthData.append(MarketDepthUIModel(offerQty: 2, offerVolume: 221400, offerPrice: 16.88, bidQty: 2, bidVolume: 5740, bidPrice: 16.82))
//        depthData.append(MarketDepthUIModel(offerQty: 2, offerVolume: 36922, offerPrice: 16.81, bidQty: 1, bidVolume: 20000, bidPrice: 16.94))
//        depthData.append(MarketDepthUIModel(offerQty: 3, offerVolume: 17500, offerPrice: 16.80, bidQty: 4, bidVolume: 1200, bidPrice: 16.96))
//        depthData.append(MarketDepthUIModel(offerQty: 4, offerVolume: 6500, offerPrice: 1678, bidQty: 2, bidVolume: 12400, bidPrice: 16.89))
//        depthData.append(MarketDepthUIModel(offerQty: 5, offerVolume: 10350, offerPrice: 14.78, bidQty: 5, bidVolume: 8900, bidPrice: 14.55))
//        depthData.append(MarketDepthUIModel(offerQty: 5, offerVolume: 3000, offerPrice: 15.91, bidQty: 7, bidVolume: 400, bidPrice: 15.90))
//        depthData.append(MarketDepthUIModel(offerQty: 5, offerVolume: 3000, offerPrice: 15.91, bidQty: 7, bidVolume: 400, bidPrice: 15.90))
//        depthData.append(MarketDepthUIModel(offerQty: 5, offerVolume: 3000, offerPrice: 15.91, bidQty: 7, bidVolume: 400, bidPrice: 15.90))
//        depthData.append(MarketDepthUIModel(offerQty: 5, offerVolume: 3000, offerPrice: 15.91, bidQty: 7, bidVolume: 400, bidPrice: 15.90))
//        depthData.append(MarketDepthUIModel(offerQty: 5, offerVolume: 3000, offerPrice: 15.91, bidQty: 7, bidVolume: 400, bidPrice: 15.90))
//        depthData.append(MarketDepthUIModel(offerQty: 5, offerVolume: 3000, offerPrice: 15.91, bidQty: 7, bidVolume: 400, bidPrice: 15.90))
//        
//        depthByPriceData = depthData
//        depthByOrderData = depthData
    }
    
    func getWholeShareTradesData() {
//        var wholeData: [WholeShareTradesUIModel] = []
//        wholeData.append(WholeShareTradesUIModel(price: 3.447, quantity: 6000, value: -0.003, change: -0.140, changePerc: 0.820, time: "12:58:03", type: "sell".localized))
//        wholeData.append(WholeShareTradesUIModel(price: 3.447, quantity: 6000, value: -0.003, change: -0.140, changePerc: 0.820, time: "12:58:03", type: "buy".localized))
//        wholeData.append(WholeShareTradesUIModel(price: 3.447, quantity: 6000, value: -0.003, change: 0.010, changePerc: 0.290, time: "12:58:03", type: "buy".localized))
//        wholeData.append(WholeShareTradesUIModel(price: 3.447, quantity: 6000, value: -0.003, change: 0.010, changePerc: 0.290, time: "12:58:03", type: "buy".localized))
//        wholeData.append(WholeShareTradesUIModel(price: 3.447, quantity: 6000, value: -0.003, change: -0.140, changePerc: 0.820, time: "12:58:03", type: "buy".localized))
//        wholeData.append(WholeShareTradesUIModel(price: 3.447, quantity: 6000, value: 0.024, change: 1.290, changePerc: 2.310, time: "12:58:03", type: "sell".localized))
//        
//        wholeShareTradesData = wholeData
    }
    
    func getShareTradesSummaryData() {
//        var sharesData: [ShareTradesSummaryUIModel] = []
//        sharesData.append(ShareTradesSummaryUIModel(price: 16.83, totalQty: 338500, noOfTrades: 5, value: 56969.55))
//        sharesData.append(ShareTradesSummaryUIModel(price: 16.84, totalQty: 14371.00, noOfTrades: 24, value: 242007.64))
//        sharesData.append(ShareTradesSummaryUIModel(price: 16.85, totalQty: 2722.00, noOfTrades: 44, value: 38576.75))
//        sharesData.append(ShareTradesSummaryUIModel(price: 16.86, totalQty: 7280.00, noOfTrades: 12, value: 122833.25))
//        sharesData.append(ShareTradesSummaryUIModel(price: 16.87, totalQty: 5999.00, noOfTrades: 33, value: 84927.39))
//        sharesData.append(ShareTradesSummaryUIModel(price: 16.88, totalQty: 11827.00, noOfTrades: 8, value: 199244.12))
//        sharesData.append(ShareTradesSummaryUIModel(price: 16.90, totalQty: 10669.00, noOfTrades: 29, value: 159361.42))
//        
//        shareTradesSummaryData = sharesData
    }
    
    func getNewsData() {
        var data: [NewsUIModel] = []
        data.append(NewsUIModel(dateEn: "29Dec2024", dateAr: "٢٩ ديسمبر ٢٠٢٤", descEn: "QNB Group Board of Directors Meeting to Decide on the Bank’s Financial Results.", descAr: "اجتماع مجلس إدارة مجموعة QNB للبت في النتائج المالية للبنك لعام 2024 ", detailsEn: "Please note that the Board of Directors of QNB Group will hold a meeting on 13 January 2025 to decide on the Bank’s 2024 financial results and proposed dividends. Please note that in accordance with the instructions of the Qatar Financial Markets Authority, QNB will stop buying back its shares during the lock-up period starting from 30 December 2024 and continuing until 13 January 2025 due to the expected publication of QNB Group’s annual financial results. The Bank will resume buying back shares effective 14 January 2025.", detailsAr: "يرجى العلم أن مجلس إدارة مجموعة QNB سيعقد اجتماعاً في 13 يناير 2025 للبت في النتائج المالية للبنك لعام 2024 وتوزيعات الأرباح المقترحة.كما يرجى العلم أنه بموجب تعليمات هيئة قطر للأسواق المالية سيتوقف QNB عن إعادة شراء أسهمه خلال فترة الإغلاق التي تبدأ من 30 ديسمبر 2024 وتستمر حتى 13 يناير 2025 بسبب النشر المرتقب للنتائج المالية السنوية لمجموعة QNB. وسيستأنف البنك عملية إعادة شراء الأسهم اعتباراً من 14 يناير 2025."))
        data.append(NewsUIModel(dateEn: "28Dec2024", dateAr: "٢٨ نوفمبر ٢٠٢٤", descEn: "QNB Group Board of Directors Meeting.", descAr: "فتح باب الترشيح لعضوية مجلس إدارة 2025", detailsEn: "Please note that the Board of Directors of QNB Group will hold a meeting on 13 January 2025 to decide on the Bank’s 2024 financial results and proposed dividends. Please note that in accordance with the instructions of the Qatar Financial Markets Authority, QNB will stop buying back its shares during the lock-up period starting from 30 December 2024 and continuing until 13 January 2025 due to the expected publication of QNB Group’s annual financial results. The Bank will resume buying back shares effective 14 January 2025.", detailsAr: "يرجى العلم أن مجلس إدارة مجموعة QNB سيعقد اجتماعاً في 13 يناير 2025 للبت في النتائج المالية للبنك لعام 2024 وتوزيعات الأرباح المقترحة.كما يرجى العلم أنه بموجب تعليمات هيئة قطر للأسواق المالية سيتوقف QNB عن إعادة شراء أسهمه خلال فترة الإغلاق التي تبدأ من 30 ديسمبر 2024 وتستمر حتى 13 يناير 2025 بسبب النشر المرتقب للنتائج المالية السنوية لمجموعة QNB. وسيستأنف البنك عملية إعادة شراء الأسهم اعتباراً من 14 يناير 2025."))
       
        newsData = data
    }

}

// MARK: Routing
extension ShareDetailsViewModel {
    func openNewsDetailsScene(data: GetAllMarketNewsBySymbolUIModel) {
        coordinator.openNewsDetailsScene(selectedNews: data)
    }
    
    func openLoginScene() {
        SceneDelegate.getAppCoordinator()?.startFlow(startWith: .login)
    }
    
    func openChartScene() {
        var selectedStock:GetCompaniesLookupsUIModel = AppUtility.shared.loadCompanies().filter({$0.symbol == UserDefaultController().selectedSymbol}).first ?? .testUIModel()
            UserDefaultController().selectedSymbolType = selectedStock.marketType

        coordinator.openChartScene(selectedStock: selectedStock)
    }
    
    func onBackTap() {
        coordinator.popViewController()
    }
    
    func openTradeScene(typeOfTrade: TypeOfTrade) {
        
        let selectedStock:GetCompaniesLookupsUIModel = AppUtility.shared.loadCompanies().filter({$0.symbol == UserDefaultController().selectedSymbol ?? ""}).first ?? .testUIModel()
        UserDefaultController().selectedSymbolType = selectedStock.marketType
        
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getTradeCoordinator().openTradeScene(stock: selectedStock, typeOfTrade: typeOfTrade, orderDetails: .initializer())
    }
}

// MARK: API Calls
extension ShareDetailsViewModel {
    func GetAllMarketWatchBySymbolAPI(success:Bool) {
        let requestModel = GetAllMarketWatchBySymbolRequestModel()
        getAllMarketWatchBySymbolAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetAllMarketWatchBySymbol(requestModel: requestModel) {[weak self] result in
                self?.getAllMarketWatchBySymbolAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getAllMarketWatchBySymbolAPIResult = .onSuccess(response: success)
                    
                    self?.stockDetailsData = success
//                    self?.UnSubscribleMarketWatchSymbolsSignalR()
                    self?.SubscribeMarketWatchSymbolsSignalR()
                    UserDefaultController().selectedMarket = success.exchange
                    
                    debugPrint("market Symbol success: ")
                    
                case .failure(let failure):
                        self?.getAllMarketWatchBySymbolAPIResult = .onFailure(error: failure)
                    debugPrint("market Symbol failure: \(failure)")
                }
            }
        }
    }
    
    func GetAllMarketNewsBySymbol(success:Bool) {
        let requestModel = GetAllMarketNewsBySymbolRequestModel()
        getAllMarketNewsBySymbolAPIResult = .onLoading(show: true)
        
        Task.init {
            await homeUseCase.GetAllMarketNewsBySymbol(requestModel: requestModel) {[weak self] result in
                self?.getAllMarketNewsBySymbolAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getAllMarketNewsBySymbolAPIResult = .onSuccess(response: success)
                    debugPrint("market news by symbol stocks success")
                    self?.marketNewsBySymbol = success

                case .failure(let failure):
                        self?.getAllMarketNewsBySymbolAPIResult = .onFailure(error: failure)
                    debugPrint("market news by symbol stocks failure")
                }
            }
        }
    }
    
    func GetAllProfilesLookupsByUserCodeAPI(success:Bool, selectedSymbol: String) {
        let requestModel = GetAllProfilesLookupsByUserCodeRequestModel()
        
        getAllProfilesLookupsByUserCodeAPIResult = .onLoading(show: true)
        
        Task.init {
            await homeUseCase.GetAllProfilesLookupsByUserCode(requestModel: requestModel) {[weak self] result in
                switch result {
                case .success(let success):
                    self?.getAllProfilesLookupsByUserCodeAPIResult = .onSuccess(response: success)

                    if success.contains(where: {$0.profileName == "fav"}) {
                        UserDefaultController().profileID = success.first(where: {$0.profileName == "fav"})?.profileID ?? ""
                        
                        self?.filterGetMarketWatchByProfileIDAPI(success: true, selectedSymbol: selectedSymbol)

                    } else {
                        UserDefaultController().profileName = "fav"
                        self?.AddMarketWatchProfileNameAPI(success: true, selectedSymbol: selectedSymbol)
                    }
                    
                    debugPrint("Watchlist success")
                    
                case .failure(let failure):
                        self?.getAllProfilesLookupsByUserCodeAPIResult = .onFailure(error: failure)
                    debugPrint("Watchlist failure: \(failure)")
                }
            }
        }
    }

    func AddMarketWatchProfileNameAPI(success:Bool, selectedSymbol: String) {
        let requestModel = AddMarketWatchProfileNameRequestModel()
        addMarketWatchProfileNameAPIResult = .onLoading(show: true)
        
        Task.init {
            await homeUseCase.AddMarketWatchProfileName(requestModel: requestModel) {[weak self] result in
                self?.addMarketWatchProfileNameAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.addMarketWatchProfileNameAPIResult = .onSuccess(response: success)
                    UserDefaultController().profileID = success.profileID ?? ""

                    self?.AddMarketWatchProfileSymbols(success:true, selectedSymbol: selectedSymbol)
                    
                    debugPrint("New watchlist added successfulll")
                    
                case .failure(let failure):
                        self?.addMarketWatchProfileNameAPIResult = .onFailure(error: failure)
                    debugPrint("New watchlist added failed")

                }
            }
        }
    }
    
    func initialGetAllProfilesLookupsByUserCodeAPI(success:Bool) {
        let requestModel = GetAllProfilesLookupsByUserCodeRequestModel()
        
        getAllProfilesLookupsByUserCodeAPIResult = .onLoading(show: true)
        
        Task.init {
            await homeUseCase.GetAllProfilesLookupsByUserCode(requestModel: requestModel) {[weak self] result in
                switch result {
                case .success(let success):
                    self?.getAllProfilesLookupsByUserCodeAPIResult = .onSuccess(response: success)

                    if success.contains(where: {$0.profileName == "fav"}) {
                        UserDefaultController().profileID = success.first(where: {$0.profileName == "fav"})?.profileID ?? ""
                        self?.GetMarketWatchByProfileIDAPI(success: true)
                    } else {
                        self?.favoriteWatchlist = []
                    }
                    
                    debugPrint("Watchlist success")
                    
                case .failure(let failure):
                        self?.getAllProfilesLookupsByUserCodeAPIResult = .onFailure(error: failure)
                    debugPrint("Watchlist failure: \(failure)")
                }
            }
        }
    }
    
    func filterGetMarketWatchByProfileIDAPI(success:Bool, selectedSymbol:String) {
        let requestModel = GetMarketWatchByProfileIDRequestModel()
        getMarketWatchByProfileIDAPIResult = .onLoading(show: true)
        
        Task.init {
            await homeUseCase.GetMarketWatchByProfileID(requestModel: requestModel) {[weak self] result in
                self?.getMarketWatchByProfileIDAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getMarketWatchByProfileIDAPIResult = .onSuccess(response: success)
                    debugPrint("Get market watch by profile id success")

                    if success.contains(where: {$0.symbol == selectedSymbol}) {
                        self?.DeleteMarketWatchProfileSymbols(success: true, selectedSymbol: selectedSymbol)
                    } else {
                        self?.AddMarketWatchProfileSymbols(success: true, selectedSymbol: selectedSymbol)
                    }
                    
                    self?.favoriteWatchlist = success
                    
                case .failure(let failure):
                        self?.getMarketWatchByProfileIDAPIResult = .onFailure(error: failure)
                    debugPrint("Get market watch by profile id success: \(failure)")
                }
            }
        }
    }

    func GetMarketWatchByProfileIDAPI(success:Bool) {
        let requestModel = GetMarketWatchByProfileIDRequestModel()
        getMarketWatchByProfileIDAPIResult = .onLoading(show: true)
        
        Task.init {
            await homeUseCase.GetMarketWatchByProfileID(requestModel: requestModel) {[weak self] result in
                self?.getMarketWatchByProfileIDAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getMarketWatchByProfileIDAPIResult = .onSuccess(response: success)
                    debugPrint("Get market watch by profile id success")
                    
                    self?.favoriteWatchlist = success
                    
                case .failure(let failure):
                        self?.getMarketWatchByProfileIDAPIResult = .onFailure(error: failure)
                    debugPrint("Get market watch by profile id success: \(failure)")
                }
            }
        }
    }
    
    func AddMarketWatchProfileSymbols(success:Bool, selectedSymbol: String) {
        
        let requestModel = AddMarketWatchProfileSymbolsRequestModel(profileID: UserDefaultController().profileID ?? "", symbols: [selectedSymbol], webCode: KeyChainController.shared().webCode ?? "")
        
        AddMarketWatchProfileSymbolsAPIResult = .onLoading(show: true)
        
        Task.init {
            await homeUseCase.AddMarketWatchProfileSymbols(requestModel: requestModel) {[weak self] result in
                self?.AddMarketWatchProfileSymbolsAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.AddMarketWatchProfileSymbolsAPIResult = .onSuccess(response: success)

                    self?.GetMarketWatchByProfileIDAPI(success: true)

                    debugPrint("Add market wtach profile symbols success")
                    
                case .failure(let failure):
                        self?.AddMarketWatchProfileSymbolsAPIResult = .onFailure(error: failure)
                    debugPrint("Add market wtach profile symbols success: \(failure)")

                }
            }
        }
    }
    
    func DeleteMarketWatchProfileSymbols(success:Bool, selectedSymbol: String) {
        
        let requestModel = DeleteMarketWatchProfileSymbolsRequestModel(profileID: UserDefaultController().profileID ?? "", symbols: [selectedSymbol], webCode: KeyChainController.shared().webCode ?? "")
        
        DeleteMarketWatchProfileSymbolsAPIResult = .onLoading(show: true)
        
        Task.init {
            await homeUseCase.DeleteMarketWatchProfileSymbols(requestModel: requestModel) {[weak self] result in
                self?.AddMarketWatchProfileSymbolsAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.DeleteMarketWatchProfileSymbolsAPIResult = .onSuccess(response: success)
                    self?.GetMarketWatchByProfileIDAPI(success: true)

                    debugPrint("Delete market wtach profile symbols success")
                    
                case .failure(let failure):
                        self?.DeleteMarketWatchProfileSymbolsAPIResult = .onFailure(error: failure)
                    debugPrint("Delete market wtach profile symbols success: \(failure)")

                }
            }
        }
    }

}

// MARK: SignalR
extension ShareDetailsViewModel {
    func SubscribeMarketWatchSymbolsSignalR() {
        subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  true)
        
        if Connection_Hub.shared.chatHub != nil {
            do {
                debugPrint("test invoke subscribeMarketWatchSymbols '\(stockDetailsData?.symbol)'")

                try Connection_Hub.shared.chatHub?.invoke(HubMethodType.subscribeMarketWatchSymbols.rawValue, arguments: [KeyChainController().username ?? "", [stockDetailsData?.symbol]]) { (result, error) in
                    if let e = error {
                        debugPrint("SubscribeMarketWatchSymbols invoke '\(self.stockDetailsData?.symbol)' Error: \(e)")
                        self.subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  false)

                    } else {
                        debugPrint("SubscribeMarketWatchSymbols invoke '\(self.stockDetailsData?.symbol)' Success!, appDelegate.userNameNotEncryptrd\("info3@fitmena.com")")
                        self.subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  false)
                    }
                }
            } catch let error {
                debugPrint("SubscribeMarketWatchSymbols chatHub '\(stockDetailsData?.symbol)' error: \(error.localizedDescription)")
                self.subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  false)

            }
        } else {
            debugPrint("Chathub is nil")
        }
    }
    

    func UnSubscribleMarketWatchSymbolsSignalR(){
        subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  true)
        
        if Connection_Hub.shared.chatHub != nil {
            do {
                debugPrint("test invoke unSubscribeMarketWatchSymbols")

                try Connection_Hub.shared.chatHub?.invoke(HubMethodType.unSubscribeMarketWatchSymbols.rawValue, arguments: [KeyChainController().username ?? ""]) { (result, error) in
                    if let e = error {
                        debugPrint("unSubscribeMarketWatchSymbols invoke Error: \(e)")
                    } else {
                        debugPrint("unSubscribeMarketWatchSymbols invoke Success!, appDelegate.userNameNotEncryptrd\("info3@fitmena.com")")
                        self.SubscribeMarketWatchSymbolsSignalR()
                    }
                }
            } catch let error {
                debugPrint("unSubscribeMarketWatchSymbols chatHub error: \(error.localizedDescription)")
            }
        }
    }


    func SendSymbolTradesSummaryObject(){
    
        if Connection_Hub.shared.chatHub != nil {
            do {
                printToLog("test invoke sendSymbolTradesSummaryObject '\(UserDefaultController().selectedSymbol ?? "")'")
                
                try Connection_Hub.shared.chatHub?.invoke(HubMethodType.sendSymbolTradesSummaryObject.rawValue, arguments: [UserDefaultController().selectedSymbol ?? ""]) { (result, error) in
                    if let e = error {
                        printToLog("sendSymbolTradesSummaryObject invoke '\(UserDefaultController().selectedSymbol ?? "")' Error: \(e)")
                    } else {
                        printToLog("sendSymbolTradesSummaryObject invoke '\(UserDefaultController().selectedSymbol ?? "")' Success!")
                    }
                }
            } catch let error {
                printToLog("sendSymbolTradesSummaryObject chatHub '\(UserDefaultController().selectedSymbol ?? "")' error: \(error.localizedDescription)")
            }
        }
    }
    
    func subscribeFullMDSymbols() {
        if Connection_Hub.shared.chatHub != nil {
            do {
                debugPrint("test invoke SubscribeFullMDSymbol '\(UserDefaultController().selectedSymbol ?? "")'")
                
                try Connection_Hub.shared.chatHub?.invoke(HubMethodType.SubscribeFullMDSymbol.rawValue, arguments: [UserDefaultController().username ?? "", UserDefaultController().selectedSymbol ?? ""]) { (result, error) in
                    if let e = error {
                        debugPrint("SubscribeFullMDSymbol invoke '\(UserDefaultController().selectedSymbol ?? "")' Error: \(e)")
                    } else {
                        debugPrint("SubscribeFullMDSymbol invoke '\(UserDefaultController().selectedSymbol ?? "")' Success!")
                    }
                }
            } catch let error {
                debugPrint("SubscribeFullMDSymbol chatHub '\(UserDefaultController().selectedSymbol ?? "")' error: \(error.localizedDescription)")
            }
        }
    }
    
    func unSubscribeFullMDSymbols() {
        if Connection_Hub.shared.chatHub != nil {
            do {
                debugPrint("test invoke unSubscribeFullMDSymbols '\(UserDefaultController().selectedSymbol ?? "")'")
                
                try Connection_Hub.shared.chatHub?.invoke(HubMethodType.unSubscribeFullMDSymbol.rawValue, arguments: [UserDefaultController().username ?? "", UserDefaultController().selectedSymbol ?? ""]) { (result, error) in
                    if let e = error {
                        debugPrint("unSubscribeFullMDSymbols invoke '\(UserDefaultController().selectedSymbol ?? "")' Error: \(e)")
                    } else {
                        debugPrint("unSubscribeFullMDSymbols invoke '\(UserDefaultController().selectedSymbol ?? "")' Success!")
                    }
                }
            } catch let error {
                debugPrint("unSubscribeFullMDSymbols chatHub '\(UserDefaultController().selectedSymbol ?? "")' error: \(error.localizedDescription)")
            }
        }
    }

    func getSymbolTradesFullObject(){
    
        if Connection_Hub.shared.chatHub != nil {
            do {
                debugPrint("test invoke getSymbolTradesFullObject '\(UserDefaultController().selectedSymbol ?? "")'")
                
                try Connection_Hub.shared.chatHub?.invoke(HubMethodType.getSymbolTradesFullObject.rawValue, arguments: [UserDefaultController().selectedSymbol ?? "", fromSequence, toSequence]) { (result, error) in
                    if let e = error {
                        debugPrint("getSymbolTradesFullObject invoke '\(UserDefaultController().selectedSymbol ?? "")' Error: \(e)")
                    } else {
                        debugPrint("getSymbolTradesFullObject invoke '\(UserDefaultController().selectedSymbol ?? "")' Success!")
                    }
                }
            } catch let error {
                debugPrint("getSymbolTradesFullObject chatHub '\(UserDefaultController().selectedSymbol ?? "")' error: \(error.localizedDescription)")
            }
        }
    }

}

// MARK: Functions
extension ShareDetailsViewModel {
    func stockFavorite(symbol: String) {
        GetAllProfilesLookupsByUserCodeAPI(success: true, selectedSymbol: symbol)
    }

    private func extractUsableDepthByPrice(mBP: String){
        
        var listMarketByPrice:[MarketDepthUIModel] = []

        // Algorithm for cut the market data
        if(mBP != nil && mBP.components(separatedBy: ">").count > 3) {
            printToLog("setMarketDepthValue depthByPrice: \(mBP ?? "")")
            
            let depthByPrice = (mBP ?? "").replacingOccurrences(of: ">D10>", with: "").replacingOccurrences(of: ">D11>", with: "").replacingOccurrences(of: ">0001", with: "").replacingOccurrences(of: ">0002", with: "").replacingOccurrences(of: ">0003", with: "").replacingOccurrences(of: ">0004", with: "").replacingOccurrences(of: ">0005", with: "").replacingOccurrences(of: ">0006", with: "").replacingOccurrences(of: ">0007", with: "").replacingOccurrences(of: ">0008", with: "").replacingOccurrences(of: ">0009", with: "").replacingOccurrences(of: "#", with: "")
            print("setMarketDepthValue depthByPrice:",mBP)
            
            // if(appDelegate.isConnected && selectedSymbol.isFromTops && depthByPrice.components(separatedBy: ">").count > 6){
            //     let arrayData = depthByPrice.components(separatedBy: ">")
            //     let replaceString = ">" + arrayData[1] + ">" + arrayData[2] + ">" + arrayData[3] + ">" + arrayData[4]
            //     let replaceWithString = arrayData[2]
            //     depthByPrice = depthByPrice.replacingOccurrences(of: replaceString, with: replaceWithString)
            // }
            
            // ">DFM >0 >10 >1.18>9>1213663 >1.19>1>110000 >1.2>4>300000 >1.21>4>662000 >1.22>3>1103495 >1.23>5>1555300 >1.24>5>1002300 >1.25>17>3507770 >1.26>9>919394 >1.27>9>884500>#",
            

            let maxRow = Int(depthByPrice.components(separatedBy: ">")[1]) ?? 0
            printToLog("maxRow =\(maxRow)")
            
            if(maxRow > 0) {
                for i in 0..<maxRow {
                    let clientBidQty = (depthByPrice.components(separatedBy: ">")[(i * 3) + 3])
                    let bidQty = (depthByPrice.components(separatedBy: ">")[(i * 3) + 4])
                    let bid = (depthByPrice.components(separatedBy: ">")[(i * 3) + 2])
                    listMarketByPrice.append(MarketDepthUIModel(bidQty: bidQty, bidNumber: clientBidQty, bid: bid, askQty: "0", askNumber: "0", ask: "0"))
                }
                // "ARMX  >5  >2.78 >3>12500  >2.77>1 >80000  >2.75>4>216006  >2.74>1>100000  >2.72>2>77000   >4  >2.8  >1>126503 >2.83>1>250000  >2.85 >2>37000  >2.86>1>10000>",
                // "TAQA  >5  >0.435>1>50000  >0.432>2>88453  >0   >0>0       >0   >0>0       >0   >0>0       >5  >0.479>1>173611 >0.48>2>250498  >0.481>1>300000 >0.482>1>150000 >0.494>1>28000>",
            }
            
            var secondMaxRow = 0
            var offerIndex = 2 + (maxRow * 3)
            printToLog("depthByPrice offerIndex = \(offerIndex)")
            
            if depthByPrice.components(separatedBy: ">").count > offerIndex {
                
                secondMaxRow = Int(depthByPrice.components(separatedBy: ">")[offerIndex]) ?? 0
                printToLog("depthByPrice secondMaxRow = \(secondMaxRow)")
                
                while (secondMaxRow == 0) && (depthByPrice.components(separatedBy: ">").count > offerIndex)
                        && (depthByPrice.components(separatedBy: ">")[offerIndex].isEmpty) {
                    
                    if (secondMaxRow == 0) && (depthByPrice.components(separatedBy: ">")[offerIndex].isEmpty) {
                        if depthByPrice.components(separatedBy: ">").count > (offerIndex + 3) {
                            if depthByPrice.components(separatedBy: ">")[offerIndex + 1].isEmpty
                                && depthByPrice.components(separatedBy: ">")[offerIndex + 2].isEmpty {
                                
                                offerIndex += 3
                                secondMaxRow = Int(depthByPrice.components(separatedBy: ">")[offerIndex]) ?? 0
                                
                                printToLog("depthByPrice new offerIndex = \(offerIndex)")
                                printToLog("depthByPrice new secondMaxRow = \(secondMaxRow)")
                            }
                        }
                    }
                }
                
                for i in 0..<secondMaxRow {
                    let cnstnt = offerIndex + 1
                    let clientOfferQty = (depthByPrice.components(separatedBy: ">")[cnstnt + (i * 3) + 1])
                    let askQty = (depthByPrice.components(separatedBy: ">")[cnstnt + (i * 3) + 2])
                    let ask = (depthByPrice.components(separatedBy: ">")[cnstnt + (i * 3)])
                    
                    if i < listMarketByPrice.count {
                        listMarketByPrice[i].ask = ask
                        listMarketByPrice[i].askQty = askQty
                        listMarketByPrice[i].askNumber = clientOfferQty
                    }
                    else {
                        listMarketByPrice.append(MarketDepthUIModel(bidQty: "0", bidNumber: "0", bid: "0", askQty: askQty, askNumber: clientOfferQty, ask: ask))
                    }
                }
            }
            
            if max(maxRow, secondMaxRow) < 15 {
                for _ in max(maxRow, secondMaxRow)..<15{
                    listMarketByPrice.append(MarketDepthUIModel(bidQty: "0", bidNumber: "0", bid: "0", askQty: "0", askNumber: "0", ask: "0"))
                }
            }
            

        }
        else {
            for _ in 0..<15{
                listMarketByPrice.append(MarketDepthUIModel(bidQty: "0", bidNumber: "0", bid: "0", askQty: "0", askNumber: "0", ask: "0"))
            }

        }

        depthByPriceData = listMarketByPrice

        
        debugPrint("Print here")
    }
    
    private func extractUsableDepthByOrder(mBO: String){
        var listMarketByOrder:[MarketDepthUIModel] = []

        if(mBO != nil && mBO.components(separatedBy: ">").count > 3) {
            printToLog("setMarketDepthValue depthBuyOrder init: \(mBO ?? "")")
            
            let depthBuyOrder = (mBO ?? "").replacingOccurrences(of: ">D10>", with: "").replacingOccurrences(of: ">D11>", with: "").replacingOccurrences(of: ">0001", with: "").replacingOccurrences(of: ">0002", with: "").replacingOccurrences(of: ">0003", with: "").replacingOccurrences(of: ">0004", with: "").replacingOccurrences(of: ">0005", with: "").replacingOccurrences(of: ">0006", with: "").replacingOccurrences(of: ">0007", with: "").replacingOccurrences(of: ">0008", with: "").replacingOccurrences(of: ">0009", with: "").replacingOccurrences(of: "#", with: "")
            print("setMarketDepthValue depthBuyOrder:",depthBuyOrder)
            
            //if(appDelegate.isConnected && selectedSymbol.isFromTops && depthBuyOrder.components(separatedBy: ">").count > 6){
            //    let arrayData = depthBuyOrder.components(separatedBy: ">")
            //    let replaceString = ">" + arrayData[1] + ">" + arrayData[2] + ">" + arrayData[3] + ">" + arrayData[4]
            //    let replaceWithString = arrayData[2]
            //    depthBuyOrder = depthBuyOrder.replacingOccurrences(of: replaceString, with: replaceWithString)
            //}
            
            //selectedSymbol.depthBuyOrder = "EMAAR>9>32>>1>31.85>>10>31.75>>10>31.65>>10>30>>100>30>>2000>30>>2000>29.8>>5000>29>>10>5>35>>6900>36>>11>36.65>>10>36.7>>10>36.75>>10>"
            
            
            let maxRow = Int(depthBuyOrder.components(separatedBy: ">")[1]) ?? 0
            printToLog("maxRow =\(maxRow)")
            // printToLog("depthBuyOrder split > =\( depthBuyOrder.components(separatedBy: ">").count)")
            
            if maxRow > 0 {
                for i in 0..<maxRow {
                    //let bidQty = (depthBuyOrder!.components(separatedBy: ">")[(i * 2) + 3])
                    //let bid = (depthBuyOrder!.components(separatedBy: ">")[(i * 2) + 2])
                    //depthData.append(StockDepthItem(clientBidQty: "0", bidQty: bidQty, bid: bid, offer: "0", offerQty: "0", clientOfferQty: "0"))
                    
                    let bidQty = (depthBuyOrder.components(separatedBy: ">")[(i * 3) + 4])
                    let bid = (depthBuyOrder.components(separatedBy: ">")[(i * 3) + 2])
                    listMarketByOrder.append(MarketDepthUIModel(bidQty: bidQty, bidNumber: "0", bid: bid, askQty: "0", askNumber: "0", ask: "0"))
                }
            }
            
            // "TAQA >5 >0.435>50000 >0.432>88453 >0>0 >0>0 >0>0 >5 >0.479>173611 >0.48>250498 >0.481>300000 >0.482>150000 >0.494>28000>",
            // "EMAAR >9  >32>  >1>31.85    >>10 >31.75> >10>31.65 >>10 >30>    >100>30   >>2000 >30>    >2000>29.8 >>5000 >29>    >10>5     >35> >6900>36  >>11 >36.65> >10>36.7 >>10>36.75>>10>"
            
            var secondMaxRow = 0
            var offerIndex = 2 + (maxRow * 3)
            printToLog("depthByOrder offerIndex = \(offerIndex)")
            
            if depthBuyOrder.components(separatedBy: ">").count > offerIndex {
                secondMaxRow = Int(depthBuyOrder.components(separatedBy: ">")[offerIndex]) ?? 0
                printToLog("depthByOrder secondMaxRow = \(secondMaxRow)")
                
                while (secondMaxRow == 0) && (depthBuyOrder.components(separatedBy: ">").count > offerIndex)
                        && (depthBuyOrder.components(separatedBy: ">")[offerIndex].isEmpty) {
                    
                    if (secondMaxRow == 0) && (depthBuyOrder.components(separatedBy: ">")[offerIndex].isEmpty) {
                        if depthBuyOrder.components(separatedBy: ">").count > (offerIndex + 3) {
                            if depthBuyOrder.components(separatedBy: ">")[offerIndex + 1].isEmpty
                                && depthBuyOrder.components(separatedBy: ">")[offerIndex + 2].isEmpty {
                                
                                offerIndex += 3
                                secondMaxRow = Int(depthBuyOrder.components(separatedBy: ">")[offerIndex]) ?? 0
                                
                                printToLog("depthByOrder new offerIndex = \(offerIndex)")
                                printToLog("depthByOrder new secondMaxRow = \(secondMaxRow)")
                            }
                        }
                    }
                }
                
                for i in 0..<secondMaxRow {
                    //let cnstnt = 3 + Int(maxRow)! * 2
                    //let offerQty = (depthBuyOrder!.components(separatedBy: ">")[cnstnt + (i * 2) + 1])
                    //let offer = (depthBuyOrder!.components(separatedBy: ">")[cnstnt + (i * 2)])
                    
                    let cnstnt = offerIndex + 1
                    let askQty = ((depthBuyOrder.components(separatedBy: ">").count > (cnstnt + (i * 3) + 2)) ? depthBuyOrder.components(separatedBy: ">")[cnstnt + (i * 3) + 2] : "0")
                    let ask = ((depthBuyOrder.components(separatedBy: ">").count > (cnstnt + (i * 3))) ? depthBuyOrder.components(separatedBy: ">")[cnstnt + (i * 3)] : "0")
                    
                    if i < listMarketByOrder.count {
                        listMarketByOrder[i].ask = ask
                        listMarketByOrder[i].askQty = askQty
                    }
                    else {//MARK: MKH- Check errorhete
                        listMarketByOrder.append(MarketDepthUIModel(bidQty: "0", bidNumber: "0", bid: "0", askQty: askQty, askNumber: "0", ask: ask))
                    }
                }
            }
            
            if max(maxRow, secondMaxRow) < 15 {
                for _ in max(maxRow, secondMaxRow)..<max(15,secondMaxRow){
                    listMarketByOrder.append(MarketDepthUIModel(bidQty: "0", bidNumber: "0", bid: "0", askQty: "0", askNumber: "0", ask: "0"))
                }
            }
            
        }
        else {
            for _ in 0..<15{
                listMarketByOrder.append(MarketDepthUIModel(bidQty: "0", bidNumber: "0", bid: "0", askQty: "0", askNumber: "0", ask: "0"))
            }
            
        }
      
        depthByOrderData = listMarketByOrder

    }
}

// MARK: Delegate
extension ShareDetailsViewModel: MarketWatchDelegate {
    func onSubscribeMDSymbol(data: SubscribeMarketWatchSymbolsUIModel) {
        if data.MBP?.isEmpty == false && data.MBO?.isEmpty == false {
            fullMDData = data
            extractUsableDepthByPrice(mBP: fullMDData?.MBP ?? "")
            extractUsableDepthByOrder(mBO: fullMDData?.MBO ?? "")
            
            debugPrint("Market depth data MBP: ", fullMDData?.MBP ?? "Nil")
            debugPrint("Market depth data MBO: ", fullMDData?.MBO ?? "Nil")
        } else {
            debugPrint("Market depth data but some is empty, MBP: \(data.MBP ?? ""), MBO: \(data.MBO ?? "")")
        }
    }
    
    func onWatchlistDataReceive(data: GetMarketWatchByProfileIDUIModel) {
        stockDetailsData?.netChange = data.netChange
        stockDetailsData?.netChangePerc = data.netChangePerc
        stockDetailsData?.executed = data.executed
        stockDetailsData?.totalVolume = data.totalVolume
//        stockDetailsData?.companyFaceValue = data.face
        stockDetailsData?.closePrice = data.closePrice
        stockDetailsData?.openPrice = data.openPrice
        stockDetailsData?.lowPrice = data.lowPrice
        stockDetailsData?.highPrice = data.highPrice
        stockDetailsData?.lastTradePrice = data.lastTradePrice
        stockDetailsData?.offerPrice = data.offerPrice
        stockDetailsData?.offerVolume = data.offerVolume
        stockDetailsData?.bidPrice = data.bidPrice
        stockDetailsData?.bidVolume = data.bidVolume
    }
}

extension ShareDetailsViewModel: ShareDetailsDelegate {
    func onSendSymbolTradesSummaryObject(data: [SendSymbolTradesSummaryObjectUIModel]) {
        shareTradesSummaryData = data
    }
    
    func onGetSymbolTradesFullObject(data: [GetSymbolTradesFullObjectUIModel]) {
//        fromSequence = toSequence + 1
//        toSequence += 51
        wholeShareTradesData = data
    }
}
