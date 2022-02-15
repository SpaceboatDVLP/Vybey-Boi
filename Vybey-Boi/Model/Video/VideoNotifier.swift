//
//  VideoNotifier.swift
//  Vybey-Boi
//
//  Created by Stephen Looney  
//  Copyright 2022 Spaceboat Development, LLC. All rights reserved. on 2/14/22.
//

import SwiftUI

class VideoNotifier: ObservableObject {
    
    @Published var videoList: [VideoModel] = []
    @Published var isLoading = false
    
    func list() async {
        guard (environment == .prod || environment == .staging) else { videoList = VideoModel.mockList; return }
        do {
            videoList = try await WebService.get(resource: VideoModelAPIRequests.listVideos())
        } catch {
            videoList = []
        }
    }
}
