//
//  VideoModel.swift
//  Vybey-Boi
//
//  Created by Stephen Looney  
//  Copyright 2022 Spaceboat Development, LLC. All rights reserved.  
//

import Foundation

struct VideoModel: Codable {
    var id: UUID
    var title: String
    var description: String
    var url: String
}

extension VideoModel {
    static let mockList = [
        VideoModel(id: UUID(), title: "Macho Man", description: "This is a city time lapse", url: "https://video-previews.elements.envatousercontent.com/files/8855a355-820b-450a-8dd9-436f827bf74d/video_preview_h264.mp4"),
        VideoModel(id: UUID(), title: "Macho Man", description: "Rotating sign shot", url: "https://video-previews.elements.envatousercontent.com/files/d9febc4f-8978-4c86-86b5-9481c3a42cd0/video_preview_h264.mp4"),
        VideoModel(id: UUID(), title: "Macho Man", description: "Big mountain lake", url: "https://video-previews.elements.envatousercontent.com/files/6101e12f-d115-4314-8699-d25cdcb6e74f/video_preview_h264.mp4"),
        VideoModel(id: UUID(), title: "Macho Man", description: "This is a city time lapse", url: "https://video-previews.elements.envatousercontent.com/files/8855a355-820b-450a-8dd9-436f827bf74d/video_preview_h264.mp4"),
        VideoModel(id: UUID(), title: "Macho Man", description: "Rotating sign shot", url: "https://video-previews.elements.envatousercontent.com/files/d9febc4f-8978-4c86-86b5-9481c3a42cd0/video_preview_h264.mp4"),
        VideoModel(id: UUID(), title: "Macho Man", description: "Big mountain lake", url: "https://video-previews.elements.envatousercontent.com/files/6101e12f-d115-4314-8699-d25cdcb6e74f/video_preview_h264.mp4")
    ]
}
