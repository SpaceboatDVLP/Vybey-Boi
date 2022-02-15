//
//  ScrollView+Offset.swift
//  Vybey-Boi
//
//  Created by Stephen Looney  
//  Copyright 2022 Spaceboat Development, LLC. All rights reserved. on 2/15/22.
//

import SwiftUI

private struct ScrollOffsetPreferenceKey: PreferenceKey {
    
    static let coordinateSpace = "SBScrollView"
    
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}

struct SBScrollView<Content: View>: View {
    
    let axes: Axis.Set
    let showsIndicators: Bool
    let offsetChanged: (CGPoint) -> Void
    let content: Content

    init(
        axes: Axis.Set = .vertical,
        showsIndicators: Bool = false,
        offsetChanged: @escaping (CGPoint) -> Void = { _ in },
        @ViewBuilder content: () -> Content
    ) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.offsetChanged = offsetChanged
        self.content = content()
    }
    
    var body: some View {
        SwiftUI.ScrollView(axes, showsIndicators: showsIndicators) {
            GeometryReader { geometry in
                Spacer().preference(
                    key: ScrollOffsetPreferenceKey.self,
                    value: geometry.frame(in: .named(ScrollOffsetPreferenceKey.coordinateSpace)).origin
                )
            }.frame(width: 0, height: 0)
            content
        }
        .coordinateSpace(name: ScrollOffsetPreferenceKey.coordinateSpace)
        .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: offsetChanged)
    }
}
