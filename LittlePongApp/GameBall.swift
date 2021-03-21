//
//  GameBall.swift
//  LittlePongApp
//
//  Created by Julius Herz on 17.03.21.
// changes

import Foundation
import SpriteKit
import GameplayKit


//creates GameBall Class
class GameBall : SKShapeNode{
    override init() {
        super.init()
    }

    convenience init(radius: CGFloat, velo: CGVector, color: UIColor, name: String ) {
        self.init(circleOfRadius: radius)
        self.fillColor = color
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.velocity = velo
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody!.allowsRotation = false
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.friction = 0
        self.physicsBody!.restitution = 1
        self.name = name
     }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        
        
    }


    
}


