//
//  File.swift
//  Space Ninja
//
//  Created by eldorbek nusratov on 12/14/22.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    let stageCategory: UInt32 = 0x1 << 1
    let enemyCategory: UInt32 = 0x1 << 2
    let kyoCategory: UInt32 = 0x1 << 3
    let shadowCategory: UInt32 = 0x1 << 4
    var shurikens: [SKSpriteNode] = []
    var console: Console = .init()

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

    lazy var shadow: Shadow = {
        let shadow = Shadow.makeShadow()

        return shadow
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
        addChild(shadow)
        addChild(console.leftButton)
        addChild(console.rightButton)
        addChild(console.jumpButton)
        addChild(console.shootButton)
        addChild(console.attackButton)
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

        if aName == Names.shuriken && bName == Names.shadow {
            contact.bodyA.node?.removeFromParent()
        } else if aName == Names.shadow && bName == Names.shuriken {
            contact.bodyB.node?.removeFromParent()
        }
    }
}