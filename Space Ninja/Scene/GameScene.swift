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
    var bacgroundScene: BackgroundScene = .init()

    var lifeCount: Int = 3 {
        didSet {
            lifeText.text = "\(lifeCount)"
        }
    }

    var ballCount: Int = 0 {
        didSet {
            ballText.text = "\(ballCount)"
        }
    }

    lazy var stage: SKSpriteNode = bacgroundScene.stage
    lazy var background: SKSpriteNode = bacgroundScene.background
    lazy var lifeIcon: SKSpriteNode = bacgroundScene.lifeIcon
    lazy var lifeText: SKLabelNode = bacgroundScene.lifeText
    lazy var ballIcon: SKSpriteNode = bacgroundScene.ballIcon
    lazy var ballText: SKLabelNode = bacgroundScene.ballText
    lazy var planets: [SKSpriteNode] = bacgroundScene.planets
    lazy var planet1: SKSpriteNode = bacgroundScene.planet1
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
        configurePhysics()
        configureBackgroundScene()
        configureCharacters()
        configureConsole()
    }

    private func configureCharacters() {
        addChild(kyo)
        addChild(shadow)
    }

    private func configureConsole() {
        addChild(console.leftButton)
        addChild(console.rightButton)
        addChild(console.jumpButton)
        addChild(console.shootButton)
        addChild(console.attackButton)
    }

    private func configurePhysics() {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -3.0)
        physicsWorld.contactDelegate = self
    }

    private func configureBackgroundScene() {
        addChild(stage)
        addChild(background)
        addChild(lifeIcon)
        addChild(lifeText)
        addChild(ballIcon)
        addChild(ballText)
        planets.forEach { addChild($0) }
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
