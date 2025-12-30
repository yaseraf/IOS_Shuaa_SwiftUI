//
//  CashInScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 31/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct CashOutScene: BaseSceneType {
    @ObservedObject var viewModel: CashOutViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                CashOutContentView(selectedTypeOfTransaction: $viewModel.selectedTypeOfTransaction, userData: $viewModel.userData, banksList: $viewModel.banksList, selectedBank: $viewModel.selectedBank, transactionAmount: $viewModel.transactionAmount, availableBalance: $viewModel.availableBalance, iban: $viewModel.iban, onBackTap: {
                    viewModel.onBackTap()
                }, onSendTap: {
                    if Double(viewModel.transactionAmount) ?? 0 > 0 && Double(viewModel.transactionAmount) ?? 0 <= $viewModel.availableBalance.wrappedValue ?? 0 {
                        viewModel.callSubmitCrmRequestRamz2API(success: true)
                    } else {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "please_enter_a_valid_amount".localized)
                    }
                }, onBankAccountTap: {
                    viewModel.openSelectBankScene()
                }, onPortfolioTap: {
                    viewModel.openSelectPortfolioScene()
                })
            })
            .onAppear {
//                viewModel.getUserData()
                viewModel.callGetAccountTransferInfoAPI(success: true)
                viewModel.callGetBankIBANAPI(success: true)

            }
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            GetAccountTransferAPI()
            GetBankIBANAPI()
            SubmitCrmRequestRamz2API()
        }
    }
    
    private func GetAccountTransferAPI() {
        viewModel.$GetAccountTransferInfoAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
    
    private func GetBankIBANAPI() {
        viewModel.$GetBankIBANAPIResult.receive(on: DispatchQueue.main).sink { result  in
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

    private func SubmitCrmRequestRamz2API() {
        viewModel.$SubmitCrmRequestRamzAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
