//
//  DailyReportModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/10/2025.
//

import Foundation

struct DailyReportRequestModel: Codable {
    
}

struct DailyReportResponseModel: Codable {
    
}

struct DailyReportsUIModel{
    var title:String
    var subTitle:String
    var since: Date
    var type:DailyReportsTabs
    var link: String
    var reportsType : String
}

enum DailyReportsTabs{

    case highlights
    case egyptDaily
    case technical

    var text:String{
        switch self {
        case .highlights:
            "highlights".localized
        case .egyptDaily:
            "egypt_daily".localized

        case .technical:
            "technical".localized
        }
    }

    var icon:String{
        switch self {
        case .highlights:
            "ic_historyCell"
        case .egyptDaily:
            "icDailyEgyptCell"
        case .technical:
            "ic_technicalAnalysis"
        }

    }

}

extension DailyReportsUIModel {
    static func mapToUIModel(_ model: String , _ responseType : String  )->Self {
        var  title = ""
        var since : Date = Date()
        var namePart = ""
        var datePart = ""
        var link = model
        

        // Step 1: Create a DateFormatter for the input format
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd-MM-yyyy" // Define the input format

        // Step 2: Convert the input string to a Date object
       
            
      
        if let range = link.range(of: "MobileServices") {
            link  = String(link[range.lowerBound...])
           
        }
        print ("link \(link)")
        if responseType == "h"{
            title = model.components(separatedBy: "\\").last ?? model
            var  parts = title.components(separatedBy: " ")
            namePart = ""
            datePart = ""
            if parts.count > 1 {
                namePart = parts[0]  // The part before the space (e.g., "ImportantData")
                datePart = parts[1]
                datePart = datePart.components(separatedBy: ".").first ?? datePart
                
            }
            if let date = inputFormatter.date(from: datePart) {
          since = date   }
            return  DailyReportsUIModel(title: namePart, subTitle: "CI Capital", since: since , type: .highlights, link: link, reportsType: "h")}
        else if responseType == "f"{
            title = model.components(separatedBy: "\\").last ?? model
            var  parts = title.components(separatedBy: " ")
            namePart = ""
            datePart = ""
            if parts.count > 1 {
               // namePart = parts[0]
                datePart = parts[parts.count - 1 ]
                namePart = title.replacingOccurrences(of: datePart, with: "")
                datePart = datePart.components(separatedBy: ".").first ?? datePart
                
            }
            if let date = inputFormatter.date(from: datePart) {
          since = date   }
          //  "C:\\inetpub\\wwwroot1\\MobileServices\\Uploads\\f\\اخبار مصر من شركه سي اي كبيتال 18-02-2019.pdf"
            return  DailyReportsUIModel(title: namePart, subTitle: "CI Capital", since: since , type: .egyptDaily, link: link, reportsType: "f")
        }
        else if responseType == "t"{
            
       //     "C:\\inetpub\\wwwroot1\\MobileServices\\Uploads\\t\\CICapital-Technical Analysis - MENA-4-1-2018.pdf"
            title = model.components(separatedBy: "\\").last ?? model
            var  parts = title.components(separatedBy: " ")
            namePart = ""
            datePart = ""
            if parts.count > 1 {
                namePart = parts[0] + " " + parts[1]
                datePart = parts[parts.count - 1 ]
                datePart = datePart.components(separatedBy: ".").first ?? datePart
                
            }
            var parts2 = datePart.components(separatedBy: "-")
            var subTitle = ""
            if parts2.count == 4 {
            subTitle = parts2[0]
                datePart = parts2[1] + "-" + parts2[2] + "-" + parts2[3]
            }
           
            return  DailyReportsUIModel(title: namePart, subTitle: subTitle, since: since , type: .technical, link: link, reportsType: "t")
        }
        return  DailyReportsUIModel(title: namePart, subTitle: "CI Capital", since: since , type: .highlights, link: link, reportsType: "h")
    }

}
