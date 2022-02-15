//
//  Vybey_BoiApp.swift
//  Vybey-Boi
//
//  Created by Stephen Looney  
//  Copyright 2022 Spaceboat Development, LLC. All rights reserved.  
//

import SwiftUI

let environment = Environment.dev

@main
struct Vybey_BoiApp: App {
    
    init() {
        AppManager.prepare()
    }
    
    var body: some Scene {
        WindowGroup {
            SBVideoScroll()
        }
    }
}
