//
//  SBVideoScroll.swift
//  Vybey-Boi
//
//  Created by Stephen Looney  
//  Copyright 2022 Spaceboat Development, LLC. All rights reserved.  
//

import Foundation
import SwiftUI
import AVKit


struct SBVideoScroll: View {
        
    @ObservedObject var videoNotifier = VideoNotifier()

    @State var currentScrollOffset = CGPoint.zero
    
    var body: some View {
        SBScrollView(
            offsetChanged: {
                if (abs(currentScrollOffset.y - $0.y) > 20) {
                    currentScrollOffset = $0
                }
            }
        ) {
            videoList
        }.task {
            await videoNotifier.list()
        }
    }
}

extension SBVideoScroll {
    
    static let userImageSize = 50.0
    static let userImageCornerRadius = SBVideoScroll.userImageSize / 2.0
    static let padding = 10.0
    static let viewAppearBufferRange = -80.0
    
    var videoList: some View {
        return LazyVStack(alignment: .leading) {
            
            ForEach(Array(videoNotifier.videoList.enumerated()), id: \.offset) { (index, model) in
                
                let player = AVQueuePlayer()
                let videoURL: URL = URL(string: model.url)!
                
                listCell(with: model)
                    .padding(SBVideoScroll.padding)
                
                LoopingVideoCell(url: videoURL, player: player, scrollPosition: $currentScrollOffset)
                    .cornerRadius(SBVideoScroll.padding * 2)
                    .frame(width: UIScreen.main.bounds.width - (SBVideoScroll.padding * 2), height: UIScreen.main.bounds.width - (SBVideoScroll.padding * 2), alignment: .center)
                    .padding(SBVideoScroll.padding)
                    .onAppear {
                        if index == 0 && (currentScrollOffset.y > SBVideoScroll.viewAppearBufferRange) {
                            player.play()
                        }
                    }
            }
        }
    }
    
    func listCell(with model: VideoModel) -> some View {
        return HStack {
            AsyncImage(url: Constants.defaultImageURL) { image in
              image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(SBVideoScroll.userImageCornerRadius)
            } placeholder: {
              ProgressView()
                .progressViewStyle(.circular)
            }.frame(width: SBVideoScroll.userImageSize, height: SBVideoScroll.userImageSize)
            
            VStack(alignment:.leading) {
                Text(model.title)
                    .font(.body)
                Text(model.description)
                    .font(.subheadline)
            }
        }
    }
}

struct SBVideoScroll_Previews: PreviewProvider {
    static var previews: some View {
        SBVideoScroll()
    }
}
