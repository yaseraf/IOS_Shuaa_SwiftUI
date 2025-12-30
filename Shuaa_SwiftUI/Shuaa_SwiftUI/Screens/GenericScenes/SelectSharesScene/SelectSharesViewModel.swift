//
//  SelectSharesViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 03/08/2025.
//

import Foundation

class SelectSharesViewModel: ObservableObject {
    private var coordinator: GenericCoordinatorProtocol
    private let lookupsUseCase: LookupsUseCaseProtocol
    
    private let delegate: SelectSharesDelegate
    
    @Published var sharesDataTelecom: [SharesUIModel]?
    @Published var sharesDataInsurance: [SharesUIModel]?
    @Published var selectedShare: GetCompaniesLookupsUIModel?
    @Published var companiesLookups:[GetCompaniesLookupsUIModel]? = []

    @Published var getCompaniesLookupsAPIResult:APIResultType<[GetCompaniesLookupsUIModel]>?

    init(coordinator: GenericCoordinatorProtocol, useCase: LookupsUseCaseProtocol, delegate: SelectSharesDelegate) {
        self.coordinator = coordinator
        self.lookupsUseCase = useCase
        self.delegate = delegate
    }
}

// MARK: Mock Data
extension SelectSharesViewModel {
    func getSharesData() {
//        var testData: [SharesUIModel] = []
//        
//        
//        testData.append(SharesUIModel(stockId: 1, image: "ic_QNBK", name: "QNBK", fullNameE: "Doha Bank", fullNameA: "بنك الدوحة"))
//        
//        testData.append(SharesUIModel(stockId: 2, image: "ic_ABQK", name: "ABQK", fullNameE: "Ahli Bank", fullNameA: "البنك الأهلي"))
//        
//        testData.append(SharesUIModel(stockId: 3, image: "ic_DOHI", name: "DOHI", fullNameE: "Doha Insurance Group", fullNameA: "مجموعة الدوحة للتأمين"))
//        
//        sharesDataTelecom = testData
//        
//        testData.removeAll()
//        
//        testData.append(SharesUIModel(stockId: 4, image: "ic_QIB", name: "QIBK", fullNameE: "Qatar Islamic Bank", fullNameA: "المصرف"))
//        
//        testData.append(SharesUIModel(stockId: 5, image: "ic_DOHI", name: "DOHI", fullNameE: "Doha Insurance Group", fullNameA: "مجموعة الدوحة للتأمين"))
//
//        testData.append(SharesUIModel(stockId: 6, image: "ic_ABQK", name: "ABQK", fullNameE: "Ahli Bank", fullNameA: "البنك الأهلي"))
//        
//        testData.append(SharesUIModel(stockId: 7, image: "ic_DOHI", name: "DOHI", fullNameE: "Doha Insurance Group", fullNameA: "مجموعة الدوحة للتأمين"))
//        
//        testData.append(SharesUIModel(stockId: 8, image: "ic_QNBK", name: "QNBK", fullNameE: "Doha Bank", fullNameA: "بنك الدوحة"))
//        
//        sharesDataInsurance = testData

    }

}

// MARK: Routing
extension SelectSharesViewModel {
    func onDismiss() {
        coordinator.dismiss()
    }
}

// MARK: API Calls
extension SelectSharesViewModel {
    func GetCompaniesLookupsAPI(success:Bool) {
        
        UserDefaultController().searchResultSymbol = ""

        let requestModel = GetCompaniesLookupsRequestModel()
        getCompaniesLookupsAPIResult = .onLoading(show: true)
        
        Task.init {
            await lookupsUseCase.GetCompaniesLookups(requestModel: requestModel) {[weak self] result in
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

// MARK: Functions
extension SelectSharesViewModel {
    func onConfirm(share: GetCompaniesLookupsUIModel?) {
        delegate.onSelect(share: share)
        coordinator.dismiss()
    }

}
