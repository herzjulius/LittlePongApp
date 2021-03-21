//
//  StartScene.swift
//  LittlePongApp
//
//  Created by Julius Herz on 20.03.21.
//

import UIKit
import SpriteKit
import AVFoundation
 



class StartScene: SKScene {
    
    let titleLabel = SKLabelNode()
    let startButton = SKSpriteNode (color: UIColor.red, size: CGSize(width: 200, height: 50))
  
    let a = SKAudioNode(fileNamed: "423805__tyops__game-theme-4.wav")

    
    override func didMove(to view: SKView) {
        addChild(a)
        a.run(SKAction.play())
        
    
         

      
        titleLabel.position = CGPoint (x:frame.midX,y: frame.midY+150)
        titleLabel.text = "PONG"
        addChild(titleLabel)
        
        startButton.position = CGPoint(x: frame.midX, y: frame.midY)
        startButton.name = "startButton"
        startButton.texture = SKTexture(imageNamed: "startButton.png")
        addChild(startButton)
        
        
        
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            if nodesArray.first?.name == "startButton"{
                let transition = SKTransition.crossFade(withDuration: 0.5)
                let gameScene = GameScene(size: self.size)
                self.view?.presentScene(gameScene, transition: transition)
            }
        }
    }
    

}
