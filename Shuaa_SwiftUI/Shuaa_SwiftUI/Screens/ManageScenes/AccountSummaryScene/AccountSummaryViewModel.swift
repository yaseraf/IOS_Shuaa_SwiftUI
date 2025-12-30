//
//  AccountSummaryViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/08/2025.
//

import Foundation
class AccountSummaryViewModel: ObservableObject {
    private let coordinator: ManageCoordinatorProtocol
    private let menuUseCase: MenuUseCaseProtocol
    
    @Published var currentDate: Date = Date()
    @Published var selectedDateFrom: Date?
    @Published var selectedDateTo: Date?
    @Published var userData: GetUserAccountsUIModel?
    @Published var statementsData:[GetStatementOfAccountUIModel]?
    @Published var groupedStatementsData:[GetStatementOfAccountUIModel]?

    @Published var accountSummaryData: [AccountSummaryUIModel]?
    
    @Published var getStatementOfAccountAPIResult:APIResultType<[GetStatementOfAccountUIModel]>?
    @Published var getGroupedStatementOfAccountAPIResult:APIResultType<[GetStatementOfAccountUIModel]>?
     
    init(coordinator: ManageCoordinatorProtocol, menuUseCase: MenuUseCaseProtocol) {
        self.coordinator = coordinator
        self.menuUseCase = menuUseCase
        
        userData = UserDefaultController().selectedUserAccount

        accountSummaryData = []
    }
}

// MARK: Mock Data
extension AccountSummaryViewModel {
    func getAccountSummaryData() {
        var data: [AccountSummaryUIModel] = []
        
        data.append(AccountSummaryUIModel(date: "2025-02-12", shares: "CIB", sellBuy: "sell".localized, volume: 4500, avgPrice: 17.29, value: 500000, balance: 500000, requests: ""))
        data.append(AccountSummaryUIModel(date: "2025-02-12", shares: "CIB", sellBuy: "sell".localized, volume: 4500, avgPrice: 17.29, value: 500000, balance: 500000, requests: ""))
        data.append(AccountSummaryUIModel(date: "2025-02-12", shares: "CIB", sellBuy: "buy".localized, volume: 4500, avgPrice: 17.29, value: 500000, balance: 500000, requests: ""))
        data.append(AccountSummaryUIModel(date: "2025-02-12", shares: "CIB", sellBuy: "sell".localized, volume: 4500, avgPrice: 17.29, value: 500000, balance: 500000, requests: ""))
        data.append(AccountSummaryUIModel(date: "2025-02-12", shares: "CIB", sellBuy: "buy".localized, volume: 4500, avgPrice: 17.29, value: 500000, balance: 500000, requests: ""))
        
        accountSummaryData = data
    }
    
    func getUserData() {
//        userData = UserUIModel(userID: "398235", nameEn: "AlSaed Younes", nameAr: "السيد يونس", purchasingPower: 41914134, purchasingValue: 41914134, commission: 41914134, totalValue: 41914134)
        
    }
}

// MARK: Routing
extension AccountSummaryViewModel {
    func openSelectPortfolioScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openSelectPortfolioScene(delegate: self, selectedUser: userData)
    }
    
    func onBackTap() {
        coordinator.popViewController()
    }
    
    func openRangeCaledarScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openRangeCalendarScene(delegate: self, title: "filter_by_date".localized, isMultiSelect: true)
    }
}

// MARK: API Calls
extension AccountSummaryViewModel {
    func callGetStatementOfAccountAPI(success: Bool) {
        
        if UserDefaultController().dateFrom == "" || UserDefaultController().dateFrom == nil {
            UserDefaultController().dateFrom = getYesterdayDateString()
        }
        
        if UserDefaultController().dateTo == "" || UserDefaultController().dateTo == nil {
            UserDefaultController().dateTo = getCurrentDateString()
        }
                
        let requestModel = GetStatementOfAccountRequestModel()
        getStatementOfAccountAPIResult = .onLoading(show: true)
        
        Task.init {
            await menuUseCase.getStatementOfAccount(requestModel: requestModel) {[weak self] result in
                self?.getStatementOfAccountAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    debugPrint("Success to get statement account")

                        self?.getStatementOfAccountAPIResult = .onSuccess(response: success)
                        self?.statementsData = success

                case .failure(let failure):
                        debugPrint("Failed to get statement of account")
                        self?.getStatementOfAccountAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
    
    func callGetGroupedStatementOfAccountAPI(success: Bool) {
        
        if UserDefaultController().dateFrom == "" || UserDefaultController().dateFrom == nil {
            UserDefaultController().dateFrom = getYesterdayDateString()
        }
        
        if UserDefaultController().dateTo == "" || UserDefaultController().dateTo == nil {
            UserDefaultController().dateTo = getCurrentDateString()
        }
                
        let requestModel = GetStatementOfAccountRequestModel()
        getGroupedStatementOfAccountAPIResult = .onLoading(show: true)
        
        Task.init {
            await menuUseCase.getGroupedStatementOfAccount(requestModel: requestModel) {[weak self] result in
                self?.getGroupedStatementOfAccountAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    debugPrint("Success to get grouped statement account")

                        self?.getGroupedStatementOfAccountAPIResult = .onSuccess(response: success)
                        self?.groupedStatementsData = success

                case .failure(let failure):
                        debugPrint("Failed to get grouped statement of account")
                        self?.getGroupedStatementOfAccountAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }

}

// MARK: Functions
extension AccountSummaryViewModel {
    func getTomorrowDateString() -> String{
        // Get the current date
        let today = Date()

        // Use Calendar to add one day to the current date
        if let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today) {
            // Create a DateFormatter to format the date
            let formatter = DateFormatter()
            formatter.dateFormat = "ddMMyyyyHHmmss"
            
            // Return the formatted string for tomorrow's date
            return formatter.string(from: tomorrow)
        }
        return "Error"
    }
    
    func getCurrentDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyyHHmmss"
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        return dateString
    }
    
    func getYesterdayDateString() -> String {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
//            if let firstDayOfCurrentYear = calendar.date(from: DateComponents(year: currentYear, month: 1, day: 1)),
        if let oneMonthBefore = calendar.date(byAdding: .month, value: -1, to: Date()) {
            let formatter = DateFormatter()
            formatter.locale = .current
            formatter.dateFormat = "ddMMyyyyHHmmss"
            return formatter.string(from: oneMonthBefore)
        }
    
        return ""
    }

}

// MARK: Delegates
extension AccountSummaryViewModel: SelectPortfolioDelegate {
    func onSelect(user: GetUserAccountsUIModel?) {
        userData = user
    }
}

extension AccountSummaryViewModel: RangeCalendarDelegate {
    func onSelect(selectedDateFrom: Date?, selectedDateTo: Date?) {
        self.selectedDateFrom = selectedDateFrom
        self.selectedDateTo = selectedDateTo
        
        UserDefaultController().dateFrom = selectedDateFrom?.toString(dateFormat: .ddMMyyyyHHmmss)
        UserDefaultController().dateTo = selectedDateTo?.toString(dateFormat: .ddMMyyyyHHmmss)
    }
}
