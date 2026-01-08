//
//  ManageScene.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 27/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct SettingsScene: BaseSceneType {
    @ObservedObject var viewModel: SettingsViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(
            contentView: {
                BaseContentView(
                    withScroll:false,
                    paddingValue: 0,
                    content: {
                        SettingsContentView(
                            fontSize: $viewModel.fontSize,
                            selectedLanguage: $viewModel.selectedLanguage,
                            selectedTheme: $viewModel.selectedTheme,
                            onLanguageChange: { newLanguage in
                                viewModel.onLanguageChange(newLanguage: newLanguage)
                            }, onAppThemeChange: { theme in
                                viewModel.onAppThemeChange(type: theme)
                            }, onFontSizeIncrease: {
                                viewModel.onFontSizeIncrease()
                            }, onFontSizeDecrease: {
                                viewModel.onFontSizeDecrease()
                            }
                        )
                        .onAppear {
                            
                        }
                    }
                )
            },
            showLoading: .constant(viewTypeAction.showLoading)
        )
        .onViewDidLoad {
            
        }
    }
    
    // MARK: Binding

}
