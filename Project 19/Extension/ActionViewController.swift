//
//  ActionViewController.swift
//  Extension
//
//  Created by Julio Braganca on 25/05/23.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class ActionViewController: UIViewController {
    @IBOutlet weak var script: UITextView!
    
    var pageTitle = ""
    var pageURL = ""
    var savedScriptsForURL: [String:String] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Load Scripts", style: .plain, target: self, action: #selector(scripts))
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] (dict, error) in
                    guard let itemDictionary = dict as? NSDictionary else { return }
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
                    
                    self?.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self?.pageURL = javaScriptValues["URL"] as? String ?? ""
                    
                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                        self?.loadUserDefaults()
                    }
                }
            }
        }
    }
    
    
    
    @IBAction func done() {
        DispatchQueue.global(qos: .background).async {
            self.save()
        }
        
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": script.text]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        extensionContext?.completeRequest(returningItems: [item])
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            script.contentInset = .zero
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        script.scrollIndicatorInsets = script.contentInset
        
        let selectedRange = script.selectedRange
        script.scrollRangeToVisible(selectedRange)
    }
    
    @objc func scripts() {
        let ac = UIAlertController(title: "Select the script", message: nil, preferredStyle: .actionSheet)
        
        
        let title = UIAlertAction(title: "Site name", style: .default) { action in
            self.script.text = "alert(document.title);"
        }
        
        let url = UIAlertAction(title: "Site URL", style: .default) { action in
            self.script.text = "alert(document.URL);"
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(title)
        ac.addAction(url)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
    
    func save() {
        if let url = URL(string: pageURL) {
            if let host = url.host {
                savedScriptsForURL.updateValue(script.text, forKey: host)
            }
        }
        
        UserDefaults.standard.set(savedScriptsForURL, forKey: "SavedScriptsForURL")
    }
    
    func loadUserDefaults() {
        savedScriptsForURL = UserDefaults.standard.dictionary(forKey: "SavedScriptsForURL") as? [String:String] ?? [:]
        
        if let url = URL(string: pageURL) {
            if let host = url.host {
                script.text = savedScriptsForURL[host]
            }
        }
    }
    
}
