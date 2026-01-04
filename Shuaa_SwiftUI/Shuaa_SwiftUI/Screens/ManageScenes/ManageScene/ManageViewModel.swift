//
//  ManageViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 27/07/2025.
//

import Foundation
import WebKit

class ManageViewModel: ObservableObject {
    
    private let coordinator: HomeCoordinatorProtocol
    
    @Published var newsData: [GetAllMarketNewsBySymbolUIModel]?

    init(coordinator: HomeCoordinatorProtocol) {
        self.coordinator = coordinator
        
        getNewsData()
    }
    
    func openSettingScene() {
        coordinator.openSettingScene()
    }
    
    func openContactUsScene() {
//        coordinator.openContactUsScene()
    }
    
    func openAppRatingScene() {
//        coordinator.openAppRatingScene()
    }
    
    func openLogoutConfirmationScene() {
//        coordinator.openLogoutConfirmationScene()
    }
    
    func openTransactionsScene() {
//        coordinator.openTransactionScene()
    }
    
    func openMarketSummaryScene() {
//        coordinator.openMarketSummaryScene()
    }
    
    func openMarketReportsScene() {
//        coordinator.openMarketReportsScene()
    }
    
    func openTradingIndexScene() {
//        coordinator.openTradeIndexScene()
    }
    
    func openSectorsIndexScene() {
//        coordinator.openIndustrialSectorScene()
    }
    
    func openMarketDealsScene() {
//        coordinator.openMarketDealsScene()
    }
    
    func openMarketNewsScene() {
//        coordinator.openNewsScene(newsData: newsData ?? [])
    }
    
    func openListOfCompaniesScene() {
//        coordinator.openListOfCompaniesScene()
    }
    
    func openNotificationsScene() {
//        coordinator.openNotificationsScene()
    }
    
    func openChangePasswordScene() {
//        coordinator.openManageChangePasswordScene()
    }
    
    func openAccountReportsScene() {
//        coordinator.openAccountReportsScene()
    }
    
    func openBalanceDetailsScene() {
//        coordinator.openBalanceDetailsScene()
    }
    
    func openPersonalInformationScene() {
        
    }
    
    func openUploadDocumentTap() {
//        coordinator.openDocumentsScene()
    }
    
    
    func logout() {
        // Stop SignalR connection
        Connection_Hub.shared.connection?.stop()
        
        // Clear hub references
        Connection_Hub.shared.connection?.hubs.removeAll()
        
        // Remove from global connection list
        if let connection = Connection_Hub.shared.connection,
           let index = SwiftR.connections.firstIndex(where: { $0 === connection }) {
            SwiftR.connections.remove(at: index)
        }
        
        // Release WKWebView
        Connection_Hub.shared.connection?.wkWebView.removeFromSuperview()
        Connection_Hub.shared.connection?.wkWebView = nil
        
        // Optional: clear cookies & cache
        WKWebsiteDataStore.default().removeData(
            ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(),
            modifiedSince: Date.distantPast
        ) {
            print("✅ SignalR completely disconnected and cleaned up")
        }
        
        // Reset singleton reference
        Connection_Hub.shared.connection = nil
        
        SceneDelegate.getAppCoordinator()?.logout()
    }

    
    func getNewsData() {
//        var data: [NewsUIModel] = []
//        data.append(NewsUIModel(dateEn: "29Dec2024", dateAr: "٢٩ ديسمبر ٢٠٢٤", descEn: "QNB Group Board of Directors Meeting to Decide on the Bank’s Financial Results.", descAr: "اجتماع مجلس إدارة مجموعة QNB للبت في النتائج المالية للبنك لعام 2024 ", detailsEn: "Please note that the Board of Directors of QNB Group will hold a meeting on 13 January 2025 to decide on the Bank’s 2024 financial results and proposed dividends. Please note that in accordance with the instructions of the Qatar Financial Markets Authority, QNB will stop buying back its shares during the lock-up period starting from 30 December 2024 and continuing until 13 January 2025 due to the expected publication of QNB Group’s annual financial results. The Bank will resume buying back shares effective 14 January 2025.", detailsAr: "يرجى العلم أن مجلس إدارة مجموعة QNB سيعقد اجتماعاً في 13 يناير 2025 للبت في النتائج المالية للبنك لعام 2024 وتوزيعات الأرباح المقترحة.كما يرجى العلم أنه بموجب تعليمات هيئة قطر للأسواق المالية سيتوقف QNB عن إعادة شراء أسهمه خلال فترة الإغلاق التي تبدأ من 30 ديسمبر 2024 وتستمر حتى 13 يناير 2025 بسبب النشر المرتقب للنتائج المالية السنوية لمجموعة QNB. وسيستأنف البنك عملية إعادة شراء الأسهم اعتباراً من 14 يناير 2025."))
//        data.append(NewsUIModel(dateEn: "28Dec2024", dateAr: "٢٨ نوفمبر ٢٠٢٤", descEn: "QNB Group Board of Directors Meeting.", descAr: "فتح باب الترشيح لعضوية مجلس إدارة 2025", detailsEn: "Please note that the Board of Directors of QNB Group will hold a meeting on 13 January 2025 to decide on the Bank’s 2024 financial results and proposed dividends. Please note that in accordance with the instructions of the Qatar Financial Markets Authority, QNB will stop buying back its shares during the lock-up period starting from 30 December 2024 and continuing until 13 January 2025 due to the expected publication of QNB Group’s annual financial results. The Bank will resume buying back shares effective 14 January 2025.", detailsAr: "يرجى العلم أن مجلس إدارة مجموعة QNB سيعقد اجتماعاً في 13 يناير 2025 للبت في النتائج المالية للبنك لعام 2024 وتوزيعات الأرباح المقترحة.كما يرجى العلم أنه بموجب تعليمات هيئة قطر للأسواق المالية سيتوقف QNB عن إعادة شراء أسهمه خلال فترة الإغلاق التي تبدأ من 30 ديسمبر 2024 وتستمر حتى 13 يناير 2025 بسبب النشر المرتقب للنتائج المالية السنوية لمجموعة QNB. وسيستأنف البنك عملية إعادة شراء الأسهم اعتباراً من 14 يناير 2025."))
//       
//        newsData = data
    }

}
