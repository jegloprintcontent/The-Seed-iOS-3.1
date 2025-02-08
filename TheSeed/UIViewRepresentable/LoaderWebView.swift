//
//  LoaderWebView.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 10/12/2022.
//

import Foundation
import WebKit
import SwiftUI

struct LoaderWebView: UIViewRepresentable {
   
    @ObservedObject var viewModel: WebViewModel
    let webView = WKWebView()
    
    func makeUIView(context: Context) -> WKWebView {
        self.webView.navigationDelegate = context.coordinator
        if let url = URL(string: viewModel.article.link) {
                    self.webView.load(URLRequest(url: url))
                }
                return self.webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        return
    }
    
    typealias UIViewType = WKWebView
   

        
    class Coordinator: NSObject, WKNavigationDelegate {
        private var viewModel: WebViewModel

        init(_ viewModel: WebViewModel) {
            self.viewModel = viewModel
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            self.viewModel.isLoadingView = true
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            //print("WebView: navigation finished")
            self.viewModel.didFinishLoading = true
            self.viewModel.isLoadingView = false
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel)
    }

        
}
