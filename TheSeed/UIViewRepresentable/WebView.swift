//
//  WebView.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 09/12/2022.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    typealias UIViewType = WKWebView
    
    
}

#if DEBUG
struct WebView_Previews : PreviewProvider {
    static var previews: some View {
        WebView(url: URL(string: "www.google.com")!)
    }
}
#endif

