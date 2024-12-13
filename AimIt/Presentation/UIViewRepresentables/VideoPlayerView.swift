//
//  VideoPlayerViw.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 12.12.2024.
//

import Foundation
import SwiftUI
import WebKit

struct GifImage: UIViewRepresentable {
    private var name: String
    private var width: CGFloat
    private var height: CGFloat
    private var backgroundColor: Color
    
    init(
        _ name: String,
        width: CGFloat,
        height: CGFloat,
        backgroundColor: Color
    ) {
        self.name = name
        self.width = width
        self.height = height
        self.backgroundColor = backgroundColor
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        webView.scrollView.isScrollEnabled = false
        webView.isOpaque = false
        webView.backgroundColor = .clear
        
        guard let gifData = NSDataAsset(name: name)?.data else {
            print("Failed to load GIF data from assets.")
            return webView
        }
        
        webView.load(
            gifData,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: URL(string: "about:blank")!
        )
        
        let html = """
            <html>
            <head>
            <style>
            body {
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                background: \(backgroundColor);
                overflow: hidden;
            }
            img {
                max-width: \(width)px;
                max-height: \(height)px;
                width: auto;
                height: auto;
            }
            </style>
            </head>
            <body>
            <img src="data:image/gif;base64,\(gifData.base64EncodedString())" />
            </body>
            </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
}
