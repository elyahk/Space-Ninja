//
//  File.swift
//  Space Ninja
//
//  Created by eldorbek nusratov on 12/14/22.
//

import Foundation
import SpriteKit

struct Names {
    static let leftButton = "left button"
    static let rightButton = "right button"
}

class GameScene2: SKScene {
    let stageCategory: UInt32 = 0x1 << 1
    let enemyCategory: UInt32 = 0x1 << 2
    let kyoCategory: UInt32 = 0x1 << 3
    let shadowCategory: UInt32 = 0x1 << 4

    lazy var leftButton: SKSpriteNode = {
        let node = SKSpriteNode(color: UIColor.green, size: .init(width: 50.0, height: 50.0))
        node.name = Names.leftButton
        node.anchorPoint = .init(x: 0.5, y: 0.5)
        node.position = .init(x: 30, y: 30)
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.isDynamic = false
        node.zPosition = -1

        return node
    }()

    lazy var rightButton: SKSpriteNode = {
        let node = SKSpriteNode(color: UIColor.green, size: .init(width: 50.0, height: 50.0))
        node.name = Names.rightButton
        node.anchorPoint = .init(x: 0.5, y: 0.5)
        node.position = .init(x: 85, y: 30)
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.isDynamic = false
        node.zPosition = -1

        return node
    }()


    lazy var stage: SKSpriteNode = {
        let stage = SKSpriteNode(color: .systemGray, size: .init(width: width, height: 80))
        stage.anchorPoint = .init(x: 0.5, y: 0.5)
        stage.position = .init(x: width / 2, y: stage.size.height/2)
        stage.physicsBody = SKPhysicsBody(rectangleOf: stage.size)
        stage.physicsBody?.affectedByGravity = false
        stage.physicsBody?.isDynamic = false
        stage.physicsBody?.categoryBitMask = PhysicsCategory.ground
        stage.zPosition = -1
        stage.physicsBody?.friction = 0

        return stage
    }()

    lazy var kyo: KYO = {
        return KYO.makeKYO()
    }()

    override func didMove(to view: SKView) {
        configure()
    }

    private func configure() {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -3.0)
        addChild(stage)
        addChild(kyo)
        addChild(leftButton)
        addChild(rightButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)

            if touchedNode.name == Names.leftButton {
                runLeft()
            } else if touchedNode.name == Names.rightButton {
                runRight()
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}


extension GameScene2 {
    func runLeft() {
        kyo.moveLeft()
    }

    func runRight() {
        kyo.moveRight()
    }

    func jump() {
        kyo.jump()
    }

    func attack() {
        kyo.attack()
    }

    func shoot() {
        kyo.shoot()
    }

    func stop() {
        kyo.stop()
    }
}
