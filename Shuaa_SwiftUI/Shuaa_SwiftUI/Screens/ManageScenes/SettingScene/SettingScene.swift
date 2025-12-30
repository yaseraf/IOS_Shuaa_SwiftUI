//
//  SettingScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 28/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct SettingScene: BaseSceneType {
    @ObservedObject var viewModel: SettingViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                SettingContentView(themeToggle: $viewModel.themeToggle, companiesLogoToggle: $viewModel.companiesLogoToggle, classificationBySectorToggle: $viewModel.classificationBySectorToggle, biometricLoginToggle: $viewModel.biometricLoginToggle, pinLoginToggle: $viewModel.pinLoginToggle, onBackTap: {
                    viewModel.onBackTap()
                }, onLanguageSelected: {
                    viewModel.onLanguageTap()
                }, onDarkThemeToggle: { toggle in
                    viewModel.onDarkThemeToggle(isOn: toggle)
                }, onCompaniesLogoToggle: { toggle in
                    viewModel.onCompaniesLogoToggle(isOn: toggle)
                }, onClassificationBySectorToggle: { toggle in
                    viewModel.onClassificationBySector(isOn: toggle)
                }, onBiometricLoginToggle: { toggle in
                    viewModel.onBiometricLoginToggle(isOn: toggle)
                }, onPinLoginToggle: { toggle in
                    viewModel.onPinLoginToggle(isOn: toggle)
                })
            })
        })
    }
}
