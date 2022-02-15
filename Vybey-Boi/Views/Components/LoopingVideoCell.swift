//
//  ContentView.swift
//  Vybey-Boi
//
//  Created by Stephen Looney  
//  Copyright 2022 Spaceboat Development, LLC. All rights reserved.  
//

import SwiftUI
import AVKit

struct LoopingVideoCell: View {
    
    var url: URL
    
    var player: AVQueuePlayer
    
    @Binding var scrollPosition: CGPoint
            
    var body: some View {
        
        VStack {
            GeometryReader { geo in
                LoopingVideoCellRepresentable(url: url, player: player)
                    .onChange(of: scrollPosition) { value in
                        if (geo.frame(in: .global).minY < 0) {
                            player.pause()
                        } else if (geo.frame(in: .global).maxY > UIScreen.main.bounds.height) {
                            player.pause()
                        } else {
                            player.play()
                        }
                    }
            }
        }
        
    }
}

struct LoopingVideoCellRepresentable: UIViewRepresentable {
    
    var url: URL
    var player: AVQueuePlayer
    
    var view: LoopingVideoCellUIView {
        LoopingVideoCellUIView(frame: .zero, url: url, player: player)
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LoopingVideoCellRepresentable>) {
    }

    func makeUIView(context: Context) -> UIView {
        return view
    }
}

class LoopingVideoCellUIView: UIView {
    
    var player: AVQueuePlayer
    var url: URL
    
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        fatalError("Must init with frame and url")
    }
    
    init(frame: CGRect, url: URL, player: AVQueuePlayer) {
        self.url = url
        self.player = player
        super.init(frame: frame)
        initPlayer()
    }

    private func initPlayer() {
        guard playerLayer.player == nil else {
            print("already initd player inside layer")
            return
        }

        let asset = AVAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        
        playerLayer.backgroundColor = UIColor.black.cgColor
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspect
        layer.addSublayer(playerLayer)
        
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

struct LoopingVideoCell_Previews: PreviewProvider {
    static let player = AVQueuePlayer()
    static let url = Bundle.main.url(forResource: "launch-demo", withExtension: "mov")!
    static var previews: some View {
        LoopingVideoCell(url: url, player: player, scrollPosition: .constant(CGPoint.zero))
            .frame(width: UIScreen.main.bounds.width - 20.0, height: UIScreen.main.bounds.width - 20.0, alignment: .center)
            .cornerRadius(20.0)
            .onAppear {
                player.play()
            }
            .onDisappear {
                player.pause()
            }
    }
}
