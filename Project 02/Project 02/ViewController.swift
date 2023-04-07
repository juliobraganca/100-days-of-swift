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
    var correctAnswer = 0
    var questionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
// title = countries[correctAnswer].uppercased() // Code from the class. I preferred to try something different.
        
        switch countries[correctAnswer]{ //Included this code to only US and UK to be uppercased
        case "us", "uk":
            title = "Question \(questionsAsked) - " + countries[correctAnswer].uppercased() + " - Score (\(score))"
        default:
            title = "Question \(questionsAsked) - " + countries[correctAnswer].capitalized + " - Score (\(score))"
        }
        
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var title: String
        var alertMessage: String
        
        if questionsAsked == 11{
            alertMessage = ""
        } else{
            alertMessage = "Your score is \(score)"
        }
        
        if sender.tag == correctAnswer{
            title = "Correct"
            score += 1
            questionsAsked += 1
            if questionsAsked >= 11 {
                title = "Correct! The game has finished. Your final score is \(score)"
                score = 0
                questionsAsked = 0
            }
        } else if countries[correctAnswer] == "us"{
            title = "Wrong. This flag is from the \(countries[correctAnswer].uppercased())!"
            score -= 1
            questionsAsked += 1
            if questionsAsked >= 11 {
                title = "Wrong. This flag is from the \(countries[correctAnswer].uppercased())! The game has finished. Your final score is \(score)"
                score = 0
                questionsAsked = 0
            }
        } else if countries[correctAnswer] == "uk"{
            title = "Wrong. This flag is from the \(countries[correctAnswer].uppercased())!"
            score -= 1
            questionsAsked += 1
            if questionsAsked >= 11 {
                title = "Wrong. This flag is from the \(countries[correctAnswer].uppercased())! The game has finished. Your final score is \(score)"
                score = 0
                questionsAsked = 0
            }
        } else {
            title = "Wrong. This flag is from \(countries[correctAnswer].capitalized)!"
            score -= 1
            questionsAsked += 1
            if questionsAsked >= 11 {
                title = "Wrong. This flag is from \(countries[correctAnswer].capitalized)! The game has finished. Your final score is \(score)"
                score = 0
                questionsAsked = 0
            }
        }
        
        if score == 0{
            alertMessage = ""
        } else{
            alertMessage = "Your score is \(score)"
        }
        
        let ac = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
    }
}

