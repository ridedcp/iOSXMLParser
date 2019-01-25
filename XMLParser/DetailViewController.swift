//
//  DetailViewController.swift
//  XMLParser
//
//  Created by Daniel Cano on 25/01/2019.
//  Copyright © 2019 danielcano. All rights reserved.
//

import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    var web: String = String()
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Show URL in the object if the class WKWebView
        let url: URL = URL(string: web)!
        let request: URLRequest = URLRequest(url: url)
        
        webView.load(request)
        webView.navigationDelegate = self
    }
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        self.activity.isHidden = false
        self.view.isUserInteractionEnabled = false
    }


    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        self.activity.isHidden = true
        self.view.isUserInteractionEnabled = true
    }
}
