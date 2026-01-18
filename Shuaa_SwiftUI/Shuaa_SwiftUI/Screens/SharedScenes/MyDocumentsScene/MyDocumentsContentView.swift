//
//  MyDocumentsContentView.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 27/07/2025.
//

import Foundation
import SwiftUI

struct MyDocumentsContentView:View {
        
    var documentsData:Binding<[DocumentsUIModel]?>
    
    var body: some View {
        VStack {
            SharedHeaderView(withBackButton: true)
            
            titleView
            
            contentView
            
            ScrollView(showsIndicators: false) {
                documentsDataView
            }
            
            Spacer()
            
            HomeBottomBarView(selectedItem: UserDefaultController().selectedBottomTab ?? .home)
        }
        .background(Color.colorBackground) // Debug
    }
    
    private var titleView: some View {
        Text("my_documents".localized)
            .font(.apply(.bold, size: 16))
            .foregroundStyle(Color.colorWhite)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 24)
    }
    
    private var contentView: some View {
        VStack {
            HStack {
                Text("type".localized)
                    .font(.apply(.regular, size: 12))
                    .foregroundStyle(Color.colorWhite)
                    .frame(minWidth: 64)

                Spacer()
                
                Text("status".localized)
                    .font(.apply(.regular, size: 12))
                    .foregroundStyle(Color.colorWhite)

                Spacer()
                
                Text("action".localized)
                    .font(.apply(.regular, size: 12))
                    .foregroundStyle(Color.colorWhite)
                    .padding(.horizontal, 16)

            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            .background(Color.colorGray)
            .cornerRadius(12)
            .padding(.horizontal, 12)
        }
    }
    
    private var documentsDataView: some View {
        VStack {
            ForEach(Array((documentsData.wrappedValue ?? []).enumerated()), id: \.offset) { index, item in
                HStack {
                    Text("\(item.documentType ?? "")")
                        .font(.apply(.bold, size: 14))
                        .foregroundStyle(item.documentStatus == "Expired" ? Color.colorRed : Color.colorTextPrimary)
                        .frame(minWidth: 64)

                    Spacer()
                    
                    Text("\(item.documentStatus ?? "")")
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(item.documentStatus == "Expired" ? Color.colorRed : Color.colorTextPrimary)

                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("update".localized)
                            .font(.apply(.bold, size: 12))
                            .foregroundStyle(Color.colorWhite)
                            .padding()
                            .background(Color.colorUpdateButton)
                            .cornerRadius(8)
                    }

                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.colorBackgroundSecondary)
                .cornerRadius(12)
                .padding(.horizontal, 12)
            }
        }
    }
        
}

#Preview {
    MyDocumentsContentView(
        documentsData: .constant(DocumentsUIModel.initMockData())
    )
}
