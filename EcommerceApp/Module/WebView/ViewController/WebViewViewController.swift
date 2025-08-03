//
//  WebViewViewController.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 24/07/25.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
    
    var objPageType : PageType = .AboutUs
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        if objPageType == .AboutUs{
            
            self.title = "About Us"
            
            if let url = URL(string: "https://corporate.flipkart.net/about-us") {
                let request = URLRequest(url: url)
                webView.load(request)
            }
            
        }
        
        else if objPageType == .TermsAndConditions{
            
            self.title = "Terms & Conditions"
            
            if let url = URL(string: "https://www.flipkart.com/pages/terms") {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }
        
        else if objPageType == .PrivacyPolicy{
            
            self.title = "Privacy Policy"
            
            if let url = URL(string: "https://www.flipkart.com/pages/privacypolicy") {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }
    }
}

extension WebViewViewController : WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicator.startAnimating()
        indicator.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
        indicator.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        indicator.stopAnimating()
        indicator.isHidden = true
    }
}
