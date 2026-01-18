//
//  ClientPortalScene.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 27/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct ClientPortalScene: BaseSceneType {
    @ObservedObject var viewModel: ClientPortalViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(
            contentView: {
                BaseContentView(
                    withScroll:false,
                    paddingValue: 0,
                    content: {
                        ClientPortalContentView(

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
