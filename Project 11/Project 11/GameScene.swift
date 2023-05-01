//
//  GameScene.swift
//  Project 11
//
//  Created by Júlio Bragança on 01/05/23.
//

import SpriteKit
// https://www.hackingwithswift.com/100/45

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384) // Note: SpriteKit considers Y:0 to be the bottom of the screen whereas UIKit considers it to be the top – hurray for uniformity!
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        for i in 0..<5 {
            let x = i * 256
            makeBouncer(at: CGPoint(x: x, y: 0))
        }
//        makeBouncer(at: CGPoint(x: 0, y: 0))
//        makeBouncer(at: CGPoint(x: 256, y: 0))
//        makeBouncer(at: CGPoint(x: 512, y: 0))
//        makeBouncer(at: CGPoint(x: 768, y: 0))
//        makeBouncer(at: CGPoint(x: 1024, y: 0))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { // This method gets called (in UIKit and SpriteKit) whenever someone starts touching their device.
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        let ball = SKSpriteNode(imageNamed: "ballRed")
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.restitution = 0.4
        ball.position = location
        addChild(ball)
    }
    
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }
}
