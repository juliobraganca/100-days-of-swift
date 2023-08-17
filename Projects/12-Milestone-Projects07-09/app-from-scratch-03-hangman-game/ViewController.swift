//
//  ViewController.swift
//  app-from-scratch-03-hangman-game
//
//  Created by Júlio Bragança on 27/04/23.
//

import UIKit

class ViewController: UIViewController {
    // Constraints
    var layoutConstraints: [NSLayoutConstraint] = []
    
    // basicElements
    var chancesLabel: UILabel!
    var promptLabel: UILabel!
    var restartButton: UIButton!
    
    var chances = 7 {
        didSet {
            chancesLabel.text = "Remaining chances: \(chances)"
        }
    }
    
    // letterButtons
    var letterButtons: [UIButton] = []
    
    // words and Answers
    var words: [String] = []
    var wordToGuess: String?
    var promptArray: [String] = [] {
        didSet {
            promptLabel.text = promptArray.joined()
        }
    }
    

    
    // MARK: Main Methods
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        setupBasicElements()
        buildButtonsView()
        
        NSLayoutConstraint.activate(layoutConstraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWordsFile()
        restartGame()
    }
    
    
    // MARK: Custom Methods
    // Words
    func loadWordsFile() {
        guard let wordsURL = Bundle.main.url(forResource: "words", withExtension: "txt") else {
            fatalError("Could not find words.txt in bundle.")
        }
        
        guard let wordsContents = try? String(contentsOf: wordsURL) else {
            fatalError("Could not get contents of words.txt from bundle.")
        }
        
        words = wordsContents.trimmingCharacters(in: .newlines).components(separatedBy: .newlines)
    }
    
    // basicElements
    func setupBasicElements() {

        chancesLabel = UILabel()
        chancesLabel.translatesAutoresizingMaskIntoConstraints = false
        chancesLabel.textAlignment = .right
        chancesLabel.text = "Remaining chances: \(chances)"
        chancesLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(chancesLabel)

        promptLabel = UILabel()
        promptLabel.translatesAutoresizingMaskIntoConstraints = false
        promptLabel.textAlignment = .center
        promptLabel.font = UIFont.boldSystemFont(ofSize: 40)
        view.addSubview(promptLabel)

        restartButton = UIButton(type: .system)
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        restartButton.setTitle("Reload", for: .normal)
        restartButton.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
        view.addSubview(restartButton)
        
        layoutConstraints += [
            promptLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            promptLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            chancesLabel.bottomAnchor.constraint(equalTo: promptLabel.topAnchor, constant: -40),
            chancesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            restartButton.topAnchor.constraint(equalTo: promptLabel.bottomAnchor, constant: 40),
            restartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
    }
    
    func buildButtonsView() {
        let buttonsView = UIView()
        let buttonSize = 44
        
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
//        buttonsView.backgroundColor = .black
        view.addSubview(buttonsView)
        
        layoutConstraints += [
            buttonsView.heightAnchor.constraint(equalToConstant: CGFloat(buttonSize) * 4),
            buttonsView.widthAnchor.constraint(equalToConstant: CGFloat(buttonSize) * 7),
            buttonsView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ]
        
        let letters = (97...122).map { Character(UnicodeScalar($0)) } // returns an array of 26 chars a-z
        var charIndex = 0
        
        for row in 0..<4 {
            for col in 0..<7 {
                guard charIndex < 26 else { return }
                
                let letterButton = UIButton(type: .system)
                letterButton.setTitle(String(letters[charIndex]), for: .normal)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
                letterButton.tintColor = .label
                
                let frame = CGRect(x: col * 44, y: row * 44, width: 44, height: 44)
                    
                letterButton.frame = frame
                letterButton.layer.borderColor = UIColor.lightGray.cgColor
                letterButton.layer.borderWidth = 1
                letterButton.layer.cornerRadius = 12
                
                letterButton.addTarget(self, action: #selector(letterButtonTapped), for: .touchUpInside)
                
                letterButtons.append(letterButton)
                buttonsView.addSubview(letterButton)
                
                charIndex += 1
            }
        }
        
    }
    
    // selectorMethods
    @objc func restartGame(_ action: UIAlertAction? = nil) {
        wordToGuess = words.randomElement()
        
        promptArray = Array<String>(repeating: "?", count: wordToGuess!.count)
        
        chances = 7
        
        for button in letterButtons {
            button.isHidden = false
        }
    }
    
    @objc func letterButtonTapped(_ sender: UIButton) {
        guard let wordToGuess = wordToGuess else { return }
        guard let senderTitle = sender.currentTitle else { return }
        
        sender.isHidden = true
        
        let charTapped = Character(senderTitle)
        var charFound = false
        
        // Replace any question marks with char...
        for (index, char) in wordToGuess.enumerated() {
            if char == charTapped {
                promptArray[index] = String(char)
                charFound = true
            }
        }
        
        // Char does not exist in the word...
        if !charFound {
            chances -= 1
            
            if chances == 0 {
                showGameOverAlert(title: "Out of chances", message: "The word was \(wordToGuess). Play again?")
            }
        }
        
        if wordToGuess == promptArray.joined() {
            showGameOverAlert(title: "Congrats", message: "You correctly guessed the word. Play again?")
        }
    }
    
    // Alerts
    func showGameOverAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: restartGame))
        
        present(ac, animated: true)
    }
}

