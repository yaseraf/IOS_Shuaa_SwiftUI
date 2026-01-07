//
//  PickerItemsScene.swift
//  Shuaa


import SwiftUI
import Combine

struct PickerItemsScene: View {
    @ObservedObject private var viewModel: PickerItemsViewModel
    @State private var anyCancellable = Set<AnyCancellable>()
    @State private var viewTypeAction:BaseSceneViewType  = DefaultBaseSceneViewType()
    init(viewModel: PickerItemsViewModel){
        self.viewModel = viewModel
    }

    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false,paddingValue:0,paddingVerticalValue: 0, content: {

                PickerItemsContentView(allowSearch: $viewModel.allowSearch, listSearch: $viewModel.listSearchResult, selectType:$viewModel.selectType,title: $viewModel.title,maxCount:$viewModel.maxCount, list: $viewModel.list,selectModel: $viewModel.selectItem,selectModels: $viewModel.selectItems,onTextChange: { text in
                    viewModel.searchName(name: text)
                }) { model in
                   viewModel.selectItem = model
                    viewModel.selectItem(model)
//                    viewModel.dissmiss()
                } onCloseTap: {
                    viewModel.dissmiss()
                }
            })


        }, showLoading: .constant(viewTypeAction.showLoading))
        .onDisappear {
            viewModel.dismissActions()
        }
        .background(Color.clear)
        .ignoresSafeArea()

        
    }

}
