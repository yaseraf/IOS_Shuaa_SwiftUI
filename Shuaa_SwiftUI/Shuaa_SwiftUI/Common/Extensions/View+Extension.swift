//
//  View+Extension.swift
//  Shuaa
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI
extension View {
    
    var withThemeEnvironment: some View {
        Group {
            if UserDefaultController().appTheme == .system {
                self
                    .modifier(ColorSchemeModifier())
                    .environment(\.locale, AppUtility.shared.languageLocale)
                    .environment(\.layoutDirection, AppUtility.shared.isRTL ? .rightToLeft : .leftToRight)
            } else {
                self
                    .environment(\.locale, AppUtility.shared.languageLocale)
                    .environment(\.layoutDirection, AppUtility.shared.isRTL ? .rightToLeft : .leftToRight)
                    .environment(\.colorScheme, AppUtility.shared.isDarkTheme ? .dark : .light)
            }
        }
    }
    


    var fileName:String{
        return String("\(self)".split(separator: "(").first ?? "").trimmingCharacters(in: .whitespaces)
    }


  
}

// Still in progress
struct ColorSchemeModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    @State private var lastColorScheme: ColorScheme?
    @State var colorSchemeCountDetection = 0

    func body(content: Content) -> some View {
        content
            .onAppear {
                lastColorScheme = colorScheme
                UserDefaultController().isDarkMode = colorScheme == .dark ? true : false
                UserDefaultController().lastColorScheme = colorScheme == .light ? "light" : "dark"
                SceneDelegate.getAppCoordinator()?.updateWindowBackground()
                
                NotificationCenter.default.addObserver(
                    forName: UIApplication.willEnterForegroundNotification,
                    object: nil,
                    queue: .main
                ) { _ in
                    UserDefaultController().canRestartScreen = true
                }
                
                NotificationCenter.default.addObserver(
                    forName: UIApplication.didEnterBackgroundNotification,
                    object: nil,
                    queue: .main
                ) { _ in
                    UserDefaultController().canRestartScreen = false
                }
            }
            .onChange(of: colorScheme) { newScheme in
                if UserDefaultController().canRestartScreen == true {
                    UserDefaultController().canRestartScreen = false

                    if (newScheme == .dark ? "dark" : "light") != UserDefaultController().lastColorScheme {
                        UserDefaultController().isDarkMode = newScheme == .dark ? true : false
                        UserDefaultController().lastColorScheme = newScheme == .dark ? "dark" : "light"
                        SceneDelegate.getAppCoordinator()?.updateWindowBackground()
                        SceneDelegate.getAppCoordinator()?.restartForTheme()
                    }
                }
            }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

extension View {
    func fadeOutSides(fadeLength:CGFloat=50) -> some View {
        return mask(
            HStack(spacing: 0) {

                // Left gradient
                LinearGradient(gradient: Gradient(
                    colors: [Color.black.opacity(0), Color.black]),
                    startPoint: .leading, endPoint: .trailing
                )
                .frame(height: fadeLength)

                // Middle
                Rectangle().fill(Color.black)

                // Right gradient
                LinearGradient(gradient: Gradient(
                    colors: [Color.black, Color.black.opacity(0)]),
                    startPoint: .leading, endPoint: .trailing
                )
                .frame(width: fadeLength)
            }
        )
    }
    func fadeRightSide(fadeLength:CGFloat=50) -> some View {
        return mask(
            HStack(spacing: 0) {

              

                // Middle
                Rectangle().fill(Color.black)

                // Right gradient
                LinearGradient(gradient: Gradient(
                    colors: [Color.black, Color.black.opacity(0)]),
                    startPoint: .leading, endPoint: .trailing
                )
                .frame(width: fadeLength)
            }
        )
    }

    func fadeBottomSide(fadeLength:CGFloat=50) -> some View {
        return mask(
            VStack(spacing: 0) {

                        // Top part
                        Rectangle().fill(Color.black)

                        // Bottom gradient
                        LinearGradient(
                            gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: fadeLength)
                    }
        )
    }

}
