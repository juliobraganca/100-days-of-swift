//
//  GameScene.swift
//  Project 26
//
//  Created by Julio Braganca on 20/06/23.
//

import CoreMotion
import SpriteKit

enum CollisionTypes: UInt32 {
    case player = 1
    case wall = 2
    case star = 4
    case vortex = 8
    case finish = 16
    case teleport = 32
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    var isPortalActive = true
    var level = 1
    var player: SKSpriteNode!
    var lastTouchPosition: CGPoint?
    var gameOverLabelBackground: SKSpriteNode!
    var gameOverLabel: SKLabelNode!
    
    
    var motionManager: CMMotionManager?
    var isGameOver = false
    
    var scoreLabel: SKLabelNode!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: 16, y: 36)
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
        
        loadLevel()
        createPlayer()
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        motionManager = CMMotionManager()
        motionManager?.startAccelerometerUpdates()
    }
    
    func loadLevel() {
        guard let levelURL = Bundle.main.url(forResource: "level\(String(level))", withExtension: "txt") else {
            fatalError("Could not find level1.txt in the app bundle.")
        }
        guard let levelString = try? String(contentsOf: levelURL) else {
            fatalError("Could not load level\(String(level)).txt from the app bundle.")
        }
        
        let lines = levelString.components(separatedBy: "\n")
        
        
        
        for (row, line) in lines.reversed().enumerated() {
            for (column, letter) in line.enumerated() {
                let position = CGPoint(x: (64 * column) + 32, y: (64 * row) + 32)
                
                if letter == "x" {
                    loadWall(at: position)
                } else if letter == "v" {
                    loadVortex(at: position)
                } else if letter == "s" {
                    loadStar(at: position)
                } else if letter == "f" {
                    loadFinishPoint(at: position)
                } else if letter == "t" {
                    loadPortal(at: position)
                } else if letter == " " {
                    // do nothing
                } else {
                    fatalError("Unknown level letter: \(letter)")
                }
            }
        }
    }
    
    func loadWall(at position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "block")
        node.name = "block"
        node.position = position
        
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.categoryBitMask = CollisionTypes.wall.rawValue
        node.physicsBody?.isDynamic = false
        
        addChild(node)
    }
    
    func loadVortex(at position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "vortex")
        node.name = "vortex"
        node.position = position
        node.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        node.physicsBody?.isDynamic = false
            
        node.physicsBody?.categoryBitMask = CollisionTypes.vortex.rawValue
        node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        node.physicsBody?.collisionBitMask = 0
        
        addChild(node)
    }
    
    func loadStar(at position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "star")
        node.name = "star"
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        node.physicsBody?.isDynamic = false
        
        node.physicsBody?.categoryBitMask = CollisionTypes.star.rawValue
        node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        node.physicsBody?.collisionBitMask = 0
        node.position = position
        addChild(node)
    }
    
    func loadFinishPoint(at position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "finish")
        node.name = "finish"
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        node.physicsBody?.isDynamic = false
        
        node.physicsBody?.categoryBitMask = CollisionTypes.finish.rawValue
        node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        node.physicsBody?.collisionBitMask = 0
        node.position = position
        addChild(node)
    }
    
    func loadPortal(at position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "whackHole")
        node.name = "portal"
        node.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
        node.size = CGSize(width: 50, height: 50)
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        node.physicsBody?.isDynamic = false
        
        node.physicsBody?.categoryBitMask = CollisionTypes.teleport.rawValue
        node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        node.physicsBody?.collisionBitMask = 0
        node.position = position
        addChild(node)
    }
    
    func createPlayer() {
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 96, y: 672)
        player.zPosition = 1
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.linearDamping = 0.5
        
        player.physicsBody?.categoryBitMask = CollisionTypes.player.rawValue
        player.physicsBody?.contactTestBitMask = CollisionTypes.star.rawValue | CollisionTypes.vortex.rawValue | CollisionTypes.finish.rawValue
        player.physicsBody?.collisionBitMask = CollisionTypes.wall.rawValue
        addChild(player)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchPosition = nil
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard isGameOver == false else { return }
        
        #if targetEnvironment(simulator)
        if let lastTouchPosition = lastTouchPosition {
            let diff = CGPoint(x: lastTouchPosition.x - player.position.x, y: lastTouchPosition.y - player.position.y)
            physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
        }
        #else
        if let accelerometerData = motionManager?.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
        }
        #endif
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA == player {
            playerCollided(with: nodeB)
        } else if nodeB == player {
            playerCollided(with: nodeA)
        }
    }
    
    func playerCollided(with node: SKNode) {
        if node.name == "vortex" {
            player.physicsBody?.isDynamic = false
            isGameOver = true
            score -= 1
            
            let move = SKAction.move(to: node.position, duration: 0.25)
            let scale = SKAction.scale(to: 0.0001, duration: 0.25)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([move, scale, remove])
            
            player.run(sequence) { [weak self] in
                self?.createPlayer()
                self?.isGameOver = false
            }
        } else if node.name == "star" {
            node.removeFromParent()
            score += 1
        } else if node.name == "finish" {
            if level < 2 {
                destroyLevel()
                level += 1
                createPlayer()
                loadLevel()
            } else {
                gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
                gameOverLabel.text = "GAME OVER! Your final score is \(score)!"
                gameOverLabel.fontColor = .black
                gameOverLabel.position = CGPoint(x: 512, y: 384)
                gameOverLabel.horizontalAlignmentMode = .center
                gameOverLabel.zPosition = 4
                addChild(gameOverLabel)
                
                gameOverLabelBackground = SKSpriteNode()
                gameOverLabelBackground.position = gameOverLabel.position
                gameOverLabelBackground.size = CGSize(width: gameOverLabel.frame.width + 20, height: gameOverLabel.frame.height + 40)
                gameOverLabelBackground.color = UIColor(cgColor: CGColor(red: 255, green: 255, blue: 255, alpha: 0.75))
                gameOverLabelBackground.zPosition = 3
                addChild(gameOverLabelBackground)
                
                player.removeFromParent()
            }
        } else if node.name == "portal" && isPortalActive {
            for currentNode in children {
                if currentNode.name == "portal" && currentNode != node {
                    enterPortalAction(portalIn: node, portalOut: currentNode)
                    break
                }
            }
        }
    }
    
    func enterPortalAction(portalIn: SKNode, portalOut: SKNode) {
        
        // stop the ball
        player.physicsBody?.isDynamic = false
        
        let rotate = SKAction.rotate(byAngle: -.pi, duration: 0.1)
        let rotateSequence = SKAction.sequence([rotate, rotate, rotate, rotate, rotate])
        player.run(rotateSequence)
        
        let move = SKAction.move(to: portalIn.position, duration: 0.25)
        let fade = SKAction.fadeOut(withDuration: 0.25)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([move, fade, remove])
        
        // player to new node
        player.run(sequence) { [weak self, weak portalOut] in
            if let portalOut = portalOut {
                self?.exitPortalAction(portalOut: portalOut)
            }
        }
    }
    
    // challenge 3
    func exitPortalAction(portalOut: SKNode) {
        createPlayer()
        player.alpha = 0.0
        player.position = portalOut.position

        let rotate = SKAction.rotate(byAngle: -.pi, duration: 0.05)
        let rotateSequence = SKAction.sequence([rotate, rotate, rotate, rotate, rotate])
        player.run(rotateSequence)

        player.run(SKAction.fadeIn(withDuration: 0.25))
        
        // deactivate portal until player quits it
        isPortalActive = false
    }
    
    func destroyLevel() {
        for node in children {
            if ["block", "vortex", "star", "finish", "portal"].contains(node.name) {
                node.removeFromParent()
            }
        }
        player.removeFromParent()
    }
}
