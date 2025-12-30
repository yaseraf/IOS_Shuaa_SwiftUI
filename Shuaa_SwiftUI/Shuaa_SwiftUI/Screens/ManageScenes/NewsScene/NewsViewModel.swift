//
//  NewsDetailsViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 30/07/2025.
//

import Foundation

class NewsViewModel: ObservableObject {
    private var coordinator: ManageCoordinatorProtocol
    
    @Published var newsData: [GetAllMarketNewsBySymbolUIModel]?
    
    init(coordinator: ManageCoordinatorProtocol, newsData: [GetAllMarketNewsBySymbolUIModel]) {
        self.coordinator = coordinator
        self.newsData = newsData
    }
    
    func onBackTap() {
        coordinator.popViewController()
    }
    
    func openNewsDetailsScene(selectedNews: GetAllMarketNewsBySymbolUIModel) {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getHomeCoordinator().openNewsDetailsScene(selectedNews: selectedNews)
    }
    
    func getNewsData() {
//        var data: [NewsUIModel] = []
//        data.append(NewsUIModel(dateEn: "29Dec2024", dateAr: "٢٩ ديسمبر ٢٠٢٤", descEn: "QNB Group Board of Directors Meeting to Decide on the Bank’s Financial Results.", descAr: "اجتماع مجلس إدارة مجموعة QNB للبت في النتائج المالية للبنك لعام 2024 ", detailsEn: "Please note that the Board of Directors of QNB Group will hold a meeting on 13 January 2025 to decide on the Bank’s 2024 financial results and proposed dividends. Please note that in accordance with the instructions of the Qatar Financial Markets Authority, QNB will stop buying back its shares during the lock-up period starting from 30 December 2024 and continuing until 13 January 2025 due to the expected publication of QNB Group’s annual financial results. The Bank will resume buying back shares effective 14 January 2025.", detailsAr: "يرجى العلم أن مجلس إدارة مجموعة QNB سيعقد اجتماعاً في 13 يناير 2025 للبت في النتائج المالية للبنك لعام 2024 وتوزيعات الأرباح المقترحة.كما يرجى العلم أنه بموجب تعليمات هيئة قطر للأسواق المالية سيتوقف QNB عن إعادة شراء أسهمه خلال فترة الإغلاق التي تبدأ من 30 ديسمبر 2024 وتستمر حتى 13 يناير 2025 بسبب النشر المرتقب للنتائج المالية السنوية لمجموعة QNB. وسيستأنف البنك عملية إعادة شراء الأسهم اعتباراً من 14 يناير 2025."))
//        data.append(NewsUIModel(dateEn: "28Dec2024", dateAr: "٢٨ نوفمبر ٢٠٢٤", descEn: "QNB Group Board of Directors Meeting.", descAr: "فتح باب الترشيح لعضوية مجلس إدارة 2025", detailsEn: "Please note that the Board of Directors of QNB Group will hold a meeting on 13 January 2025 to decide on the Bank’s 2024 financial results and proposed dividends. Please note that in accordance with the instructions of the Qatar Financial Markets Authority, QNB will stop buying back its shares during the lock-up period starting from 30 December 2024 and continuing until 13 January 2025 due to the expected publication of QNB Group’s annual financial results. The Bank will resume buying back shares effective 14 January 2025.", detailsAr: "يرجى العلم أن مجلس إدارة مجموعة QNB سيعقد اجتماعاً في 13 يناير 2025 للبت في النتائج المالية للبنك لعام 2024 وتوزيعات الأرباح المقترحة.كما يرجى العلم أنه بموجب تعليمات هيئة قطر للأسواق المالية سيتوقف QNB عن إعادة شراء أسهمه خلال فترة الإغلاق التي تبدأ من 30 ديسمبر 2024 وتستمر حتى 13 يناير 2025 بسبب النشر المرتقب للنتائج المالية السنوية لمجموعة QNB. وسيستأنف البنك عملية إعادة شراء الأسهم اعتباراً من 14 يناير 2025."))
//       
//        newsData = data
    }

}
