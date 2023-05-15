//
//  ViewController.swift
//  Project 02
//
//  Created by Júlio Bragança on 05/04/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var highestScore = 0
    var correctAnswer = 0
    var incorrectAnswer1 = 0
    var incorrectAnswer2 = 0
    var questionsAsked = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserDefaults()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(scoreTapped))

        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0) //to make the border be with the same size of the flags.
        button2.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button3.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        if correctAnswer == 0{
            incorrectAnswer1 = 1
            incorrectAnswer2 = 2
        } else if correctAnswer == 1{
            incorrectAnswer1 = 0
            incorrectAnswer2 = 2
        } else {
            incorrectAnswer1 = 0
            incorrectAnswer2 = 1
        }
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseOut) {
            self.button1.transform = .identity
            self.button2.transform = .identity
            self.button3.transform = .identity
        }

        
// title = countries[correctAnswer].uppercased() // Code from the class. I preferred to try something different.
        
        switch countries[correctAnswer]{ //Included this code to only US and UK to be uppercased
        case "us", "uk":
            title = "Question \(questionsAsked) - " + countries[correctAnswer].uppercased()// + " - Score (\(score))"
        default:
            title = "Question \(questionsAsked) - " + countries[correctAnswer].capitalized// + " - Score (\(score))"
        }
        
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var title: String
        var alertMessage: String
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options: .curveLinear) {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
        
        if questionsAsked == 11{
            alertMessage = ""
        } else{
            alertMessage = "Your score is \(score)"
        }
        
        if sender.tag == correctAnswer{
            title = "Correct!"
            scoreCorrect()
            if questionsAsked >= 11 && score <= highestScore{
                title = "Correct! The game has finished. Your final score is \(score)"
                resetGame()
            } else if questionsAsked >= 11 && score > highestScore {
                title = "Correct! The game has finished. Your final score is \(score). You have a new record!! \(score) points!"
                resetGameNewScore()
            }
            
        } else if sender.tag == incorrectAnswer1, countries[incorrectAnswer1] == "us" || countries[incorrectAnswer1] == "uk"{
            title = "Wrong. This flag is from the \(countries[incorrectAnswer1].uppercased())!"
            scoreIncorrect()
            if questionsAsked >= 11 && score <= highestScore{
                title = "Wrong. This flag is from the \(countries[incorrectAnswer1].uppercased())! The game has finished. Your final score is \(score)"
                resetGame()
            } else if questionsAsked >= 11 && score > highestScore {
                title = "Wrong. This flag is from the \(countries[incorrectAnswer1].uppercased())! The game has finished. Your final score is \(score). You have a new record!! \(score) points!"
                resetGameNewScore()
            }
            
        }  else if sender.tag == incorrectAnswer1{
            title = "Wrong. This flag is from \(countries[incorrectAnswer1].capitalized)!"
            scoreIncorrect()
            if questionsAsked >= 11 && score <= highestScore{
                title = "Wrong. This flag is from \(countries[incorrectAnswer1].capitalized)! The game has finished. Your final score is \(score)"
                resetGame()
            } else if questionsAsked >= 11 && score > highestScore {
                title = "Wrong. This flag is from \(countries[incorrectAnswer1].capitalized)! The game has finished. Your final score is \(score). You have a new record!! \(score) points!"
                resetGameNewScore()
            }
            
        } else if sender.tag == incorrectAnswer2, countries[incorrectAnswer2] == "us" || countries[incorrectAnswer2] == "uk"{
            title = "Wrong. This flag is from the \(countries[incorrectAnswer2].uppercased())!"
            scoreIncorrect()
            if questionsAsked >= 11 && score <= highestScore{
                title = "Wrong. This flag is from the \(countries[incorrectAnswer2].uppercased())! The game has finished. Your final score is \(score)"
                resetGame()
            } else if questionsAsked >= 11 && score > highestScore {
                title = "Wrong. This flag is from the \(countries[incorrectAnswer2].uppercased())! The game has finished. Your final score is \(score). You have a new record!! \(score) points!"
                resetGameNewScore()
            }
            
        }  else {
            title = "Wrong. This flag is from \(countries[incorrectAnswer2].capitalized)!"
            scoreIncorrect()
            if questionsAsked >= 11 && score <= highestScore {
                title = "Wrong. This flag is from \(countries[incorrectAnswer2].capitalized)! The game has finished. Your final score is \(score)"
                resetGame()
            } else if questionsAsked >= 11 && score > highestScore {
                title = "Wrong. This flag is from \(countries[incorrectAnswer2].capitalized)! The game has finished. Your final score is \(score). You have a new record!! \(score) points!"
                resetGameNewScore()
            }
        }
        
        if questionsAsked == 1{
            alertMessage = ""
        } else{
            alertMessage = "Your score is \(score)"
        }
        
        func resetGame(){
            score = 0
            questionsAsked = 1
        }
        
        func resetGameNewScore(){
            highestScore = score
            save()
            resetGame()
        }
        
        func scoreCorrect(){
            score += 1
            questionsAsked += 1
        }
        
        func scoreIncorrect(){
            score -= 1
            questionsAsked += 1
        }
        
        
        let ac = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
    @objc func scoreTapped() {
        let message = "your score is \(score). Your record is \(highestScore)"
        
        let vc = UIAlertController(title: "Score",
                                   message: message,
                                   preferredStyle: .alert)
        
        vc.addAction(UIAlertAction(title: "Continue",
                                   style: .default,
                                   handler: nil))
        
        present(vc, animated: true)
    }
    
    func resetGame() {
        highestScore = score
        save()
        score = 0
        questionsAsked = 1
    }
    
    func save() {
        let defaults = UserDefaults.standard

        defaults.set(highestScore, forKey: "highestScore")
        
//        defaults.removeObject(forKey: "highestScore")
    }

    private func loadUserDefaults() {
        let defaults = UserDefaults.standard

        if let highestScore = defaults.object(forKey: "highestScore") as? Int {
            self.highestScore = highestScore
        }
    }
}

