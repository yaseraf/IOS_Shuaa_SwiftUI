//
//  FilterContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 31/07/2025.
//

import Foundation
import SwiftUI

struct FilterContentView: View {
    
    
    var filterCategoryItems:Binding<[FilterCategoryModel]>
    var selectedSpecificShareType: Binding<SpecificShareTypes?>
    var selectedSectorType: Binding<SectorTypes?>
    
    @State var isSelectSpecificShareExpanded = false
    @State var isSelectSectorTypeExpanded = false
    @State var isSelectSpecificCategoryExpanded = false
    
    var onCloseTap: () -> Void
    var onConfirm: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            headerView
            
            ScrollView(.vertical, showsIndicators: false){
                filterSectionsView
            }
            
            Spacer()
            
            bottomButtonView
        }
    }
    
    private var headerView: some View {
        HStack {
            Circle()
                .frame(width: 40, height: 40)
                .opacity(0)
            
            Spacer()
            
            Text("filter".localized)
                .font(.apply(.medium, size: 16))
            
            Spacer()
            
            Circle()
                .stroke(lineWidth: 1)
                .fill(Color.colorBorder)
                .frame(width: 40, height: 40)
                .overlay {
                    Image("ic_close")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
                .onTapGesture {
                    onCloseTap()
                }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
    }
    
    private var filterSectionsView: some View {
        VStack {
            HStack {
                Text("select_a_specific_share".localized)
                
                Spacer()
                
                Circle()
                    .fill(Color.colorBGSecondary)
                    .frame(width: 24, height: 24)
                    .overlay {
                        Image("ic_downArrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                    }
            }
            .padding(.horizontal, 24)
            .onTapGesture {
                withAnimation {
                    isSelectSpecificShareExpanded.toggle()
                }
            }
            
            if isSelectSpecificShareExpanded {
                selectSpecificShareView
            }
            
            Divider().padding(.vertical, 16)

            
            HStack {
                Text("select_sector_type".localized)
                
                Spacer()
                
                Circle()
                    .fill(Color.colorBGSecondary)
                    .frame(width: 24, height: 24)
                    .overlay {
                        Image("ic_downArrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                    }
            }
            .padding(.horizontal, 24)
            .onTapGesture {
                withAnimation {
                    isSelectSectorTypeExpanded.toggle()
                }
            }
            
            if isSelectSectorTypeExpanded {
                selectSectorTypeView
            }
            
            Divider().padding(.vertical, 16)

            HStack {
                Text("select_a_specific_sector".localized)
                
                Spacer()
                
                Circle()
                    .fill(Color.colorBGSecondary)
                    .frame(width: 24, height: 24)
                    .overlay {
                        Image("ic_downArrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                    }
            }
            .padding(.horizontal, 24)
            .onTapGesture {
                withAnimation {
                    isSelectSpecificCategoryExpanded.toggle()
                }
            }
            
            if isSelectSpecificCategoryExpanded {
                selectSpecificCategoryView
            }
            
        }
        .frame(maxWidth: .infinity)
    }
    
    private var selectSpecificShareView: some View {
        HStack(spacing: 8) {
            Text("all".localized)
                .foregroundStyle(selectedSpecificShareType.wrappedValue == .all ? Color.colorPrimary : Color.colorTextSecondary)
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 16).fill(selectedSpecificShareType.wrappedValue == .all ? Color.colorBGSelection : Color.clear)
                        RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(selectedSpecificShareType.wrappedValue == .all ? Color.colorPrimary : Color.colorBorder)
                    }
                )
                .onTapGesture {
                    withAnimation {
                        if selectedSpecificShareType.wrappedValue == .all {
                            selectedSpecificShareType.wrappedValue = SpecificShareTypes.none
                        } else {
                            selectedSpecificShareType.wrappedValue = .all
                        }
                    }
                }
            
            Text("islamic".localized)
                .foregroundStyle(selectedSpecificShareType.wrappedValue == .islamic ? Color.colorPrimary : Color.colorTextSecondary)
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 16).fill(selectedSpecificShareType.wrappedValue == .islamic ? Color.colorBGSelection : Color.clear)
                        RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(selectedSpecificShareType.wrappedValue == .islamic ? Color.colorPrimary : Color.colorBorder)
                    }
                )
                .onTapGesture {
                    withAnimation {
                        if selectedSpecificShareType.wrappedValue == .islamic {
                            selectedSpecificShareType.wrappedValue = SpecificShareTypes.none
                        } else {
                            selectedSpecificShareType.wrappedValue = .islamic
                        }
                    }
                }
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity)
    }
    
    private var selectSectorTypeView: some View {
        VStack {
            HStack(spacing: 8) {
                Text("active".localized)
                    .foregroundStyle(selectedSectorType.wrappedValue == .active ? Color.colorPrimary : Color.colorTextSecondary)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 16).fill(selectedSectorType.wrappedValue == .active ? Color.colorBGSelection : Color.clear)
                            RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(selectedSectorType.wrappedValue == .active ? Color.colorPrimary : Color.colorBorder)
                        }
                    )
                    .onTapGesture {
                        withAnimation {
                            if selectedSectorType.wrappedValue == .active {
                                selectedSectorType.wrappedValue = SectorTypes.none
                            } else {
                                selectedSectorType.wrappedValue = .active
                            }
                        }
                    }
                
                Text("up_filter".localized)
                    .foregroundStyle(selectedSectorType.wrappedValue == .up ? Color.colorPrimary : Color.colorTextSecondary)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 16).fill(selectedSectorType.wrappedValue == .up ? Color.colorBGSelection : Color.clear)
                            RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(selectedSectorType.wrappedValue == .up ? Color.colorPrimary : Color.colorBorder)
                        }
                    )
                    .onTapGesture {
                        withAnimation {
                            if selectedSectorType.wrappedValue == .up {
                                selectedSectorType.wrappedValue = SectorTypes.none
                            } else {
                                selectedSectorType.wrappedValue = .up
                            }
                        }
                    }
                
                Text("down_filter".localized)
                    .foregroundStyle(selectedSectorType.wrappedValue == .down ? Color.colorPrimary : Color.colorTextSecondary)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 16).fill(selectedSectorType.wrappedValue == .down ? Color.colorBGSelection : Color.clear)
                            RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(selectedSectorType.wrappedValue == .down ? Color.colorPrimary : Color.colorBorder)
                        }
                    )
                    .onTapGesture {
                        withAnimation {
                            if selectedSectorType.wrappedValue == .down {
                                selectedSectorType.wrappedValue = SectorTypes.none
                            } else {
                                selectedSectorType.wrappedValue = .down
                            }
                        }
                    }
                
                Spacer()
            }
            HStack(spacing: 8) {
                Text("constant".localized)
                    .foregroundStyle(selectedSectorType.wrappedValue == .constant ? Color.colorPrimary : Color.colorTextSecondary)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 16).fill(selectedSectorType.wrappedValue == .constant ? Color.colorBGSelection : Color.clear)
                            RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(selectedSectorType.wrappedValue == .constant ? Color.colorPrimary : Color.colorBorder)
                        }
                    )
                    .onTapGesture {
                        withAnimation {
                            if selectedSectorType.wrappedValue == .constant {
                                selectedSectorType.wrappedValue = SectorTypes.none
                            } else {
                                selectedSectorType.wrappedValue = .constant
                            }
                        }
                    }
                
                Text("favorites".localized)
                    .foregroundStyle(selectedSectorType.wrappedValue == .favorites ? Color.colorPrimary : Color.colorTextSecondary)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 16).fill(selectedSectorType.wrappedValue == .favorites ? Color.colorBGSelection : Color.clear)
                            RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(selectedSectorType.wrappedValue == .favorites ? Color.colorPrimary : Color.colorBorder)
                        }
                    )
                    .onTapGesture {
                        withAnimation {
                            if selectedSectorType.wrappedValue == .favorites {
                                selectedSectorType.wrappedValue = SectorTypes.none
                            } else {
                                selectedSectorType.wrappedValue = .favorites
                            }
                        }
                    }
                
                Spacer()
            }
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity)
    }

    private var selectSpecificCategoryView: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 8) {
                HStack {
                    if filterCategoryItems.wrappedValue.contains(where: {$0.id == 0}) {
                        Image("ic_tick")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                    }
                    Text("all".localized)
                        .foregroundStyle(filterCategoryItems.wrappedValue.contains(where: {$0.id == 0}) ? Color.colorPrimary : Color.colorTextSecondary)
                        
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 16).fill(filterCategoryItems.wrappedValue.contains(where: {$0.id == 0}) ? Color.colorBGSelection : Color.clear)
                        RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(filterCategoryItems.wrappedValue.contains(where: {$0.id == 0}) ? Color.colorPrimary : Color.colorBorder)
                    }
                )
                .onTapGesture {
                    withAnimation {
                        
                        filterCategoryItems.wrappedValue.contains(where: {$0.id == 0}) ? filterCategoryItems.wrappedValue.removeAll(where: {$0.id == 0}) : filterCategoryItems.wrappedValue.append(FilterCategoryModel(name: "all", id: 0))
                    }
                }
                
                HStack {
                    if filterCategoryItems.wrappedValue.contains(where: {$0.id == 1}) {
                        Image("ic_tick")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                    }
                    Text("bank_financial_services".localized)
                        .foregroundStyle(filterCategoryItems.wrappedValue.contains(where: {$0.id == 1}) ? Color.colorPrimary : Color.colorTextSecondary)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 16).fill(filterCategoryItems.wrappedValue.contains(where: {$0.id == 1}) ? Color.colorBGSelection : Color.clear)
                        RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(filterCategoryItems.wrappedValue.contains(where: {$0.id == 1}) ? Color.colorPrimary : Color.colorBorder)
                    }
                )
                .onTapGesture {
                    withAnimation {
                        filterCategoryItems.wrappedValue.contains(where: {$0.id == 1}) ? filterCategoryItems.wrappedValue.removeAll(where: {$0.id == 1}) : filterCategoryItems.wrappedValue.append(FilterCategoryModel(name: "banks", id: 1))
                    }
                }
                
                Spacer()
                
            }
            HStack(spacing: 8) {
                HStack {
                    if filterCategoryItems.wrappedValue.contains(where: {$0.id == 2}) {
                        Image("ic_tick")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                    }
                    Text("insurance".localized)
                        .foregroundStyle(filterCategoryItems.wrappedValue.contains(where: {$0.id == 2}) ? Color.colorPrimary : Color.colorTextSecondary)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 16).fill(filterCategoryItems.wrappedValue.contains(where: {$0.id == 2}) ? Color.colorBGSelection : Color.clear)
                        RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(filterCategoryItems.wrappedValue.contains(where: {$0.id == 2}) ? Color.colorPrimary : Color.colorBorder)
                    }
                )
                .onTapGesture {
                    withAnimation {
                        filterCategoryItems.wrappedValue.contains(where: {$0.id == 2}) ? filterCategoryItems.wrappedValue.removeAll(where: {$0.id == 2}) : filterCategoryItems.wrappedValue.append(FilterCategoryModel(name: "services & insurance", id: 2))
                    }
                }
                
                HStack {
                    if filterCategoryItems.wrappedValue.contains(where: {$0.id == 3}) {
                        Image("ic_tick")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                    }
                    Text("consumer_goods_services".localized)
                        .foregroundStyle(filterCategoryItems.wrappedValue.contains(where: {$0.id == 3}) ? Color.colorPrimary : Color.colorTextSecondary)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 16).fill(filterCategoryItems.wrappedValue.contains(where: {$0.id == 3}) ? Color.colorBGSelection : Color.clear)
                        RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(filterCategoryItems.wrappedValue.contains(where: {$0.id == 3}) ? Color.colorPrimary : Color.colorBorder)
                    }
                )
                .onTapGesture {
                    withAnimation {
                        filterCategoryItems.wrappedValue.contains(where: {$0.id == 3}) ? filterCategoryItems.wrappedValue.removeAll(where: {$0.id == 3}) : filterCategoryItems.wrappedValue.append(FilterCategoryModel(name: "consumerGoodsAndServices", id: 3))
                    }
                }
                
            }
            HStack(spacing: 8) {
                HStack {
                    if filterCategoryItems.wrappedValue.contains(where: {$0.id == 4}) {
                        Image("ic_tick")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                    }
                    Text("industrials".localized)
                        .foregroundStyle(filterCategoryItems.wrappedValue.contains(where: {$0.id == 4}) ? Color.colorPrimary : Color.colorTextSecondary)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 16).fill(filterCategoryItems.wrappedValue.contains(where: {$0.id == 4}) ? Color.colorBGSelection : Color.clear)
                        RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(filterCategoryItems.wrappedValue.contains(where: {$0.id == 4}) ? Color.colorPrimary : Color.colorBorder)
                    }
                )
                .onTapGesture {
                    withAnimation {
                        filterCategoryItems.wrappedValue.contains(where: {$0.id == 4}) ? filterCategoryItems.wrappedValue.removeAll(where: {$0.id == 4}) : filterCategoryItems.wrappedValue.append(FilterCategoryModel(name: "industrial", id: 4))
                    }
                }
                
                HStack {
                    if filterCategoryItems.wrappedValue.contains(where: {$0.id == 5}) {
                        Image("ic_tick")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                    }
                    Text("transportation".localized)
                        .foregroundStyle(filterCategoryItems.wrappedValue.contains(where: {$0.id == 5}) ? Color.colorPrimary : Color.colorTextSecondary)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 16).fill(filterCategoryItems.wrappedValue.contains(where: {$0.id == 5}) ? Color.colorBGSelection : Color.clear)
                        RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(filterCategoryItems.wrappedValue.contains(where: {$0.id == 5}) ? Color.colorPrimary : Color.colorBorder)
                    }
                )
                .onTapGesture {
                    withAnimation {
                        filterCategoryItems.wrappedValue.contains(where: {$0.id == 5}) ? filterCategoryItems.wrappedValue.removeAll(where: {$0.id == 5}) : filterCategoryItems.wrappedValue.append(FilterCategoryModel(name: "transportation", id: 5))
                    }
                }
                
            }
            HStack(spacing: 8) {
                HStack {
                    if filterCategoryItems.wrappedValue.contains(where: {$0.id == 6}) {
                        Image("ic_tick")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                    }
                    Text("real_estate".localized)
                        .foregroundStyle(filterCategoryItems.wrappedValue.contains(where: {$0.id == 6}) ? Color.colorPrimary : Color.colorTextSecondary)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 16).fill(filterCategoryItems.wrappedValue.contains(where: {$0.id == 6}) ? Color.colorBGSelection : Color.clear)
                        RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(filterCategoryItems.wrappedValue.contains(where: {$0.id == 6}) ? Color.colorPrimary : Color.colorBorder)
                    }
                )
                .onTapGesture {
                    withAnimation {
                        filterCategoryItems.wrappedValue.contains(where: {$0.id == 6}) ? filterCategoryItems.wrappedValue.removeAll(where: {$0.id == 6}) : filterCategoryItems.wrappedValue.append(FilterCategoryModel(name: "real estate & construction", id: 6))
                    }
                }
                
                HStack {
                    if filterCategoryItems.wrappedValue.contains(where: {$0.id == 7}) {
                        Image("ic_tick")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                    }
                    Text("telecom".localized)
                        .foregroundStyle(filterCategoryItems.wrappedValue.contains(where: {$0.id == 7}) ? Color.colorPrimary : Color.colorTextSecondary)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 16).fill(filterCategoryItems.wrappedValue.contains(where: {$0.id == 7}) ? Color.colorBGSelection : Color.clear)
                        RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(filterCategoryItems.wrappedValue.contains(where: {$0.id == 7}) ? Color.colorPrimary : Color.colorBorder)
                    }
                )
                .onTapGesture {
                    withAnimation {
                        filterCategoryItems.wrappedValue.contains(where: {$0.id == 7}) ? filterCategoryItems.wrappedValue.removeAll(where: {$0.id == 7}) : filterCategoryItems.wrappedValue.append(FilterCategoryModel(name: "telecom", id: 7))
                    }
                }
                
            }
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity)
    }

    
    private var bottomButtonView: some View {
        Text("confirm".localized)
            .font(.apply(.medium, size: 16))
            .foregroundStyle(.white)
            .frame(minHeight: 48)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary))
            .padding(.horizontal, 24)
            .onTapGesture {
                onConfirm()
            }
    }
}
