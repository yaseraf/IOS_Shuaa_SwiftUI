//
//  SplashView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 16/07/2025.
//

import Foundation
import SwiftUI
import AVKit
struct SplashContentView: View {
    
    var onVideoEnd:() -> Void
    
    var body: some View {
        ZStack {
            Image(AppUtility.shared.isDarkTheme ? "splashNight" : "splashDay")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if let url = Bundle.main.url(forResource: AppUtility.shared.isDarkTheme ? "night" : "day", withExtension: "mp4") {
                let player = AVPlayer(url: url)
                
                VideoPlayer(player: player)
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .offset(x: -48)
                    .disabled(true)
                    .onAppear {
                        player.play()
                    }
                    .onReceive (
                        NotificationCenter.default.publisher(
                            for: .AVPlayerItemDidPlayToEndTime,
                            object: player.currentItem
                        )
                    ) { _ in
                        onVideoEnd()
                    }
            }
        }
    }
}

#Preview {
    SplashContentView(onVideoEnd: {
        
    })
}
