//
//  ViewController.swift
//  MACSnake
//
//  Created by Illya Kochylo on 5/17/18.
//  Copyright © 2018 Illya Kochylo. All rights reserved.
//

import SpriteKit

class ViewController: NSViewController {

        override func viewDidLoad() {
            super.viewDidLoad()
            if let scene = GameScene(fileNamed: "GameScene") {
                let skView = self.view as! SKView
                skView.showsFPS = true
                skView.showsNodeCount = true
                skView.ignoresSiblingOrder = true
                scene.scaleMode = .aspectFill
                skView.presentScene(scene)
                
            }
            
        }
}

