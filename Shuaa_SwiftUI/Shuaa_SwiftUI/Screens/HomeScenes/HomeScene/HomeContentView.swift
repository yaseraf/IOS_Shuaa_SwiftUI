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
    
    @State var showMarketDetails = false
    
    var body: some View {
        VStack {
            
            headerView
            
            marketsView
            
            ScrollView {
                chartView
                
                stocksView

            }
            
            Spacer()
            
            HomeBottomBarView(selectedItem: .home)
                .frame(maxWidth: .infinity)
        }
    }
    
    private var headerView: some View {
        HStack {
            Image("ic_connection")
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundStyle(Color.green)
            
            Image("ic_notification")
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundStyle(Color.colorBGPrimary)

            HStack {
                Image("ic_search")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundStyle(Color.colorBGPrimary)

                TextField("symbol_search".localized, text: $symbolSearch)
            }
            .padding(.vertical, 2)
            .padding(.horizontal, 12)
            .background(RoundedRectangle(cornerRadius: 8).fill(.gray))

            Image("ic_menu")
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundStyle(Color.colorBGPrimary)

        }
        .padding(.horizontal, 16)
    }
    
    private var marketsView: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("ADX")
                        
                         Divider()
                            .frame(width: 1, height: 18)
                        
                        Text("Pre-Open adjustment")
                    }
                    Text("31/12/2025 | 12:17:13 PM")
                }
                
                Spacer()
                
                HStack {
                    Text("9,306.77")
                    VStack(alignment: .center) {
                        Text("3.36")
                        Text("0.04%")
                    }
                }
                
                Button {
                    showMarketDetails.toggle()
                } label: {
                    Image("ic_upArrow")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color.colorBGPrimary)

                }

            }
            .padding(.horizontal, 12)
            
            if showMarketDetails {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Turnover")
                            Text("17,815,738")
                        }
                        
                        HStack {
                            Text("Volume")
                            Text("514,895")
                        }

                        HStack {
                            Text("Trades")
                            Text("254")
                        }
                    }
                    
                    Divider()
                        .frame(width: 1, height: 50)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Symbols Traded")
                            Text("2")
                        }
                        
                        HStack {
                            Text("1")
                            Image("ic_imgUp")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 18, height: 18)
                            Color.green
                                .frame(height: 12)
                                .frame(maxWidth: 65)
                        }

                        HStack {
                            Text("0")
                            Text("=")
                        }
                        
                        HStack {
                            Text("1")
                            Image("ic_imgDown")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 18, height: 18)
                            Color.red
                                .frame(height: 12)
                                .frame(maxWidth: 65)
                        }
                    }

                }

            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .padding(.horizontal, 16)

        .background(RoundedRectangle(cornerRadius: 12).fill(Color.gray))
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }
    
    private var chartView: some View {
        VStack {
            Text("chart")
        }
        .frame(height: 300)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 12).fill(.gray))
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }
    
    private var stocksView: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    VStack {
                        Image("ic_overview")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 24, height: 24)

                        Text("overview")
                    }
                }
                .buttonStyle(.plain)
                
                Button {
                    
                } label: {
                    VStack {
                        Image("ic_tops")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 24, height: 24)

                        Text("top stocks")
                    }
                }
                .buttonStyle(.plain)
                
                Button {
                    
                } label: {
                    VStack {
                        Image("ic_marketT&S")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 24, height: 24)

                        Text("Market T&S")
                    }
                }
                .buttonStyle(.plain)
                
                Button {
                    
                } label: {
                    VStack {
                        Image("ic_watchlist")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 24, height: 24)

                        Text("Watchlist")
                    }
                }
                .buttonStyle(.plain)




            }
            
            Divider()
            
            VStack {
                HStack {
                    VStack {
                        HStack {
                            VStack {
                                Text("ETISALAT")
                                Text("36.68")
                            }
                            
                            Divider()
                                .frame(height: 32)
                            
                            VStack {
                                Text("0.100")
                                Text("10.00%")
                            }
                        }
                        .padding(8)
                        .padding(.bottom, 32)
                        
                        
                    }
                    .overlay {
                        VStack {
                            
                            Spacer()
                            
                            Color.green
                                .frame(height: 24)
                                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])

                        }
                    }
                    .background(RoundedRectangle(cornerRadius: 12).fill(.bar))
                    
                    VStack {
                        HStack {
                            VStack {
                                Text("WATANIA")
                                Text("0.650")
                            }
                            
                            Divider()
                                .frame(height: 32)
                            
                            VStack {
                                Text("-0.004")
                                Text("-0.615%")
                            }
                        }
                        .padding(8)
                        .padding(.bottom, 32)
                        
                        
                    }
                    .overlay {
                        VStack {
                            
                            Spacer()
                            
                            Color.green
                                .frame(height: 24)
                                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])

                        }
                    }
                    .background(RoundedRectangle(cornerRadius: 12).fill(.bar))

                    VStack {
                        HStack {
                            VStack {
                                Text("WATANIA")
                                Text("0.650")
                            }
                            
                            Divider()
                                .frame(height: 32)
                            
                            VStack {
                                Text("-0.004")
                                Text("-0.615%")
                            }
                        }
                        .padding(8)
                        .padding(.bottom, 32)
                        
                        
                    }
                    .overlay {
                        VStack {
                            
                            Spacer()
                            
                            Color.green
                                .frame(height: 24)
                                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])

                        }
                    }
                    .background(RoundedRectangle(cornerRadius: 12).fill(.bar))

                    
                }
                
                
                HStack {
                    VStack {
                        HStack {
                            VStack {
                                Text("ETISALAT")
                                Text("36.68")
                            }
                            
                            Divider()
                                .frame(height: 32)
                            
                            VStack {
                                Text("0.100")
                                Text("10.00%")
                            }
                        }
                        .padding(8)
                        .padding(.bottom, 32)
                        .opacity(0)

                        
                    }
                    .overlay {
                        VStack {
                            
                            Spacer()
                            
                            Color.green
                                .frame(height: 24)
                                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])

                        }
                    }
                    .background(RoundedRectangle(cornerRadius: 12).fill(.bar))
                    
                    VStack {
                        HStack {
                            VStack {
                                Text("WATANIA")
                                Text("0.650")
                            }
                            
                            Divider()
                                .frame(height: 32)
                            
                            VStack {
                                Text("-0.004")
                                Text("-0.615%")
                            }
                        }
                        .padding(8)
                        .padding(.bottom, 32)
                        
                        
                    }
                    .overlay {
                        VStack {
                            
                            Spacer()
                            
                            Color.green
                                .frame(height: 24)
                                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])

                        }
                    }
                    .background(RoundedRectangle(cornerRadius: 12).fill(.bar))

                    VStack {
                        HStack {
                            VStack {
                                Text("WATANIA")
                                Text("0.650")
                            }
                            
                            Divider()
                                .frame(height: 32)
                            
                            VStack {
                                Text("-0.004")
                                Text("-0.615%")
                            }
                        }
                        .padding(8)
                        .padding(.bottom, 32)
                        
                        
                    }
                    .overlay {
                        VStack {
                            
                            Spacer()
                            
                            Color.green
                                .frame(height: 24)
                                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])

                        }
                    }
                    .background(RoundedRectangle(cornerRadius: 12).fill(.bar))

                    
                }

                HStack {
                    
                }

                HStack {
                    
                }

            }
        }
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 12).fill(.gray))
        .padding(.vertical, 8)
        .padding(.horizontal, 16)

    }

    
}

#Preview {
    HomeContentView(symbolSearch: "")
}
