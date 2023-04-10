//
//  ViewController.swift
//  Project 04
//
//  Created by Júlio Bragança on 10/04/23.
//

import UIKit
import WebKit // new framework that is used for webviews

class ViewController: UIViewController, WKNavigationDelegate { // V1: including the navigationDelegate so we can use it in the method loadView
    var webView: WKWebView! // V1: storing the web view as a property
    
    override func loadView() {
        webView = WKWebView()  // V1: create a new instance of Apple's WKWebView and assign it to the webView property
        webView.navigationDelegate = self // we're setting the web view's navigationDelegate property to self, which means "when any web page navigation happens, please tell me – the current view controller.”
        view = webView // V1: we make our view (the root view of the view controller) that web view.
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped)) // V2: this is to give the user the option to choose from one of our selected websites.
        
        let url = URL(string: "https://www.apple.com")! // V1: Swift stores URLs in a specific URL data type. the URL must be complete.
        webView.load(URLRequest(url: url)) // V1: creates a URLRequest object from that URL and gives it to our web view to load. WKWebView don't load websites from strings, or even from URL made out of those strings, you need to put the URL(first line) into an URLRequest.
        webView.allowsBackForwardNavigationGestures = true // V1: enables a property on the web view that allows users to swipe from the left or right edge to move backward or forward in their web browsing. Many users rely on this, so it's good to keep it around.
    }
    
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet) // V2: We're using nil for the message, because this alert doesn't need one. We're using the preferredStyle of .actionSheet because we're prompting the user for more information.
        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel)) // We're adding a dedicated Cancel button using style .cancel. It doesn’t provide a handler parameter, which means iOS will just dismiss the alert controller if it’s tapped.
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem // V2:  is used only on iPad, and tells iOS where it should make the action sheet be anchored.
        present(ac, animated: true)
    }

    func openPage(action: UIAlertAction) { // V2: What the method does is use the title property of the action (apple.com, hackingwithswift.com), put "https://" in front of it, then construct a URL out of it.
        guard let actionTitle = action.title else { return }
        guard let url = URL(string: "https://" + actionTitle) else { return }
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title // V2: All this method does is update our view controller's title property to be the title of the web view.
    }
}

