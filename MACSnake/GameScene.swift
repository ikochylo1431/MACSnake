//
//  GameScene.swift
//  MACSnake
//
//  Created by Illya Kochylo on 5/17/18.
//  Copyright © 2018 Illya Kochylo. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    fileprivate var snakeCurrentDirection: direction = .right
    fileprivate var snake: [SKSpriteNode] = [.snakeBodyPart, .snakeBodyPart, .snakeBodyPart]
    fileprivate var snakePosition: [CGPoint] = [.zero]
    fileprivate var oldUpdateTime: TimeInterval = 0
    
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        prepareScene()
    }
    
    fileprivate func updatePositionOfSnake() {
        for i in 0..<snakePosition.count {
            if i < snake.count {
                let bodyPart = snake[i]
                bodyPart.position = snakePosition[i]
            } else { snakePosition.removeLast() }
        }
        
    
        
    }
    override func didMove(to view: SKView) {
        let border = SKPhysicsBody(edgeLoopFrom: frame.self)
        self.physicsBody = border
    }
    
}


enum direction: UInt16 {
    case right = 0x7C
    case left = 0x7B
    case up = 0x7E
    case down = 0x7D
}

extension SKSpriteNode {
    static var snakeBodyPart: SKSpriteNode {
        let bodyPart = SKSpriteNode(color: .yellow, size: CGSize(width: 50, height: 50))
        return bodyPart
    }
    
}

extension GameScene {
    func prepareScene() {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let snakeBodyPartContainer = SKNode()
        snakeBodyPartContainer.name = "snakeBodyPartContainer"
        addChild(snakeBodyPartContainer)
        for bodyPart in snake {
            addChild(bodyPart)
        }
    }
}


extension GameScene {
    fileprivate func movement() {
        switch snakeCurrentDirection {
        case .right:
            guard let headPosition = snakePosition.first else { return }
            snakePosition.insert(headPosition.pointToRight, at: 0)
        case .left:
            guard let headPosition = snakePosition.first else { return }
            snakePosition.insert(headPosition.pointToLeft, at: 0)
        case .up:
            guard let headPosition = snakePosition.first else { return }
            snakePosition.insert(headPosition.pointToUp, at: 0)
        case .down:
            guard let headPosition = snakePosition.first else { return }
            snakePosition.insert(headPosition.pointToDown, at: 0)
        }
    }
}

extension CGPoint {
    static var normalizedMiddle: CGPoint { return CGPoint(x: 0.5, y: 0.5)}
    
    func offSetBy(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: x + point.x, y: y + point.y)
    }
    
    var pointToLeft: CGPoint{
        return self.offSetBy(CGPoint(x: -CGSize(width: 50, height: 50).width, y: 0))
    }
    
    var pointToRight: CGPoint{
        return self.offSetBy(CGPoint(x: CGSize(width: 50, height: 50).width, y: 0))
    }
    
    var pointToUp: CGPoint{
        return self.offSetBy(CGPoint(x: 0, y: CGSize(width: 50, height: 50).height))
    }
    
    var pointToDown: CGPoint{
        return self.offSetBy(CGPoint(x: 0, y: -CGSize(width: 50, height: 50).height))
    }
    
}

extension GameScene {
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case direction.down.rawValue:
            snakeCurrentDirection = .down
        case direction.up.rawValue:
            snakeCurrentDirection = .up
        case direction.right.rawValue:
            snakeCurrentDirection = .right
        case direction.left.rawValue:
            snakeCurrentDirection = .left

        default: break
        }
    }
}

extension GameScene {
    override func update(_ currentTime: TimeInterval) {
        let delta: TimeInterval = 0.5
        if currentTime - oldUpdateTime > delta {
            oldUpdateTime = currentTime
            movement()
            killSnakeIfNeed()
            updatePositionOfSnake()
        }
    }
}


extension GameScene {
   fileprivate func killSnakeIfNeed() {
    if snakeReachesScreenBounds || isSnakeRunOverSelf {
        removeSnakeFromTheScreen()
    }
    }
    
    fileprivate func removeSnakeFromTheScreen() {
        guard let snakeBody = childNode(withName: "snakeBodyPartContainer") else { return }
        snakeBody.removeFromParent()
        snake.removeAll()
    }
    
    fileprivate var isSnakeRunOverSelf: Bool {
        for position in snakePosition {
            let filterPosition = snakePosition.filter({(examinedPoint) -> Bool in
                return examinedPoint.x == position.x && examinedPoint.y == position.y
            })
            if filterPosition.count > 1 {
                return true
            }
        }
        return false
    }
    
   

    fileprivate var snakeReachesScreenBounds: Bool {
        guard let positionOfTheHead = snakePosition.first else { return true }
        
        let leftBounds = -size.width / 2
        if positionOfTheHead.x <= leftBounds {
            return true
        }
        let rightBounds = +size.width / 2
        if positionOfTheHead.x >= rightBounds {
            return true
        }
        let upperBounds = +size.height / 2
        if positionOfTheHead.y >= upperBounds {
            return true
        }
        let lowerBounds = -size.width / 2
        if positionOfTheHead.y <= lowerBounds {
            return true
        }
        return false
    }
}















