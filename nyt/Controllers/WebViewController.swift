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
    
    // MARK: - Propertie(s)
    var amazonLink: String?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: amazonLink ?? "https://www.amazon.com/") {
            webView.load(URLRequest(url: url))
        }
    }
}
