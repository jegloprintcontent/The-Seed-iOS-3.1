//
//  NavigationLazyView.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 10/12/2022.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}

