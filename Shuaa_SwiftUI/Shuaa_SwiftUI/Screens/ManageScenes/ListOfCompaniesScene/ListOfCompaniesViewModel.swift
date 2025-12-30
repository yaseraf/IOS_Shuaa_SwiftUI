//
//  ListOfCompaniesViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/08/2025.
//

import Foundation

class ListOfCompaniesViewModel: ObservableObject {
    private let coordinator: ManageCoordinatorProtocol
    private let useCase: LookupsUseCaseProtocol
    private let homeUseCase: HomeUseCaseProtocol

    @Published var listOfCompaniesData:[CompaniesUIModel]?
    @Published var selectedShare: GetCompaniesLookupsUIModel?

    @Published var companiesLookups:[GetCompaniesLookupsUIModel] = []
    @Published var favoriteWatchlist:[GetMarketWatchByProfileIDUIModel] = []

    @Published var getCompaniesLookupsAPIResult:APIResultType<[GetCompaniesLookupsUIModel]>?
    @Published var getAllProfilesLookupsByUserCodeAPIResult:APIResultType<[GetAllProfilesLookupsByUserCodeUIModel]>?
    @Published var addMarketWatchProfileNameAPIResult:APIResultType<AddMarketWatchProfileNameUIModel>?
    @Published var getMarketWatchByProfileIDAPIResult:APIResultType<[GetMarketWatchByProfileIDUIModel]>?
    @Published var AddMarketWatchProfileSymbolsAPIResult:APIResultType<[AddMarketWatchProfileSymbolsUIModel]>?
    @Published var DeleteMarketWatchProfileSymbolsAPIResult:APIResultType<DeleteMarketWatchProfileSymbolsUIModel>?

    init(coordinator: ManageCoordinatorProtocol, useCase: LookupsUseCaseProtocol, homeUseCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.homeUseCase = homeUseCase
        
        listOfCompaniesData = []
    }
}


// MARK: Routing
extension ListOfCompaniesViewModel {
    func onBackTap() {
        coordinator.popViewController()
    }
}

// MARK: Mock Data
extension ListOfCompaniesViewModel {
    func getListOfCompaniesData() {
//        var data: [CompaniesUIModel] = []
//        data.append(CompaniesUIModel(image: "ic_QNB", symbol: "QNBK", fullNameE: "QNB", fullNameA: "بنك الوطني"))
//        data.append(CompaniesUIModel(image: "ic_ABQK", symbol: "ABQK", fullNameE: "Ahli Bank", fullNameA: "بنك الأهلي"))
//        data.append(CompaniesUIModel(image: "ic_DOHI", symbol: "DOHI", fullNameE: "Doha Insurance Group", fullNameA: "مجموعة الدوحة للتأمين"))
//        data.append(CompaniesUIModel(image: "ic_QIB", symbol: "QIBK", fullNameE: "Qatar Islamic Bank", fullNameA: "بنك الخليج الدولي"))
//        data.append(CompaniesUIModel(image: "ic_QNB", symbol: "QNBK", fullNameE: "QNB", fullNameA: "بنك الوطني"))
//        data.append(CompaniesUIModel(image: "ic_ABQK", symbol: "ABQK", fullNameE: "Ahli Bank", fullNameA: "بنك الأهلي"))
//        data.append(CompaniesUIModel(image: "ic_DOHI", symbol: "DOHI", fullNameE: "Doha Insurance Group", fullNameA: "مجموعة الدوحة للتأمين"))
//        data.append(CompaniesUIModel(image: "ic_QIB", symbol: "QIBK", fullNameE: "Qatar Islamic Bank", fullNameA: "بنك الخليج الدولي"))
//        data.append(CompaniesUIModel(image: "ic_QNB", symbol: "QNBK", fullNameE: "QNB", fullNameA: "بنك الوطني"))
//        data.append(CompaniesUIModel(image: "ic_ABQK", symbol: "ABQK", fullNameE: "Ahli Bank", fullNameA: "بنك الأهلي"))
//        data.append(CompaniesUIModel(image: "ic_DOHI", symbol: "DOHI", fullNameE: "Doha Insurance Group", fullNameA: "مجموعة الدوحة للتأمين"))
//        data.append(CompaniesUIModel(image: "ic_QIB", symbol: "QIBK", fullNameE: "Qatar Islamic Bank", fullNameA: "بنك الخليج الدولي"))
//        
//        listOfCompaniesData = data
    }
}

// MARK: API Calls
extension ListOfCompaniesViewModel {
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

// MARK: Functions
extension ListOfCompaniesViewModel {
    func stockFavorite(symbol: String) {
        GetAllProfilesLookupsByUserCodeAPI(success: true, selectedSymbol: symbol)
    }
}
