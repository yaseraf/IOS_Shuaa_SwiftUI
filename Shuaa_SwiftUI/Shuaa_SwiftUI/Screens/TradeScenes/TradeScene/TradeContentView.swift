//
//  OrderListContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 11/08/2025.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct TradeContentView: View {
    enum Field {
        case appear
        case price
        case shares
    }
    
    @FocusState private var focusedField: Field?
    @State var isStockExpanded:Bool = false

    var userData:Binding<GetUserAccountsUIModel?>
    var riskManagementData:Binding<GetRiskManagementUIModel?>
    var selectedStock:Binding<GetCompaniesLookupsUIModel>
    var marketWatchData:Binding<GetAllMarketWatchBySymbolUIModel?>
    var selectedTypeOfTrade:Binding<TypeOfTrade>
    var appearAmount:Binding<String>
    var price:Binding<String>
    var sharesAmount:Binding<String>
    var flagMessage:Binding<String>
    @Binding var tillCancelToggle:Bool
    @Binding var marketPriceToggle:Bool
    
    @State var mktString: String = "mkt".localized

    var onTypeOfTradeChange:(TypeOfTrade)->Void
    var onPortfolioTap:()->Void
    var onQuantityCalculatorTap:()->Void
    var onAppearChange:()->Void
    var onPriceChange:()->Void
    var onSharesChange:()->Void
    var onTillCancelToggle:()->Void
    var onMarketPriceToggle:()->Void
    var onSendTap:()->Void
    var onSearchTap:()->Void
    var onBackTap:()->Void
    
    var body: some View {
        ZStack {
            
            VStack {
                Rectangle()
                   .fill(
                       LinearGradient(
                        colors: [
                            selectedTypeOfTrade.wrappedValue == .sell ?
                            Color.colorStockUpliftHeaderGradient
                            : selectedTypeOfTrade.wrappedValue == .buy ?
                            Color.colorStockWithdrawalHeaderGradient
                            : Color.clear ,
                            selectedTypeOfTrade.wrappedValue == .sell ?
                            Color.colorStockUpliftHeaderGradient
                                .opacity(0)
                            : selectedTypeOfTrade.wrappedValue == .buy ?
                            Color.colorStockWithdrawalHeaderGradient
                                .opacity(0)
                            : Color.clear
                        ],
                           startPoint: .top,
                           endPoint: .bottom
                       )
                   )
                   .frame(maxWidth: .infinity)
                   .frame(maxHeight: 150)
                   .ignoresSafeArea()
                
                Spacer()
            }

            VStack {
               
                headerView
                
                ScrollView(.vertical, showsIndicators: false) {
                    accountView

                    typeOfTradeView

                    selectedStockView
                    
                    contentView
                    
                    optionsView
                }
                
                Spacer()
                
                bottomButtonView
                
//                HomeBottomBarView(selectedItem: .orders)
//                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            Circle()
                .fill(Color.colorBGSecondary)
                .frame(width: 40, height: 40)
                .overlay {
                    Image(AppUtility.shared.isRTL ? "ic_rightArrow" : "ic_leftArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                .onTapGesture {
                    onBackTap()
                }
            
            Spacer()
            
            Text("trade".localized)
                .font(.apply(.medium, size: 16))

            Spacer()
            
            Circle()
                .fill(Color.colorBGSecondary)
                .frame(width: 40, height: 40)
                .overlay {
                    Image("ic_searchHeader")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                .onTapGesture {
                    onSearchTap()
                }
        }
        .padding(.horizontal, 24)
    }

    private var accountView: some View {
        HStack {
            Circle()
                .frame(width: 32, height: 32)
                .foregroundStyle(Color.colorBG)
                .overlay {
                    Image("ic_profile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
            
            Text("\(AppUtility.shared.isRTL ? userData.wrappedValue?.ClientNameA ?? "" : userData.wrappedValue?.ClientNameE ?? "") - \(userData.wrappedValue?.NIN ?? "")")
                .font(.apply(.medium, size: 14))
                .padding(.horizontal, 8)
            
            Spacer()
            
            ZStack {
                Circle()
                    .fill(Color.colorBG)
                    .frame(width: 24, height: 24)
                Circle()
                    .stroke(lineWidth: 1).fill(Color.colorBorder)
                    .frame(width: 24, height: 24)
                    .overlay {
                        Image("ic_downArrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                    }
            }
                
        }
        .padding(.horizontal, 16)
        .frame(minHeight: 52)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 8).fill(Color.colorBGHeader))
//        .padding(.horizontal, 20)
        .onTapGesture {
            onPortfolioTap()
        }
    }
    
    private var typeOfTradeView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("select_the_type_of_trade".localized)
                .font(.apply(.semiBold, size: 12))
            
            HStack {
                Button(action: {
                    onTypeOfTradeChange(.buy)
                }, label: {
                    Text("buy".localized)
                        .font(.apply(.regular, size: 14))
                        .foregroundStyle(selectedTypeOfTrade.wrappedValue == .buy ? Color.white : Color.colorTextSecondary)
                        .frame(minHeight: 36)
                        .frame(maxWidth: .infinity)
                        .background(
                            ZStack{
                                RoundedRectangle(cornerRadius: 12).fill(selectedTypeOfTrade.wrappedValue == .buy ? Color.colorBuy : Color.colorBG)
                                RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).fill(Color.colorBorder)
                            }
                        )
                })

                Button(action: {
                    onTypeOfTradeChange(.sell)
                }, label: {
                    Text("sell".localized)
                        .font(.apply(.regular, size: 14))
                        .foregroundStyle(selectedTypeOfTrade.wrappedValue == .sell ? Color.white : Color.colorTextSecondary)
                        .frame(minHeight: 36)
                        .frame(maxWidth: .infinity)
                        .background(
                            ZStack{
                                RoundedRectangle(cornerRadius: 12).fill(selectedTypeOfTrade.wrappedValue == .sell ? Color.colorSell : Color.colorBG)
                                RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).fill(Color.colorBorder)
                            }
                        )
                })
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 8)

    }
    
    private var selectedStockView: some View {
        HStack {
            if UserDefaultController().isCompaniesLogoEnabled == true {
                WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(selectedStock.wrappedValue.symbol).jpg")) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 45, maxHeight: 45)
                            .padding(.horizontal, 4)
                            .foregroundStyle(.gray)
                    case .failure:
                        Image("ic_selectStock")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 45, maxHeight: 45)
                            .padding(.horizontal, 4)
                            .foregroundStyle(.gray)
                    case .empty:
                        Image("ic_selectStock")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 45, maxHeight: 45)
                            .foregroundStyle(.gray)
                    @unknown default:
                        Image("ic_selectStock")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 45, maxHeight: 45)
                            .foregroundStyle(.gray)
                    }
                }
            }
            Text("\(AppUtility.shared.isRTL ? selectedStock.wrappedValue.shortNameA : selectedStock.wrappedValue.shortNameE) - \(selectedStock.wrappedValue.symbol)")
                .font(.apply(.medium, size: 14))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .padding(.horizontal, 8)
            
            Spacer()
            
            ZStack { 
                Circle()
                    .fill(Color.colorBG)
                    .frame(width: 24, height: 24)
                Circle()
                    .stroke(lineWidth: 1).fill(Color.colorBorder)
                    .frame(width: 24, height: 24)
                    .overlay {
                        Image("ic_downArrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                    }
            }
                
        }
        .padding(.horizontal, 16)
        .frame(minHeight: 57)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 8).fill(Color.colorBGTable))
        .onTapGesture {
            withAnimation {
                isStockExpanded.toggle()
            }
        }
    }
    
    private var contentView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0){
                VStack(spacing: 4) {
                    Text("offer_price".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(marketWatchData.wrappedValue?.offerPrice ?? "") ?? 0))")
                        .font(.apply(.semiBold, size: 14))
                        .padding(.vertical, 4)
                        .padding(.horizontal, 17)
                        .frame(minWidth: 70)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.colorOffer))
                }
                Spacer()
                VStack(spacing: 4) {
                    Text("market_price".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(marketWatchData.wrappedValue?.lastTradePrice ?? "") ?? 0))")
                        .font(.apply(.semiBold, size: 14))
                        .padding(.vertical, 4)
                        .padding(.horizontal, 17)
                        .frame(minWidth: 70)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.colorBGPositive))
                }
                Spacer()
                VStack(spacing: 4) {
                    Text("bid_price".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(marketWatchData.wrappedValue?.bidPrice ?? "") ?? 0))")
                        .font(.apply(.semiBold, size: 14))
                        .padding(.vertical, 4)
                        .padding(.horizontal, 17)
                        .frame(minWidth: 70)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.colorBid))
                }
                Spacer()
                VStack(spacing: 4) {
                    Text("change_perc".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(marketWatchData.wrappedValue?.netChangePerc ?? "") ?? 0))")
                        .font(.apply(.semiBold, size: 14))
                        .padding(.vertical, 4)
                        .padding(.horizontal, 17)
                        .foregroundStyle(Double(marketWatchData.wrappedValue?.netChangePerc ?? "") ?? 0 > 0 ? Color.colorPositiveSecondary : Color.colorNegativeSecondary)
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 8)
            if isStockExpanded {
                stockExpandedContent()
            }
            
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    Text("purchasing_power".localized)
                        .font(.apply(.regular, size: 12))
                    Text(AppUtility.shared.formatThousandSeparator(number: Double(riskManagementData.wrappedValue?.buyPower ?? "0") ?? 0))
                        .font(.apply(.regular, size: 12))
                }
                .frame(maxWidth: .infinity)
                .background(Color.colorBid)
                VStack(spacing: 0) {
                    Text("financial_trades".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(marketWatchData.wrappedValue?.executed ?? "") ?? 0))")
                        .font(.apply(.regular, size: 12))
                }
                .frame(maxWidth: .infinity)
                .background(Color.colorBGNegative)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
    }
    
    private func stockExpandedContent() -> some View {
        return VStack {
            HStack {
                VStack {
                    Text("trades_value".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)

                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(marketWatchData.wrappedValue?.totalValue ?? "") ?? 0))")
                        .font(.apply(.bold, size: 12))
                }
                Spacer()
                VStack {
                    Text("trades_volume".localized)
                        .font(.apply(.regular, size: 14))
                        .foregroundStyle(Color.colorTextSecondary)

                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(marketWatchData.wrappedValue?.totalVolume ?? "") ?? 0))")
                        .font(.apply(.bold, size: 12))
                }
                Spacer()
                VStack {
                    Text("accepted_trades".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)

                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(marketWatchData.wrappedValue?.executed ?? "") ?? 0))")
                        .font(.apply(.bold, size: 12))
                }
            }
            .frame(maxWidth: .infinity)
            
            Divider()
            
            HStack {
                VStack {
                    Text("open_price".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)

                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(marketWatchData.wrappedValue?.openPrice ?? "") ?? 0))")
                        .font(.apply(.bold, size: 12))
                }
                Spacer()
                VStack {
                    Text("close_price".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)

                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(marketWatchData.wrappedValue?.closePrice ?? "") ?? 0))")
                        .font(.apply(.bold, size: 12))
                }
                Spacer()
                VStack {
                    Text("down".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)

                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(marketWatchData.wrappedValue?.lowPrice ?? "") ?? 0))")
                        .font(.apply(.bold, size: 12))
                }
                Spacer()
                VStack {
                    Text("up".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)

                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(marketWatchData.wrappedValue?.highPrice ?? "") ?? 0))")
                        .font(.apply(.bold, size: 12))
                }
            }
            .frame(maxWidth: .infinity)
            
            Divider()
            
            HStack {
                // Trades today
                VStack(alignment: .leading, spacing: 0) {
                    Text("trades_today".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)

                    GeometryReader { geometry in
                        let high = Double(marketWatchData.wrappedValue?.highPrice ?? "") ?? 0
                        let low = Double(marketWatchData.wrappedValue?.lowPrice ?? "") ?? 0
                        let total = high + low
                        let highRatio = total > 0 ? high / total : 0
                        let lowRatio = total > 0 ? low / total : 0

                        if total == 0 {
                            Color.colorPositiveSecondary
                                .frame(width: geometry.size.width, height: 4)
                                .clipShape(RoundedRectangle(cornerRadius: 80))
                        } else {
                            HStack(spacing: 0) {
                                Color.colorNegativeSecondary
                                    .frame(width: geometry.size.width * highRatio, height: 4)
                                    .animation(.easeInOut(duration: 0.4), value: highRatio)

                                Color.colorPositiveSecondary
                                    .frame(width: geometry.size.width * lowRatio, height: 4)
                                    .animation(.easeInOut(duration: 0.4), value: lowRatio)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 80))
                        }
                    }
                    .frame(height: 4)

                    HStack {
                        Text("\(AppUtility.shared.formatThousandSeparator(number: Double(marketWatchData.wrappedValue?.highPrice ?? "") ?? 0))")
                            .font(.apply(.bold, size: 12))
                        Spacer()
                        Text("\(AppUtility.shared.formatThousandSeparator(number: Double(marketWatchData.wrappedValue?.lowPrice ?? "") ?? 0))")
                            .font(.apply(.bold, size: 12))
                    }
                }
                .padding(.horizontal, 8)
                
                // 52 Weeks
                VStack(alignment: .leading, spacing: 0) {
                    Text("trades_52Weeks".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)

                    GeometryReader { geometry in
                        let high = Double(marketWatchData.wrappedValue?.wk52High ?? "") ?? 0
                        let low = Double(marketWatchData.wrappedValue?.wk52Low ?? "") ?? 0
                        let total = high + low
                        let highRatio = total > 0 ? high / total : 0
                        let lowRatio = total > 0 ? low / total : 0

                        if total == 0 {
                            Color.colorPositiveSecondary
                                .frame(width: geometry.size.width, height: 4)
                                .clipShape(RoundedRectangle(cornerRadius: 80))
                        } else {
                            HStack(spacing: 0) {
                                Color.colorNegativeSecondary
                                    .frame(width: geometry.size.width * highRatio, height: 4)
                                    .animation(.easeInOut(duration: 0.4), value: highRatio)

                                Color.colorPositiveSecondary
                                    .frame(width: geometry.size.width * lowRatio, height: 4)
                                    .animation(.easeInOut(duration: 0.4), value: lowRatio)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 80))
                        }
                    }
                    .frame(height: 4)

                    HStack {
                        Text("\(AppUtility.shared.formatThousandSeparator(number: Double(marketWatchData.wrappedValue?.wk52High ?? "") ?? 0))")
                            .font(.apply(.bold, size: 12))
                        Spacer()
                        Text("\(AppUtility.shared.formatThousandSeparator(number: Double(marketWatchData.wrappedValue?.wk52Low ?? "") ?? 0))")
                            .font(.apply(.bold, size: 12))
                    }
                }
                .padding(.horizontal, 8)
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 8)
    }

    private var optionsView: some View {
        VStack(spacing: 10) {
            HStack {
                HStack(spacing: 0) {
                    Text("till_cancel".localized)
                        .font(.apply(.semiBold, size: 14))
                    Spacer()
                    Toggle("", isOn: $tillCancelToggle)
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle(tint: Color.colorPrimary))
                        .onChange(of: tillCancelToggle) { newValue in
                            onTillCancelToggle()
                        }
                }
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                
                HStack(spacing: 0) {
                    Text("appear".localized)
                        .font(.apply(.semiBold, size: 14))
                    Spacer()
                    TextField("0".localized, text: appearAmount)
                        .font(.apply(.regular, size: 14))
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .appear)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Done") {
                                    focusedField = nil
                                }
                            }
                        }
                        .onChange(of: appearAmount.wrappedValue) { newValue in
                            debugPrint("Submitted appear")
                            onAppearChange()
                        }
                }
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
            }
            
            HStack {
                HStack(spacing: 0) {
                    Text("market_price".localized)
                        .font(.apply(.semiBold, size: 14))
                    Spacer()
                    Toggle("", isOn: $marketPriceToggle)
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle(tint: Color.colorPrimary))
                        .onChange(of: marketPriceToggle) { newValue in
                            onMarketPriceToggle()
                        }
                }
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                
                HStack(spacing: 0) {
                    Text("quantity_calculator".localized)
                        .font(.apply(.semiBold, size: 14))
                        .lineLimit(1)
                    Spacer()
                    Image("ic_calculator")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 8).fill(Color.colorPrimary.opacity(0.04))
                        RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorPrimary)
                    }
                )
                .onTapGesture {
                    if UserDefaultController().isMarketPrice ?? false || Double(price.wrappedValue) ?? 0 > 0 {
                        onQuantityCalculatorTap()
                    } else {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,"quantity_calc_fail".localized)
                    }
                }
            }
            
            HStack(alignment: .top) {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("price".localized)
                            .font(.apply(.semiBold, size: 14))
                        Spacer()
                        TextField("0".localized, text: marketPriceToggle ? $mktString : price)
                            .font(.apply(.semiBold, size: 14))
                            .keyboardType(.decimalPad)
                            .focused($focusedField, equals: .price)
                            .multilineTextAlignment(.trailing)
                            .onChange(of: price.wrappedValue) { newValue in
                                debugPrint("Submitted price")
                                onPriceChange()
                            }
                            .disabled(marketPriceToggle)
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                                        
                    HStack {
                        HStack {
                           Image("ic_chgUp")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                            Text(AppUtility.shared.formatThousandSeparator(number: Double(marketWatchData.wrappedValue?.maxPrice ?? "") ?? 0))
                                .font(.apply(.semiBold, size: 14))
                        }
                        Spacer()
                        HStack {
                           Image("ic_chgDown")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                            Text(AppUtility.shared.formatThousandSeparator(number: Double(marketWatchData.wrappedValue?.minPrice ?? "") ?? 0))
                                .font(.apply(.semiBold, size: 14))
                        }
                    }
                    .padding(.horizontal, 16.5)
                }
                
                HStack(spacing: 0) {
                    Text("shares".localized)
                        .font(.apply(.semiBold, size: 14))
                    Spacer()
                    TextField("0".localized, text: sharesAmount)
                        .font(.apply(.semiBold, size: 14))
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .shares)
                        .multilineTextAlignment(.trailing)
                        .onChange(of: sharesAmount.wrappedValue) { newValue in
                            debugPrint("Submitted shares")
                            onSharesChange()
                        }
                }
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
            }
            
            Text(flagMessage.wrappedValue.isEmpty == true ? (AppUtility.shared.isRTL ? riskManagementData.wrappedValue?.flagMsgA : riskManagementData.wrappedValue?.flagMsgE) ?? "" : flagMessage.wrappedValue)
                .font(.apply(.regular, size: 14))
                .foregroundStyle(Color.colorNegativeSecondary)

            
            Divider()
                        
        }
        .padding(.horizontal, 15)
        .frame(maxWidth: .infinity)
    }
    
    private var bottomButtonView: some View {
        VStack {
            HStack {
                Text("request_value".localized)
                    .font(.apply(.regular, size: 14))
                
                Spacer()
                
                Text("\(riskManagementData.wrappedValue?.orderValue ?? "") \("qar".localized)")
                    .font(.apply(.regular, size: 14))
            }
            .padding(.horizontal, 25)

            Button(action: {
                onSendTap()
            }, label: {
                Text("trade".localized)
                    .font(.apply(.medium, size: 16))
                    .foregroundStyle(.white)
                    .frame(minHeight: 48)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 16).fill(isTradeAllowed ? Color.colorPrimary : Color.colorPrimary.opacity(0.5)))
                    .padding(.horizontal, 24)
            })
            .disabled(!isTradeAllowed)
        }
    }
    
    private var isTradeAllowed : Bool {
        selectedStock.wrappedValue.symbol.isEmpty == false &&
        UserDefaultController().selectedUserAccount?.ClientID?.isEmpty == false &&
        sharesAmount.wrappedValue.isEmpty == false &&
        (price.wrappedValue.isEmpty && !marketPriceToggle) == false &&
        flagMessage.wrappedValue.isEmpty == true && (riskManagementData.wrappedValue?.flag?.isEmpty == true || riskManagementData.wrappedValue?.flag == "0")
    }
    
}
