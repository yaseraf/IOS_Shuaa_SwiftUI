//
//  HomeContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 23/07/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeContentView: View {
    
    var marketsData:Binding<[MarketsUIModel]?>
    var stocksData:Binding<[StocksUIModel]?>
    
    @State var symbolSearch = ""
    @State var isMenuOpen = false
    @State var showMarketDetails = true
    
    var onAccountInformationTap:()->Void
    var onMyDocumentsTap:()->Void
    var onMarketsInsightTap:()->Void
    var onMyAlertsTap:()->Void
    var onAccountStatements:()->Void
    var onCashDeposit:()->Void
    var onEquityTransferTap:()->Void
    var onTransfersTap:()->Void
    var onClientPortalTap:()->Void
    var onIPOTap:()->Void
    var onSettingsTap:()->Void
        
    var body: some View {
        ZStack {
            VStack {
                
                SharedHeaderView(symbolSearch: symbolSearch, isMenuOpen: isMenuOpen, withBackButton: false, onMenuTap: {
                    isMenuOpen.toggle()
                })
                
                marketsView
                
                ScrollView {
                    chartView
                    
                    stocksView
                }
                
                Spacer()
                
                HomeBottomBarView(selectedItem: .home)
                    .frame(maxWidth: .infinity)
            }
                        
            // Side Menu
            SharedSideMenuView(isMenuOpen: $isMenuOpen, onAccountInformationTap: onAccountInformationTap, onMyDocumentsTap: onMyDocumentsTap, onMarketsInsightTap: onMarketsInsightTap, onMyAlertsTap: onMyAlertsTap, onAccountStatements: onAccountStatements, onCashDeposit: onCashDeposit, onEquityTransferTap: onEquityTransferTap, onTransfersTap: onTransfersTap, onClientPortalTap: onClientPortalTap, onIPOTap: onIPOTap, onSettingsTap: onSettingsTap)
        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button(action: {
//                    withAnimation(.easeInOut(duration: 0.3)) {
//                        isMenuOpen.toggle()
//                    }
//                }) {
//                    Image(systemName: "line.3.horizontal")
//                }
//            }
//        }
    }
        
    private var marketsView: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .top) {
                        Text("\(marketsData.wrappedValue?.first?.marketName ?? "")")
                            .font(.apply(.bold, size: 12))
                            .foregroundStyle(Color.colorTextPrimary)
                            .offset(y: -4)
                        
                        Color.colorTextPrimary
                            .frame(width: 1)
                            .frame(maxHeight: 14)

                        Text("\(marketsData.wrappedValue?.first?.marketStatus ?? "")")
                            .font(.apply(.regular, size: 8))
                            .foregroundStyle(Color.colorGreen)

                    }
                    
                    Text("\(marketsData.wrappedValue?.first?.marketDate ?? "")")
                        .font(.apply(.regular, size: 8))
                        .foregroundStyle(Color.colorTextPrimary)
                        .offset(y: -8)

                }
                
                Spacer()
                
                HStack(alignment: .center) {
                    Text("\(marketsData.wrappedValue?.first?.lastTradePrice ?? "")")
                        .font(.apply(.bold, size: 16))
                        .foregroundStyle(Color.colorTextPrimary)

                    VStack(alignment: .leading, spacing: 0) {
                        Text("\(marketsData.wrappedValue?.first?.netChange ?? "")")
                            .font(.apply(.regular, size: 8))
                            .foregroundStyle(Color.colorGreen)

                        Text("\(marketsData.wrappedValue?.first?.netChangePerc ?? "")")
                            .font(.apply(.regular, size: 8))
                            .foregroundStyle(Color.colorGreen)
                            .offset(y: -4)

                    }
                }
                
                Button {
                    withAnimation {
                        showMarketDetails.toggle()
                    }
                } label: {
                    Image("ic_upArrow")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 18, height: 18)
                        .rotationEffect(Angle(degrees: showMarketDetails ? 0 : 180))
                        .foregroundStyle(Color.colorTextPrimary)

                }

            }
            
            if showMarketDetails {
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("turnover".localized)
                                .font(.apply(.regular, size: 12))
                                .foregroundStyle(Color.colorTextSecondary)

                            Text("\(marketsData.wrappedValue?.first?.turnover ?? "")")
                                .font(.apply(.semiBold, size: 14))
                                .foregroundStyle(Color.colorTextPrimary)

                        }
                        
                        HStack {
                            Text("volume".localized)
                                .font(.apply(.regular, size: 12))
                                .foregroundStyle(Color.colorTextSecondary)

                            Text("\(marketsData.wrappedValue?.first?.volume ?? "")")
                                .font(.apply(.semiBold, size: 14))
                                .foregroundStyle(Color.colorTextPrimary)

                        }

                        HStack {
                            Text("trades".localized)
                                .font(.apply(.regular, size: 12))
                                .foregroundStyle(Color.colorTextSecondary)

                            Text("\(marketsData.wrappedValue?.first?.trades ?? "")")
                                .font(.apply(.semiBold, size: 14))
                                .foregroundStyle(Color.colorTextPrimary)

                        }
                    }
                    
                    Color.colorTextPrimary
                        .frame(width: 1)
                        .frame(maxHeight: 92)
                        .padding(.horizontal, 24)

                    VStack(alignment: .leading, spacing: -4) {
                        HStack(alignment: .center) {
                            Text("symbols_traded".localized)
                                .font(.apply(.regular, size: 10))
                                .foregroundStyle(Color.colorTextPrimary)

                            Text("\(marketsData.wrappedValue?.first?.symbolsTraded ?? "")")
                                .font(.apply(.semiBold, size: 14))
                                .foregroundStyle(Color.colorTextPrimary)

                        }
                        
                        HStack {
                            Text("\(marketsData.wrappedValue?.first?.tradesUp ?? "")")
                                .font(.apply(.medium, size: 14))
                                .foregroundStyle(Color.colorTextPrimary)

                            Image("ic_imgUp")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 18, height: 18)
                                .foregroundStyle(Color.colorTextPrimary)
                            
                            RoundedRectangle(cornerRadius: 2)
                                .frame(height: 8)
                                .frame(maxWidth: 65)
                                .foregroundStyle(Color.colorGreen)
                        }

                        HStack {
                            Text("\(marketsData.wrappedValue?.first?.tradesEqual ?? "")")
                                .font(.apply(.medium, size: 14))
                                .foregroundStyle(Color.colorTextPrimary)

                            Text("=")
                                .foregroundStyle(Color.colorTextPrimary)
                        }
                        
                        HStack {
                            Text("\(marketsData.wrappedValue?.first?.tradesDown ?? "")")
                                .font(.apply(.medium, size: 14))
                                .foregroundStyle(Color.colorTextPrimary)

                            Image("ic_imgDown")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 18, height: 18)
                                .foregroundStyle(Color.colorTextPrimary)

                            RoundedRectangle(cornerRadius: 2)
                                .frame(height: 8)
                                .frame(maxWidth: 65)
                                .foregroundStyle(Color.colorRed)
                        }
                    }

                }
                .offset(y: -8)

            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .padding(.horizontal, 16)

        .background(RoundedRectangle(cornerRadius: 12).fill(Color.colorBackgroundSecondary))
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }
    
    private var chartView: some View {
        VStack {
            VStack {
                
            }
            .frame(height: 280)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
            .padding(.vertical, 8)
            .padding(.horizontal, 16)

        }
        .frame(height: 300)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.colorBackgroundSecondary))
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }
    
    private var stocksView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 28) {
                Button {
                    
                } label: {
                    VStack(spacing: 0) {
                        Image("ic_overview")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.colorTextPrimary)

                        Text("overview".localized)
                            .font(.apply(.medium, size: 12))
                            .foregroundStyle(Color.colorTextPrimary)
                    }
                }
                .buttonStyle(.plain)
                
                Button {
                    
                } label: {
                    VStack(spacing: 0) {
                        Image("ic_tops")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.colorTextPrimary)

                        Text("top_stocks".localized)
                            .font(.apply(.medium, size: 12))
                            .foregroundStyle(Color.colorTextPrimary)

                    }
                }
                .buttonStyle(.plain)
                
                Button {
                    
                } label: {
                    VStack(spacing: 0) {
                        Image("ic_marketT&S")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.colorTextPrimary)

                        Text("market_time_sale".localized)
                            .font(.apply(.medium, size: 12))
                            .foregroundStyle(Color.colorTextPrimary)

                    }
                }
                .buttonStyle(.plain)
                
                Button {
                    
                } label: {
                    VStack(spacing: 0) {
                        Image("ic_watchlist")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.colorTextPrimary)

                        Text("watchlist".localized)
                            .font(.apply(.medium, size: 12))
                            .foregroundStyle(Color.colorTextPrimary)

                    }
                }
                .buttonStyle(.plain)




            }
            .padding(.top, 16)
            
            Color.colorTextPrimary
                .frame(height: 1)
                .padding(.horizontal, 24)
                .padding(.bottom, 12)
            
            VStack(spacing: 12) {
                HStack(alignment: .center, spacing: 18) {
                    VStack {
                        HStack {
                            VStack(alignment: .center, spacing: 0) {
                                Text("ETISALAT")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorTextPrimary)

                                Text("36.68")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorTextSecondary)
                                    .offset(y: -4)

                            }
                            
                            Color.colorTextPrimary
                                .frame(width: 1, height: 18)

                            VStack(alignment: .center, spacing: 0) {
                                Text("0.100")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorGreen)

                                Text("10.00%")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorGreen)
                                    .offset(y: -4)

                            }
                        }
                        .padding(.vertical, 2)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 24)
                        
                        
                    }
                    .overlay {
                        VStack {
                            
                            Spacer()
                            
                            Color.colorGreen
                                .frame(height: 18)
                                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])

                        }
                    }
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 12).fill(Color.colorBackground)
                            RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).foregroundStyle(Color.colorTextSecondary)
                        }
                    )
                    
                    VStack {
                        HStack {
                            VStack(alignment: .center, spacing: 0) {
                                Text("ETISALAT")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorTextPrimary)

                                Text("36.68")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorTextSecondary)
                                    .offset(y: -4)

                            }
                            
                            Color.colorTextPrimary
                                .frame(width: 1, height: 18)

                            VStack(alignment: .center, spacing: 0) {
                                Text("0.100")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorGreen)

                                Text("10.00%")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorGreen)
                                    .offset(y: -4)

                            }
                        }
                        .padding(.vertical, 2)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 24)

                        
                    }
                    .overlay {
                        VStack {
                            
                            Spacer()
                            
                            Color.colorRed
                                .frame(height: 18)
                                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])

                        }
                    }
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 12).fill(Color.colorBackground)
                            RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).foregroundStyle(Color.colorTextSecondary)
                        }
                    )
                    
                    VStack {
                        HStack {
                            VStack(alignment: .center, spacing: 0) {
                                Text("ETISALAT")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorTextPrimary)

                                Text("36.68")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorTextSecondary)
                                    .offset(y: -4)

                            }
                            
                            Color.colorTextPrimary
                                .frame(width: 1, height: 18)

                            VStack(alignment: .center, spacing: 0) {
                                Text("0.100")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorGreen)

                                Text("10.00%")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorGreen)
                                    .offset(y: -4)

                            }
                        }
                        .padding(.vertical, 2)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 24)

                        
                    }
                    .overlay {
                        VStack {
                            
                            Spacer()
                            
                            Color.colorBlue
                                .frame(height: 18)
                                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])

                        }
                    }
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 12).fill(Color.colorBackground)
                            RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).foregroundStyle(Color.colorTextSecondary)
                        }
                    )
                    
                }
                
                HStack(alignment: .center, spacing: 18) {
                    VStack {
                        HStack {
                            VStack(alignment: .center, spacing: 0) {
                                Text("ETISALAT")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorTextPrimary)

                                Text("36.68")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorTextSecondary)
                                    .offset(y: -4)

                            }
                            
                            Color.colorTextPrimary
                                .frame(width: 1, height: 18)

                            VStack(alignment: .center, spacing: 0) {
                                Text("0.100")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorGreen)

                                Text("10.00%")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorGreen)
                                    .offset(y: -4)

                            }
                        }
                        .padding(.vertical, 2)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 24)
                        
                        
                    }
                    .overlay {
                        VStack {
                            
                            Spacer()
                            
                            Color.colorGreen
                                .frame(height: 18)
                                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])

                        }
                    }
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 12).fill(Color.colorBackground)
                            RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).foregroundStyle(Color.colorTextSecondary)
                        }
                    )
                    
                    VStack {
                        HStack {
                            VStack(alignment: .center, spacing: 0) {
                                Text("ETISALAT")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorTextPrimary)

                                Text("36.68")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorTextSecondary)
                                    .offset(y: -4)

                            }
                            
                            Color.colorTextPrimary
                                .frame(width: 1, height: 18)

                            VStack(alignment: .center, spacing: 0) {
                                Text("0.100")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorGreen)

                                Text("10.00%")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorGreen)
                                    .offset(y: -4)

                            }
                        }
                        .padding(.vertical, 2)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 24)

                        
                    }
                    .overlay {
                        VStack {
                            
                            Spacer()
                            
                            Color.colorRed
                                .frame(height: 18)
                                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])

                        }
                    }
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 12).fill(Color.colorBackground)
                            RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).foregroundStyle(Color.colorTextSecondary)
                        }
                    )
                    
                    VStack {
                        HStack {
                            VStack(alignment: .center, spacing: 0) {
                                Text("ETISALAT")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorTextPrimary)

                                Text("36.68")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorTextSecondary)
                                    .offset(y: -4)

                            }
                            
                            Color.colorTextPrimary
                                .frame(width: 1, height: 18)

                            VStack(alignment: .center, spacing: 0) {
                                Text("0.100")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorGreen)

                                Text("10.00%")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorGreen)
                                    .offset(y: -4)

                            }
                        }
                        .padding(.vertical, 2)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 24)

                        
                    }
                    .overlay {
                        VStack {
                            
                            Spacer()
                            
                            Color.colorBlue
                                .frame(height: 18)
                                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])

                        }
                    }
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 12).fill(Color.colorBackground)
                            RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).foregroundStyle(Color.colorTextSecondary)
                        }
                    )
                    
                }

                HStack(alignment: .center, spacing: 18) {
                    VStack {
                        HStack {
                            VStack(alignment: .center, spacing: 0) {
                                Text("ETISALAT")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorTextPrimary)

                                Text("36.68")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorTextSecondary)
                                    .offset(y: -4)

                            }
                            
                            Color.colorTextPrimary
                                .frame(width: 1, height: 18)

                            VStack(alignment: .center, spacing: 0) {
                                Text("0.100")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorGreen)

                                Text("10.00%")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorGreen)
                                    .offset(y: -4)

                            }
                        }
                        .padding(.vertical, 2)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 24)
                        
                        
                    }
                    .overlay {
                        VStack {
                            
                            Spacer()
                            
                            Color.colorGreen
                                .frame(height: 18)
                                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])

                        }
                    }
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 12).fill(Color.colorBackground)
                            RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).foregroundStyle(Color.colorTextSecondary)
                        }
                    )
                    
                    VStack {
                        HStack {
                            VStack(alignment: .center, spacing: 0) {
                                Text("ETISALAT")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorTextPrimary)

                                Text("36.68")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorTextSecondary)
                                    .offset(y: -4)

                            }
                            
                            Color.colorTextPrimary
                                .frame(width: 1, height: 18)

                            VStack(alignment: .center, spacing: 0) {
                                Text("0.100")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorGreen)

                                Text("10.00%")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorGreen)
                                    .offset(y: -4)

                            }
                        }
                        .padding(.vertical, 2)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 24)

                        
                    }
                    .overlay {
                        VStack {
                            
                            Spacer()
                            
                            Color.colorRed
                                .frame(height: 18)
                                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])

                        }
                    }
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 12).fill(Color.colorBackground)
                            RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).foregroundStyle(Color.colorTextSecondary)
                        }
                    )
                    
                    VStack {
                        HStack {
                            VStack(alignment: .center, spacing: 0) {
                                Text("ETISALAT")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorTextPrimary)

                                Text("36.68")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorTextSecondary)
                                    .offset(y: -4)

                            }
                            
                            Color.colorTextPrimary
                                .frame(width: 1, height: 18)

                            VStack(alignment: .center, spacing: 0) {
                                Text("0.100")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorGreen)

                                Text("10.00%")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorGreen)
                                    .offset(y: -4)

                            }
                        }
                        .padding(.vertical, 2)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 24)

                        
                    }
                    .overlay {
                        VStack {
                            
                            Spacer()
                            
                            Color.colorBlue
                                .frame(height: 18)
                                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])

                        }
                    }
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 12).fill(Color.colorBackground)
                            RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).foregroundStyle(Color.colorTextSecondary)
                        }
                    )
                    
                }
                
                HStack(alignment: .center, spacing: 18) {
                    VStack {
                        HStack {
                            VStack(alignment: .center, spacing: 0) {
                                Text("ETISALAT")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorTextPrimary)

                                Text("36.68")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorTextSecondary)
                                    .offset(y: -4)

                            }
                            
                            Color.colorTextPrimary
                                .frame(width: 1, height: 18)

                            VStack(alignment: .center, spacing: 0) {
                                Text("0.100")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorGreen)

                                Text("10.00%")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorGreen)
                                    .offset(y: -4)

                            }
                        }
                        .padding(.vertical, 2)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 24)
                        
                        
                    }
                    .overlay {
                        VStack {
                            
                            Spacer()
                            
                            Color.colorGreen
                                .frame(height: 18)
                                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])

                        }
                    }
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 12).fill(Color.colorBackground)
                            RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).foregroundStyle(Color.colorTextSecondary)
                        }
                    )
                    
                    VStack {
                        HStack {
                            VStack(alignment: .center, spacing: 0) {
                                Text("ETISALAT")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorTextPrimary)

                                Text("36.68")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorTextSecondary)
                                    .offset(y: -4)

                            }
                            
                            Color.colorTextPrimary
                                .frame(width: 1, height: 18)

                            VStack(alignment: .center, spacing: 0) {
                                Text("0.100")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorGreen)

                                Text("10.00%")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorGreen)
                                    .offset(y: -4)

                            }
                        }
                        .padding(.vertical, 2)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 24)

                        
                    }
                    .overlay {
                        VStack {
                            
                            Spacer()
                            
                            Color.colorRed
                                .frame(height: 18)
                                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])

                        }
                    }
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 12).fill(Color.colorBackground)
                            RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).foregroundStyle(Color.colorTextSecondary)
                        }
                    )
                    
                    VStack {
                        HStack {
                            VStack(alignment: .center, spacing: 0) {
                                Text("ETISALAT")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorTextPrimary)

                                Text("36.68")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorTextSecondary)
                                    .offset(y: -4)

                            }
                            
                            Color.colorTextPrimary
                                .frame(width: 1, height: 18)

                            VStack(alignment: .center, spacing: 0) {
                                Text("0.100")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorGreen)

                                Text("10.00%")
                                    .font(.apply(.medium, size: 8))
                                    .foregroundStyle(Color.colorGreen)
                                    .offset(y: -4)

                            }
                        }
                        .padding(.vertical, 2)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 24)

                        
                    }
                    .overlay {
                        VStack {
                            
                            Spacer()
                            
                            Color.colorBlue
                                .frame(height: 18)
                                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])

                        }
                    }
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 12).fill(Color.colorBackground)
                            RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).foregroundStyle(Color.colorTextSecondary)
                        }
                    )
                    
                }

               

            }
            .padding(.bottom, 12)
        }
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.colorBackgroundSecondary))
        .padding(.vertical, 8)
        .padding(.horizontal, 16)

    }

    
}

#Preview {
    HomeContentView(marketsData: .constant([MarketsUIModel(marketName: "ADX", marketStatus: "Pre-Open adjustment", marketDate: Date().toString(dateFormat: .yyMMddWithTime), lastTradePrice: "9,306.77", netChange: "3.36", netChangePerc: "0.04%", symbolsTraded: "2", tradesUp: "1", tradesEqual: "0", tradesDown: "1", turnover: "17,815,738", volume: "514,895", trades: "254")]), stocksData: .constant([StocksUIModel(stockName: "ETISALAT", lastTradePrice: "36.68", netChange: "0.100", netChangePerc: "10.00%"), StocksUIModel(stockName: "WATANIA", lastTradePrice: "0.650", netChange: "-0.004", netChangePerc: "-0.615%"), StocksUIModel(stockName: "ETISALAT", lastTradePrice: "36.68", netChange: "0.100", netChangePerc: "10.00%"), StocksUIModel(stockName: "WATANIA", lastTradePrice: "0.650", netChange: "-0.004", netChangePerc: "-0.615%")]), symbolSearch: "", onAccountInformationTap: {
        
    }, onMyDocumentsTap: {
        
    }, onMarketsInsightTap: {
        
    }, onMyAlertsTap: {
        
    }, onAccountStatements: {
        
    }, onCashDeposit: {
        
    }, onEquityTransferTap: {
        
    }, onTransfersTap: {
        
    }, onClientPortalTap: {
        
    }, onIPOTap: {
        
    }, onSettingsTap: {
        
    })
}
