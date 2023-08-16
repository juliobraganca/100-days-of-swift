//
//  GameViewController.swift
//  Project 29
//
//  Created by Julio Braganca on 30/06/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    var currentGame: GameScene?

    @IBOutlet weak var angleSlider: UISlider!
    @IBOutlet weak var angleLabel: UILabel!
    @IBOutlet weak var velocitySlider: UISlider!
    @IBOutlet weak var velocityLabel: UILabel!
    @IBOutlet weak var launchButton: UIButton!
    @IBOutlet weak var playerNumber: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBOutlet weak var scorePlayer1Label: UILabel!
    @IBOutlet weak var scorePlayer2Label: UILabel!
    
    var player1Score: Int = 0 {
        didSet {
            scorePlayer1Label.text = "Score: \(player1Score)"
        }
    }
    var player2Score: Int = 0 {
        didSet {
            scorePlayer2Label.text = "Score: \(player2Score)"
        }
    }
    
    var gameStopped = false {
        didSet {
            newGameButton.isHidden = !gameStopped
        }
    }
    
    @IBOutlet weak var windPlayer1Label: UILabel!
    @IBOutlet weak var windPlayer2Label: UILabel!
    var wind: Wind!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameStopped = false
        player1Score = 0
        scorePlayer1Label.textColor = .white
        player2Score = 0
        scorePlayer2Label.textColor = .white
        
        angleLabel.textColor = .white
        velocityLabel.textColor = .white
        playerNumber.textColor = .white
        
        wind = Wind.getRandomWind()
        windPlayer1Label.attributedText = wind.getText()
        windPlayer1Label.isHidden = false
        windPlayer1Label.textColor = .white
        windPlayer2Label.isHidden = true
        windPlayer2Label.textColor = .white
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                
                currentGame = scene as? GameScene
                currentGame?.viewController = self
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        angleChanged(self)
        velocityChanged(self)
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    @IBAction func angleChanged(_ sender: Any) {
        angleLabel.text = "Angle: \(Int(angleSlider.value))°"
    }
    
    @IBAction func velocityChanged(_ sender: Any) {
        velocityLabel.text = "Velocity: \(Int(velocitySlider.value))"
    }
    
    @IBAction func launch(_ sender: Any) {
        angleSlider.isHidden = true
        angleLabel.isHidden = true
        
        velocitySlider.isHidden = true
        velocityLabel.isHidden = true
        
        launchButton.isHidden = true
        
        currentGame?.launch(angle: Int(angleSlider.value), velocity: Int(velocitySlider.value))
    }
    
    func activatePlayer(number: Int) {
        if number == 1 {
            playerNumber.text = "<<< PLAYER ONE"
            windPlayer1Label.attributedText = wind.getText()
            windPlayer1Label.isHidden = false
            windPlayer2Label.isHidden = true
        } else {
            playerNumber.text = "PLAYER TWO >>>"
            windPlayer2Label.attributedText = wind.getText()
            windPlayer2Label.isHidden = false
            windPlayer1Label.isHidden = true
        }
        
        hideAttributes(isHidden: false)
    }
    
    func hideAttributes(isHidden: Bool) {
        angleSlider.isHidden = isHidden
        angleLabel.isHidden = isHidden
        velocitySlider.isHidden = isHidden
        velocityLabel.isHidden = isHidden
        launchButton.isHidden = isHidden
    }
    
    func playerScored(player: Int) {
        if player == 1 {
            player1Score += 1
            wind = Wind.getRandomWind()
        } else {
            player2Score += 1
            wind = Wind.getRandomWind()
        }
        
        if player1Score == 3 {
            playerNumber.text = "PLAYER 1 WINS!"
            finishGame()
        } else if player2Score == 3 {
            playerNumber.text = "PLAYER 2 WINS!"
            finishGame()
        }
    }
    
    func finishGame() {
        hideAttributes(isHidden: true)
        gameStopped = true
    }
    
    
    @IBAction func newGameTapped(_ sender: Any) {
        gameStopped = false
        player1Score = 0
        player2Score = 0
        currentGame?.newGame()
    }
}
