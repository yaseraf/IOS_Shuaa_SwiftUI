//
//  AccountSummaryScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct AccountSummaryScene: BaseSceneType {
    @ObservedObject var viewModel: AccountSummaryViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                AccountSummaryContentView(currentDate: $viewModel.currentDate, selectedDateFrom: $viewModel.selectedDateFrom, selectedDateTo: $viewModel.selectedDateTo, userData: $viewModel.userData, accountSummaryData: $viewModel.accountSummaryData, statementsData: $viewModel.statementsData, groupedStatementsData: $viewModel.groupedStatementsData, onPortfolioTap: {
                    viewModel.openSelectPortfolioScene()
                }, onCalendarTap: {
                    viewModel.openRangeCaledarScene()
                }, onBackTap: {
                    viewModel.onBackTap()
                }, onAccountSummaryTypeSelect: { type in
                    if type == .statementUponRequest {
                        viewModel.callGetStatementOfAccountAPI(success: true)
                    } else if type == .collected {
                        viewModel.callGetGroupedStatementOfAccountAPI(success: true)
                    }
                })
                .onAppear {
//                    viewModel.getUserData()
//                    viewModel.getAccountSummaryData()
                }
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            statementAPI()
            groupedStatementAPI()
        }
    }
    
    private func statementAPI() {
        viewModel.$getStatementOfAccountAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
    
    private func groupedStatementAPI() {
        viewModel.$getGroupedStatementOfAccountAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
