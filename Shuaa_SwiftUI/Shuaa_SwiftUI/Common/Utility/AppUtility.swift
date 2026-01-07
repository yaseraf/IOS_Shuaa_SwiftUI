//
//  AppUtility.swift
//  Shuaa
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//
import Foundation
import SwiftUI

class AppUtility {
    static  let shared: AppUtility = .init()
    @Inject private var userDefaultController: UserDefaultController?
    @Inject private var keyChainController: KeyChainController?
    
    func screenTransition(navigationController: BaseNavigationController, animationOptions: UIView.AnimationOptions, duration: TimeInterval, animated: Bool) {
        UIView.transition(
            with: navigationController.view,
            duration: duration,
            options: animationOptions,
            animations: {
                navigationController.setViewControllers([], animated: animated)
            }
        )
    }
    

   var isRTL: Bool {
        return userDefaultController?.isArabicLanguage ?? false
    } 

    var isDarkTheme: Bool {
        get {
            return switch AppUtility.shared.currentAppTheme {
                case .light:
                    false
                case .dark:
                    true
                case .system:
                    UserDefaultController().isDarkMode ?? true
            }
        }
    }

    var currentAppTheme: ThemeType {
        return userDefaultController?.appTheme ?? .system
    }

    var englishLocaleIdentifier: String{
        return "en_US"
    }

    var arabicLocaleIdentifier: String{
        return "ar_SA"
    }

    var languageLocale: Locale{
        return Locale(identifier: isRTL ? arabicLocaleIdentifier : englishLocaleIdentifier)
    }

    var englishLocale: Locale{
        return Locale(identifier: englishLocaleIdentifier)
    }
    
    
    var arabicLocale: Locale{
        return Locale(identifier: arabicLocaleIdentifier)
    }
    
        
    func updateAppLanguage(language: LanguageType) {
        let defaults = UserDefaults.standard
        defaults.set([language.rawValue], forKey: AppConstants.appleLanguages)
        userDefaultController?.appLanguage = language.rawValue
        userDefaultController?.currentDeviceLanguage = language.rawValue
        
        let semantic: UISemanticContentAttribute = AppUtility.shared.isRTL  ?  .forceRightToLeft : .forceLeftToRight
       
        UIView.appearance().semanticContentAttribute = semantic
        UIPageControl.appearance().semanticContentAttribute = semantic
        UIControl.appearance().semanticContentAttribute = semantic
        UINavigationBar.appearance().semanticContentAttribute = semantic
        UITextField.appearance().semanticContentAttribute = semantic
        UILabel.appearance().semanticContentAttribute = semantic
        UITextView.appearance().semanticContentAttribute = semantic
        UIImageView.appearance().semanticContentAttribute = semantic
        UINavigationController().view.semanticContentAttribute = semantic
        UITableView.appearance().semanticContentAttribute = semantic
        UINavigationController().navigationBar.semanticContentAttribute = semantic
        UITabBarController().view.semanticContentAttribute  = semantic
        UISwitch.appearance().semanticContentAttribute = semantic
        UISegmentedControl.appearance().semanticContentAttribute = semantic
        UIButton.appearance().semanticContentAttribute = semantic
        UIStackView.appearance().semanticContentAttribute = semantic
    }

    func applyDeviceLanguageIfNeeded() {
        if let appLanguage = Locale.preferredLanguages.first {

            if userDefaultController?.currentDeviceLanguage !=  appLanguage{
                if appLanguage.contains(LanguageType.arabic.rawValue) {
                    userDefaultController?.currentDeviceLanguage = LanguageType.arabic.rawValue
                } else {
                    userDefaultController?.currentDeviceLanguage = LanguageType.english.rawValue
                }
            }
        }

        let currentDeviceLanguage = userDefaultController?.currentDeviceLanguage ?? LanguageType.english.rawValue
        let newLanguage = LanguageType(rawValue: currentDeviceLanguage) ?? LanguageType.english

        updateAppLanguage(language: newLanguage)
        
    }
    
    func formatThousandSeparator3Decimal(number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 3 // Remove decimal places
        formatter.locale = Locale(identifier: englishLocaleIdentifier)

        // Format the double and add a thousand separator
        if let formattedString = formatter.string(from: NSNumber(value: number)) {
            return formattedString // Output: "1,234,568"
        } else {
            return "-"
        }
    }
    
    func formatThousandSeparator2Decimal(number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2 // Remove decimal places
        formatter.locale = Locale(identifier: englishLocaleIdentifier)

        // Format the double and add a thousand separator
        if let formattedString = formatter.string(from: NSNumber(value: number)) {
            return formattedString // Output: "1,234,568"
        } else {
            return "-"
        }
    }
    
    func convertDateToString(_ dateString: String, inputFormat: String, outputFormat: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        inputFormatter.locale = Locale(identifier: englishLocaleIdentifier)

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        outputFormatter.locale = Locale(identifier: englishLocaleIdentifier)

        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return dateString
        }
    }
    
    func convertStringToDate(_ input: String, with format: String) -> Date? {
        let formatter = DateFormatter()
            formatter.dateFormat = format
            formatter.locale = Locale(identifier: englishLocaleIdentifier)
            return formatter.date(from: input)
    }
}

extension AppUtility {
    public static var  bundleIdentifier: String {
        get{
            return Bundle.main.bundleIdentifier ?? "com.shuaa.shuaa"
        }
    }

    public static var  deviceUUID: String {
        get{
            return UIDevice.current.identifierForVendor?.uuidString ?? ""
        }
    }

    public static var  deviceModel: String {
        get{
            return [UIDevice.current.model, UIDevice.current.systemVersion].compactMap({$0}).joined(separator: ",")
        }
    }

    public static var  deviceName: String {
        get{
            return [UIDevice.current.model, UIDevice.current.systemVersion].compactMap({$0}).joined(separator: ",")
        }
    }
    
    public static var  hasTopNotch: Bool {
        get{
            return SceneDelegate.getAppCoordinator()?.getWindow().safeAreaInsets.top ?? 0 > 20
        }
    }

    public static var  bottomNotch: CGFloat {
        get{
            return SceneDelegate.getAppCoordinator()?.getWindow().safeAreaInsets.bottom ?? 0
        }
    }

}

