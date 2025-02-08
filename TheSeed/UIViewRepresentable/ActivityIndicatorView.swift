//
//  ActivityIndicatorView.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 05/12/2022.
//

import Foundation
import SwiftUI



struct ActivityIndicatorView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        
        let aiv: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
        aiv.startAnimating()
        aiv.color = .white
        return aiv
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        //
    }
    
    
    typealias UIViewType = UIActivityIndicatorView
}
