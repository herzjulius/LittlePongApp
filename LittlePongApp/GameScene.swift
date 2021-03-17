//
//  GameScene.swift
//  LittlePongApp
//
//  Created by Julius Herz on 16.03.21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    //categories for BitMasks
    let gameBallCategory: UInt32 = 1
    let racketCategory : UInt32 = 2
    var score = 0
    var level = 1
    let ball = GameBall(radius: 15,velo: CGVector(dx:200, dy:-200), color: UIColor.red, name: "Ball")
   
    let gameBall = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 30, height: 30))
    let racket = SKSpriteNode (color: UIColor.red, size: CGSize(width: 100, height: 20))
    let scoreLabel = SKLabelNode ()
    let levelLabel = SKLabelNode()
    
    

    
    override func didMove (to view: SKView) {
        ball.position = CGPoint(x: frame.midX + 50 , y: frame.midY)
        addChild(ball)
        //our scene takes care of the contact between nodes
        physicsWorld.contactDelegate = self
        
        
        
        //set the gameBall
        gameBall.position = CGPoint(x: frame.midX, y: frame.midY)
        gameBall.name = "GameBall"
        addChild(gameBall)
        
        
        
        
        //set the racket
        racket.position = CGPoint(x: frame.midX, y: frame.maxY/100)
        racket.name = "Racket"
        addChild(racket)
        
        
        
        
        //set the scoreLabel
        scoreLabel.position = CGPoint(x: frame.maxX*0.9, y: frame.maxY*0.9)
        scoreLabel.text = "Score: 0"
        scoreLabel.fontSize = 12
        addChild(scoreLabel)
        
        //set the lvelLabel
        levelLabel.position = CGPoint(x: frame.minX + 50, y: frame.maxY * 0.9)
        levelLabel.text = "Level: 1"
        levelLabel.fontSize = 12
        addChild(levelLabel)
        
    
        
        
        
        gameBall.physicsBody = SKPhysicsBody(circleOfRadius: gameBall.size.width/2)
        
        
        //default gravity vector
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        
        //after every collision the ball gets additional kinetic energy
        gameBall.physicsBody!.restitution = 1
        
        // the ball is not affect by gravity
        gameBall.physicsBody!.affectedByGravity = false
        
        //the edgdes of the view are walls
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        
        //set the racket as a physics body
        racket.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: racket.size.width, height: racket.size.height))
        racket.physicsBody!.isDynamic = false
        
        
        //no damping and friction
        //no rotation
        gameBall.physicsBody!.allowsRotation = false
        gameBall.physicsBody?.linearDamping = 0
        gameBall.physicsBody?.friction = 0
        
        
        
        //inital velocity of the game ball
        gameBall.physicsBody?.velocity = CGVector(dx:200, dy:-200)
        
        //Bitmasks
        racket.physicsBody?.categoryBitMask = racketCategory
        gameBall.physicsBody?.categoryBitMask = gameBallCategory
        //gameBall.physicsBody?.collisionBitMask = racketCategory
        racket.physicsBody?.contactTestBitMask = gameBallCategory
        


    }
    
    //wenn a collision happened this function is called it gets a contact-Object, then i check if the colliding objects match the bitmasks
    func didBegin(_ contact: SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == racketCategory | gameBallCategory{
            score = score + 1
            let tmpString = String(score)
            scoreLabel.text = "Score: " + tmpString
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let loc = touch.location(in: self)
            //the racket cant move outside the frame
            if (loc.y < frame.maxY/8 && loc.y > frame.minY){
                racket.position.x = loc.x
                racket.position.y = loc.y
            }else{
                racket.position.x = loc.x
            }
        }
        
    }
    
    func increaseVelocity(scale: CGFloat) {
      //  gameBall.physicsBody?.velocity = CGVector(dx: gameBall.physicsBody?.velocity.dx ?? 0 * scale, dy: gameBall.physicsBody?.velocity.dy ?? 0 * scale)
        
        gameBall.physicsBody?.velocity.dx = (gameBall.physicsBody?.velocity.dx)! * scale
        gameBall.physicsBody?.velocity.dy = (gameBall.physicsBody?.velocity.dy)! * scale
        
    }
    // not the best way, cause it checks after every frame
    override func update(_ currentTime: TimeInterval) {
        if score >= level * 10{
            level = level + 1
            let tmpString = String(level)
            levelLabel.text = "Level: " + tmpString
            increaseVelocity(scale: 1.3)
            
            
            
        }
    
    }
    override func didSimulatePhysics() {
        
    }
    
}
   
