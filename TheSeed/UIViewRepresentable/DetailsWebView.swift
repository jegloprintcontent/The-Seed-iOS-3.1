//
//  DetailsWebView.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 24/12/2022.
//

import SwiftUI
import WebKit

struct Webview : UIViewRepresentable {
    @Binding var dynamicHeight: CGFloat
    var webview: WKWebView = WKWebView()
    @Binding var content: String
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: Webview
        
        init(_ parent: Webview) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (height, error) in
                DispatchQueue.main.async {
                    self.parent.dynamicHeight = height as! CGFloat
                }
            })
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView  {
        webview.scrollView.bounces = false
        webview.navigationDelegate = context.coordinator
        let htmlStart = """
        <HTML>
        <HEAD>
            <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, shrink-to-fit=no\">
            <style>
                body {font-family:Georgia,Times New Roman,Times,Cambria,serif !important;}
                p { font-size: 1.2rem; color: #333; line-height: 1.8; }
                iframe {padding: 0; margin: 0; text-align: center;}
                iframe { width:100%; height:240px; }
                video {width: 100%; height: 100%;}
                img { width:100%; max-width:100%;height:auto;}
                figure { max-width: 100%;height:auto;}
                .entry-content img { max-width:100%;}
                blockquote:before { content: '\"';font-size:30px; line-height:1.4;position:absolute;left: 30px; }
                blockquote p{ font-weight:bold;margin: 0 auto;font-style:italic; }
            </style>
        </HEAD>
        <BODY>
        """
        let htmlEnd = "</BODY></HTML>"
        let dummy_html = self.content
        let htmlString = "\(htmlStart)\(dummy_html)\(htmlEnd)"
        webview.loadHTMLString(htmlString, baseURL:  nil)
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
