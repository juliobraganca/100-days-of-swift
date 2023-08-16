//
//  ViewController.swift
//  Project 05
//
//  Created by Júlio Bragança on 13/04/23.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()
    var lastLoadedWord: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Restart Game", style: .plain, target: self, action: #selector(restartGame))
        
        loadWords()
        loadUserDefaults()
    }
    
    private func loadWords() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
    }
    
    private func loadUserDefaults() {
        let defaults = UserDefaults.standard
        
        if let lastLoadedWord = defaults.value(forKey: "lastLoadedWord") as? String {
            self.lastLoadedWord = lastLoadedWord
            title = lastLoadedWord
        } else {
            startGame()
        }
        
        if let usedWords = defaults.object(forKey: "usedWords") as? [String] {
            self.usedWords = usedWords
            tableView.reloadData()
        } else {
            startGame()
        }
    }
    
    func startGame() {
        lastLoadedWord = allWords.randomElement() ?? "viewing"
        title = lastLoadedWord
        UserDefaults.standard.set(lastLoadedWord, forKey: "lastLoadedWord")
        usedWords.removeAll(keepingCapacity: true)
        UserDefaults.standard.set(usedWords, forKey: "usedWords")
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        
        let lowerAnswer = answer.lowercased()
        var errorTitle: String?
        var errorMessage: String?
        
        if  isPossible(word: lowerAnswer) == true &&
                isOriginal(word: lowerAnswer) == true &&
                isReal(word: lowerAnswer) == true &&
                isLongEnough(word: lowerAnswer) == true{
            usedWords.insert(answer.lowercased(), at: 0)
            UserDefaults.standard.set(usedWords, forKey: "usedWords")
            
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
            return
        } else {
            showErrorMessage()
        }
        
        func showErrorMessage() {
            if isPossible(word: lowerAnswer) == false {
                errorTitle = "Word not possible"
                errorMessage = "You can't spell that word from \(title!.lowercased())."
            } else if isOriginal(word: lowerAnswer) == false{
                errorTitle = "Word already used"
                errorMessage = "Be more original!"
            } else if isReal(word: lowerAnswer) == false {
                errorTitle = "Word not valid"
                errorMessage = "You can't just make them up or use the same word, you know!"
            } else if isLongEnough(word: lowerAnswer) == false {
                errorTitle = "Word is too short"
                errorMessage = "You can't type a word shorter than three letters."
            }
        }
        
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        if word.lowercased() != title?.lowercased() {
            let checker = UITextChecker()
            let range = NSRange(location: 0, length: word.utf16.count)
            let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
            return misspelledRange.location == NSNotFound
        } else {
            return false
        }
    }
    
    func isLongEnough(word: String) -> Bool {
        if word.utf16.count > 2 {
            return true
        } else {
            return false
        }
    }
    
    @objc func restartGame() {
        startGame()
        
        let ac = UIAlertController(title: "Game restarting", message: "Random new world", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
