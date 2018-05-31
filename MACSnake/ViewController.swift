//
//  ViewController.swift
//  MACSnake
//
//  Created by Illya Kochylo on 5/17/18.
//  Copyright © 2018 Illya Kochylo. All rights reserved.
//

import SpriteKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            if let view = self.skView {
                let scene = GameScene(size: CGSize(width: 1600, height: 1600))
                scene.scaleMode = .aspectFit
               view.presentScene(scene)
                view.ignoresSiblingOrder = true
                view.showsFPS = true
                view.showsNodeCount = true
            }
            
        }
}

