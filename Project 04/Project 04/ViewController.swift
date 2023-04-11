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
    var progressView: UIProgressView! // V3: declaring the property, we will place it inside a bar button item
    var websites = ["apple.com", "hackingwithswift.com", "uol.com.br"] // V4: Refactoring code adding an array of the websites. With that array, we can modify the web view's initial web page so that it's not hard-coded.
    
    override func loadView() {
        webView = WKWebView()  // V1: create a new instance of Apple's WKWebView and assign it to the webView property
        webView.navigationDelegate = self // we're setting the web view's navigationDelegate property to self, which means "when any web page navigation happens, please tell me – the current view controller.”
        view = webView // V1: we make our view (the root view of the view controller) that web view.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped)) // V2: this is to give the user the option to choose from one of our selected websites.
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) // V3: creates a flexible space. It doesn't need a target or action because it can't be tapped. it takes as much room as it can on the left, so the refresh button will be in the right.
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload)) // V3: t's calling the reload() method on the web view rather than using a method of our own.
        
        progressView = UIProgressView(progressViewStyle: .default) // V3: The first line creates a new UIProgressView instance, giving it the default style. There is an alternative style called .bar
        progressView.sizeToFit() // V3: The second line tells the progress view to set its layout size so that it fits its contents fully.
        let progressButton = UIBarButtonItem(customView: progressView) // V3: creates a new UIBarButtonItem using the customView parameter, which is where we wrap up our UIProgressView in a UIBarButtonItem so that it can go into our toolbar.
        
        toolbarItems = [progressButton, spacer, refresh] // V3: creates an array containing the progress button, flexible space and the refresh button, then sets it to be our view controller's toolbarItems array.
        navigationController?.isToolbarHidden = false // V3: The second sets the navigation controller's isToolbarHidden property to be false, so the toolbar will be shown – and its items will be loaded from our current view.
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil) // V3: We're going to use KVO to watch the estimatedProgress property. #keyPath works like #selector
        
        let url = URL(string: "https://" + websites[0])! // V1: Swift stores URLs in a specific URL data type. the URL must be complete. V4: We are using the array so it's not hard coded.
        webView.load(URLRequest(url: url)) // V1: creates a URLRequest object from that URL and gives it to our web view to load. WKWebView don't load websites from strings, or even from URL made out of those strings, you need to put the URL(first line) into an URLRequest.
        webView.allowsBackForwardNavigationGestures = true // V1: enables a property on the web view that allows users to swipe from the left or right edge to move backward or forward in their web browsing. Many users rely on this, so it's good to keep it around.
    }
    
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet) // V2: We're using nil for the message, because this alert doesn't need one. We're using the preferredStyle of .actionSheet because we're prompting the user for more information.
        
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage)) //V4: using a loop to be cleaner the websites we use. it will add one UIAlertAction for each item
        }
        
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
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress) // all we care about is whether the keyPath parameter is set to estimatedProgress.
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void){ // V4: we need to evaluate the URL to see whether it's in our safe list, then call the decisionHandler with a negative or positive answer.
        let url = navigationAction.request.url // V4: we set the constant url to be equal to the URL of the navigation. This is just to make the code clearer.
        
        if let host = url?.host { // V4:unwrap the value of the optional url.host. This line says, "if there is a host for this URL, pull it out" – and by "host" it means "website domain" like apple.com.
            for website in websites { // V4: we loop through all sites in our safe list, placing the name of the site in the website variable.
                if host.contains(website) { // V4: we use the contains() String method to see whether each safe website exists somewhere in the host name.
                    decisionHandler(.allow) //V4: if the website was found then we call the decision handler with a positive response - we want to allow loading.
                    return //V4: if the website was found, after calling the decisionHandler we use the return statement. This means "exit the method now."
                }
            }
        }
        
        decisionHandler(.cancel) // V4: if there is no host set, or if we've gone through all the loop and found nothing, we call the decision handler with a negative response: cancel loading.
    }
}

