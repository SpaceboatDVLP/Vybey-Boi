//
//  Env.swift
//  Vybey-Boi
//
//  Created by Stephen Looney  
//  Copyright 2022 Spaceboat Development, LLC. All rights reserved.  
//

enum Environment {
    case prod
    case dev
    case staging
}

struct AppManager {
    static func prepare() {
        switch environment {
        case .dev:
            // set web service URL to development
            // set API keys to development
            return
        case .staging:
            // set web service URL to staging
            // set API keys to development
            return
        case .prod:
            // set web service URL to production
            // set API keys to production
            return
        }
    }
}

