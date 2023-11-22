//
//  HHWebVC.swift
//  Hedio
//
//  Created by lilivi on 2023/11/23.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import SwiftUI
import Combine
import WebKit

public struct WebView: View, UIViewRepresentable {
    
    public let webView: WKWebView
    
    public init(webView: WKWebView) {
        self.webView = webView
    }
    
    public func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        webView
    }
    
    public func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
    }
}
