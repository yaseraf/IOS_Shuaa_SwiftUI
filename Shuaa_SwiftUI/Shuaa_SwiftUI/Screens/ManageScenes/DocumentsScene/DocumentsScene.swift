//
//  DocumentsScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 17/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct DocumentsScene: BaseSceneType {
    @ObservedObject var viewModel: DocumentsViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                DocumentsContentView(documentsData: $viewModel.documentsData, expiredDocumentsData: $viewModel.expiredDocumentsData, onDocumentTap: { idNumber in
                    viewModel.openInsertDocumentsScene(idNumber: idNumber)
                }, onBackTap: {
                    viewModel.onBackTap()
                })
            })
            .onAppear {
                viewModel.callgetRequiredUserDocumentsAPI()
                viewModel.callGetExpiredAttachmentAPI()
            }
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            GetRequiredUserDocumentsAPI()
        }
    }
    private func GetRequiredUserDocumentsAPI() {
        viewModel.$getRequiredUserDocumentsAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(let data):
                debugPrint("")
            case .none:
                break
            }

        }.store(in: &anyCancellable)
    }
}
