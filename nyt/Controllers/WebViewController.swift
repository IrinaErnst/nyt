//
//  WebViewController.swift
//  nyt
//
//  Created by Irina Ernst on 9/28/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    // MARK: - @IBOutlet(s)
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - Propertie(s)
    var amazonLink: String?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator?.color = Colors.darkGrey
        activityIndicator?.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        webView.navigationDelegate = self
        
        if let url = URL(string: amazonLink ?? "https://www.amazon.com/") {
            webView.load(URLRequest(url: url))
        }
    }
}

// MARK: - WKNavigationDelegate 
extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        activityIndicator?.stopAnimating()
    }
}

