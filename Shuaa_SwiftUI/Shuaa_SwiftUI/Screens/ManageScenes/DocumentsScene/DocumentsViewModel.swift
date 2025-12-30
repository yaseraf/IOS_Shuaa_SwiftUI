//
//  DocumentsViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 17/08/2025.
//

import Foundation

class DocumentsViewModel: ObservableObject {
    private let coordinator: ManageCoordinatorProtocol
    private let useCase: HomeUseCaseProtocol
    
    @Published var documentsData: GetRequiredUserDocumentsUIModel?
    @Published var expiredDocumentsData: GetExpiredAttachmentUIModel?
    @Published var getRequiredUserDocumentsAPIResult:APIResultType<GetRequiredUserDocumentsUIModel>?
    @Published var getExpiredAttachmentAPIResult:APIResultType<GetExpiredAttachmentUIModel>?
    
    init(coordinator: ManageCoordinatorProtocol, useCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
}

// MARK: Routing
extension DocumentsViewModel {
    func onBackTap() {
        coordinator.popViewController()
    }
    func openInsertDocumentsScene(idNumber: String) {
        coordinator.openInsertDocumentsScene(idNumber: idNumber)
    }
}

// MARK: API Calls
extension DocumentsViewModel {
    func callgetRequiredUserDocumentsAPI() {
        
        let requestModel = GetRequiredUserDocumentsRequestModel()
        
        getRequiredUserDocumentsAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetRequiredUserDocuments(requestModel: requestModel) {[weak self] result in
                self?.getRequiredUserDocumentsAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    
                    self?.documentsData = success
                    
                    self?.getRequiredUserDocumentsAPIResult = .onSuccess(response: success)
                    
                case .failure(let failure):
                    
                    self?.getRequiredUserDocumentsAPIResult = .onFailure(error: failure)
                    
                }
            }
        }
    }
    
    func callGetExpiredAttachmentAPI() {
        
        let requestModel = GetExpiredAttachmentRequestModel()
        
        getExpiredAttachmentAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetExpiredAttachment(requestModel: requestModel) {[weak self] result in
                self?.getRequiredUserDocumentsAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    
                    self?.expiredDocumentsData = success

                    self?.getExpiredAttachmentAPIResult = .onSuccess(response: success)
                    
                case .failure(let failure):
                    
                    self?.getExpiredAttachmentAPIResult = .onFailure(error: failure)
                    
                }
            }
        }
    }
}
