//
//  VideoModelAPIRequests.swift
//  Vybey-Boi
//
//  Created by Stephen Looney  
//  Copyright 2022 Spaceboat Development, LLC. All rights reserved.

import Foundation

struct VideoModelAPIRequests {
    static func listVideos() -> Resource<[VideoModel]> {
        Resource(
            url: URL(string: Endpoints.getVideosURL)!,
            params: nil) { data in
            return try JSONDecoder().decode([VideoModel].self, from: data)
        }
    }
}
