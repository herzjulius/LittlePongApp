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
    var ballIsCreated = true
    let startingVelo = CGVector(dx: -200,dy: 200)
    
    //create an array of GameBalls
    var listOfBalls = [GameBall]()
    
    let racket = SKSpriteNode (color: UIColor.red, size: CGSize(width: 100, height: 20))
    let scoreLabel = SKLabelNode ()
    let levelLabel = SKLabelNode()
    
    

    
    override func didMove (to view: SKView) {
        
        
        
        //our scene takes care of the contact between nodes
        physicsWorld.contactDelegate = self
        
        addBalltoList()

        
        
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
        

        
        //the edgdes of the view are walls
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        
        //set the racket as a physics body
        racket.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: racket.size.width, height: racket.size.height))
        racket.physicsBody!.isDynamic = false
        
    
    
        //Bitmasks to detect the collisions
        racket.physicsBody?.categoryBitMask = racketCategory
        racket.physicsBody?.contactTestBitMask = gameBallCategory
   
        


    }
    
    func addBalltoList(){
        let firstBall = GameBall(radius: 15, velo: startingVelo, color: UIColor.red, name: "Ball1")
        firstBall.position = CGPoint(x: frame.midX, y: frame.midY)
        listOfBalls.append(firstBall)
        firstBall.physicsBody?.categoryBitMask = gameBallCategory
        addChild(firstBall)
        
    }
    
    //wenn a collision happened this function is called it gets a contact-Object, then i check if the colliding objects match the bitmasks
    func didBegin(_ contact: SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == racketCategory | gameBallCategory{
            score = score + 1
            let tmpString = String(score)
            scoreLabel.text = "Score: " + tmpString
        }
        
        //checks if the player reacches a new stage
        if score >= level * 10 {
            level = level + 1
            let tmpString = String(level)
            levelLabel.text = "Level: " + tmpString
            //TODO: increase velocity
            addBalltoList()
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
    
    func increaseVelocity(scale: CGFloat, velo: CGVector) -> CGVector {
        let dx = velo.dx * scale
        let dy = velo.dy * scale
        return CGVector(dx: dx, dy: dy)
    }
    // not the best way, cause it checks after every frame
    override func update(_ currentTime: TimeInterval) {

    
    }
    override func didSimulatePhysics() {
        
    }
    
}
   
