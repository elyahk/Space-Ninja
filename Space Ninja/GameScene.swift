//
//  File.swift
//  Space Ninja
//
//  Created by eldorbek nusratov on 12/14/22.
//

import Foundation
import SpriteKit

struct Names {
    static let leftButton = "left"
    static let rightButton = "right"
    static let jumpButton = "jump"
    static let attackButton = "attack"
    static let shootButton = "shoot"
    static let shuriken = "shuriken"
    static let kyo = "kyo"
    static let shadow = "shadow"
}

class GameScene: SKScene {
    let emptySpace = 30
    let bHeight = 40

    let stageCategory: UInt32 = 0x1 << 1
    let enemyCategory: UInt32 = 0x1 << 2
    let kyoCategory: UInt32 = 0x1 << 3
    let shadowCategory: UInt32 = 0x1 << 4
    var shurikens: [SKSpriteNode] = []

    lazy var leftButton: SKSpriteNode = {
        let node = SKSpriteNode(color: UIColor.green, size: .init(width: bHeight, height: bHeight))
        node.name = Names.leftButton
        node.position = .init(x: emptySpace + bHeight, y: bHeight)
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.isDynamic = false
        node.zPosition = -1

        return node
    }()

    lazy var rightButton: SKSpriteNode = {
        let node = SKSpriteNode(color: UIColor.green, size: .init(width: bHeight, height: bHeight))
        node.name = Names.rightButton
        node.position = .init(x: emptySpace + bHeight * 2 + 10, y: bHeight)
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.isDynamic = false
        node.zPosition = -1

        return node
    }()

    lazy var attackButton: SKSpriteNode = {
        let node = SKSpriteNode(color: UIColor.green, size: .init(width: bHeight, height: bHeight))
        node.name = Names.attackButton
        node.position = .init(x: Int(width) - emptySpace - bHeight, y: bHeight)
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.isDynamic = false
        node.zPosition = -1

        return node
    }()

    lazy var jumpButton: SKSpriteNode = {
        let node = SKSpriteNode(color: UIColor.green, size: .init(width: self.bHeight, height: self.bHeight))
        node.name = Names.jumpButton
        node.position = .init(x: Int(attackButton.position.x) - 20 - bHeight, y: bHeight)
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.isDynamic = false
        node.zPosition = -1

        return node
    }()

    lazy var shootButton: SKSpriteNode = {
        let node = SKSpriteNode(color: UIColor.green, size: .init(width: bHeight, height: bHeight))
        node.name = Names.shootButton
        node.position = .init(x: Int(jumpButton.position.x) - 20 - bHeight, y: bHeight)
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
        physicsWorld.contactDelegate = self
        addChild(stage)
        addChild(kyo)
        addChild(leftButton)
        addChild(rightButton)
        addChild(jumpButton)
        addChild(shootButton)
        addChild(attackButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)

            let name = touchedNode.name

            if name == Names.leftButton {
                runLeft()
            } else if touchedNode.name == Names.rightButton {
                runRight()
            } else if name == Names.jumpButton {
                jump()
            } else if name == Names.shootButton {
                shoot()
            } else if name == Names.attackButton {
                attack()
            } else if name == Names.attackButton {

            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)

            if touchedNode.name == Names.leftButton || touchedNode.name == Names.rightButton {
                stop()
            }
        }
    }
}


extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let aName = contact.bodyA.node?.name
        let bName = contact.bodyB.node?.name


    }
}

extension GameScene {
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
        shootShuriken()
    }

    func shootShuriken() {
        let shuriken = SKSpriteNode(imageNamed: "shuriken_01")
        shuriken.size = CGSize(width: 30.0, height: 30.0)
        shuriken.position = CGPoint(x: kyo.position.x + 20, y: kyo.position.y)
        shuriken.physicsBody = SKPhysicsBody(rectangleOf: shuriken.size)
        shuriken.physicsBody?.affectedByGravity = false
        shuriken.physicsBody?.isDynamic = true
        shuriken.physicsBody?.categoryBitMask = PhysicsCategory.shuriken
        shurikens.append(shuriken)

        addChild(shuriken)

        shuriken.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 0))
    }

    func stop() {
        kyo.stop()
    }
}
