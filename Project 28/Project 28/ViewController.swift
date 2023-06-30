//
//  ViewController.swift
//  Project 28
//
//  Created by Julio Braganca on 28/06/23.
//

import LocalAuthentication
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var secret: UITextView!
    let passwordDefault = "password"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButton))
        navigationItem.rightBarButtonItem?.isHidden = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Password", style: .plain, target: self, action: #selector(setPassword))
        navigationItem.leftBarButtonItem?.isHidden = true
        
        title = "Nothing to see here"
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    
    @IBAction func authenticateTapped(_ sender: Any) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self?.unlockSecretMessage()
                    } else {
                        self?.usePasswordAuthentication()
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication. Please set a password.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { action in
                self.setPassword()
            }
            ac.addAction(action)
            
            present(ac, animated: true)

        }
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEnd = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEnd, to: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            secret.contentInset = .zero
        } else {
            secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        secret.scrollIndicatorInsets = secret.contentInset
        
        let selectedRange = secret.selectedRange
        secret.scrollRangeToVisible(selectedRange)
    }
    
    func unlockSecretMessage() {
        secret.isHidden = false
        navigationItem.rightBarButtonItem?.isHidden = false
        navigationItem.leftBarButtonItem?.isHidden = false
        title = "Secret stuff!"
        
        secret.text = KeychainWrapper.standard.string(forKey: "SecretMessage") ?? ""
    }
    
    @objc func saveSecretMessage() {
        guard secret.isHidden == false else { return }
        
        KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
        secret.resignFirstResponder()
        secret.isHidden = true
        navigationItem.rightBarButtonItem?.isHidden = true
        navigationItem.leftBarButtonItem?.isHidden = true
        title = "Nothing to see here"
    }
    
    @objc func doneButton() {
        saveSecretMessage()
    }
    
    @objc func setPassword() {
        let ac = UIAlertController(title: "Set password", message: "Password can be used to authenticate", preferredStyle: .alert)
        
        ac.addTextField { textField in
            textField.isSecureTextEntry = true
            textField.placeholder = "Password"
        }
        
        ac.addTextField { textField in
            textField.isSecureTextEntry = true
            textField.placeholder = "Confirm password"
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] action in
            guard let password = self?.checkSetPasswordFields(ac: ac) else { return }
            
            if let passwordDefault = self?.passwordDefault {
                KeychainWrapper.standard.set(password, forKey: passwordDefault)
            }
        })
        
        present(ac, animated: true)
    }
    
    func setPasswordError(title: String) {
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Retry", style: .default) { action in
            self.setPassword()
        })
        
        present(ac, animated: true)
    }
    
    func checkSetPasswordFields(ac: UIAlertController?) -> String? {
        guard let password1 = getField(ac: ac, field: 0) else {
            setPasswordError(title: "Missing password")
            return nil
        }
        
        guard let password2 = getField(ac: ac, field: 1) else {
            setPasswordError(title: "Missing password confirmation")
            return nil
        }
        
        guard password1 == password2 else {
            setPasswordError(title: "Passwords don't match")
            return nil
        }
        
        return password1
    }
    
    // challenge 2
    func getField(ac: UIAlertController?, field: Int) -> String? {
        guard let text = ac?.textFields?[field].text else {
            return nil
        }
        
        guard !text.isEmpty else {
            return nil
        }
        
        return text
    }
    
    func usePasswordAuthentication() {
        let ac = UIAlertController(title: "Password authentication", message: nil, preferredStyle: .alert)
        
        ac.addTextField { textField in
            textField.isSecureTextEntry = true
            textField.placeholder = "Password"
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] action in
            guard let password = self?.getField(ac: ac, field: 0) else { return }
            
            if let passwordDefault = self?.passwordDefault {
                if let storedPassword = KeychainWrapper.standard.string(forKey: passwordDefault) {
                    if password == storedPassword {
                        self?.unlockSecretMessage()
                        return
                    }
                }
            }
            
            let ac = UIAlertController(title: "Authentication failed", message: "Your password is incorrect. Please try again!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(ac, animated: true)
            
        })
        
        present(ac, animated: true)
    }
}

