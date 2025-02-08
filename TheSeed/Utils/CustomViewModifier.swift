//
//  CustomViewModifier.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 04/12/2022.
//

import SwiftUI


//viewModifiers
extension View {
    func asTile() -> some View {
        modifier(CustomViewModifier())
    }
}


struct CustomViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .cornerRadius(5)
            .shadow(color: .init(.sRGB, white: 0.5, opacity: 1), radius: 2, x: 0.0, y: 4)
    }
}
