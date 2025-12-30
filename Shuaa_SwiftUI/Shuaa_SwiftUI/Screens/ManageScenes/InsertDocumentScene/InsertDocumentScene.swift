//
//  InsertDocumentScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/10/2025.
//

import Foundation
import SwiftUI
import Combine

struct InsertDocumentScene: BaseSceneType {
    @ObservedObject var viewModel: InsertDocumentViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                InsertDocumentContentView(selectedIdCardSectionType: $viewModel.selectedIdCardSectionType, frontImageName: $viewModel.frontImageName, backImageName: $viewModel.backImageName, passportImageName: $viewModel.passportImageName, idNumber: $viewModel.idNumber, passportNumber: $viewModel.passportNumber, expiryDate: $viewModel.expiryDate, passportExpiryDate: $viewModel.passportExpiryDate, onSelectFileTap: {
                    viewModel.uploadAttachmentAction()
                }, onSaveTap: {
                    viewModel.onSaveTap()
                }, onImageUpload: { image in
                    Task {
                        await viewModel.onImageUpload(image: image)
                    }
                }, onBackTap: {
                    viewModel.onBackTap()
                }, onFrontImageChange: { name in
                    viewModel.onFrontImageNameChange()
                }, onBackImageChange: { name in
                    viewModel.onBackImageNameChange()
                }, onPassportImageChange: { name in
                    viewModel.onPassportImageNameChange()
                })
                .onAppear {

                }
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            UpdateIdValidityAPI()
            UploadClientDocumentAPI()
        }
    }
    private func UpdateIdValidityAPI() {
        viewModel.$updateIdValidity3APIResult.receive(on: DispatchQueue.main).sink { result  in
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
    
    private func UploadClientDocumentAPI() {
        viewModel.$uploadClientDocumentsAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
