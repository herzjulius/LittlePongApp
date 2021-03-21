//
//  GameViewController.swift
//  LittlePongApp
//
//  Created by Julius Herz on 16.03.21.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        let scene = StartScene(size: view.bounds.size)
            
            // Get the SKScene from the loaded GKScene
         
                
                // Copy gameplay related content over to the scene
             
                
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(scene)
                    view.ignoresSiblingOrder = true
                    view.showsFPS = true
                    view.showsNodeCount = true
                    view.showsPhysics = true;
                }
            }
        }
    



