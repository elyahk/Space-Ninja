//
//  File.swift
//  Space Ninja
//
//  Created by eldorbek nusratov on 12/14/22.
//

import Foundation
import SpriteKit


class GameController {
    func makeEnemy(type: EnemyType, for scene: GameScene) -> Mice {
        let mice = Mice(imageNamed: "")
        mice.size = CGSize(width: 45, height: 45)
        mice.physicsBody = SKPhysicsBody(rectangleOf: mice.size)
        mice.physicsBody?.allowsRotation = false
        mice.physicsBody?.isDynamic = true
        mice.physicsBody?.affectedByGravity = true
        mice.anchorPoint = .init(x: 0.5, y: 0.5)
        mice.position = CGPoint(x: width - 100, y: 120)
        mice.name = Names.mice
        mice.physicsBody?.contactTestBitMask = PhysicsCategory.shuriken
        mice.physicsBody?.categoryBitMask = PhysicsCategory.mice
        mice.physicsBody?.collisionBitMask = PhysicsCategory.ground
        mice.physicsBody?.friction = 0
        mice.physicsBody?.velocity = CGVector(dx: -100, dy: 0)
        mice.makeAction(type: .run)

        scene.addChild(mice)

        return mice
    }
}


class GameScene: SKScene {
    var mices: [Mice] = []
    var console: Console = .init()
    var bacgroundScene: BackgroundScene = .init()
    var shurikens: [SKSpriteNode] = []
    var gameController = GameController()
    lazy var shadow: Shadow = { Shadow.addShadow(for: self) }()
    lazy var kyo: KYO = { KYO.addKYO(for: self) }()

    override func didMove(to view: SKView) {
        configure()
    }

    private func configure() {
        _ = kyo
        _ = shadow
        configurePhysics()
        bacgroundScene.configure(for: self)
        console.configure(for: self)
    }

    private func configurePhysics() {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -3.0)
        physicsWorld.contactDelegate = self
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

        let mice = gameController.makeEnemy(type: .red, for: self)
        mices.append(mice)
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
        } else if aName == Names.shuriken && bName == Names.mice {
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
        } else if aName == Names.mice && bName == Names.shuriken {
            contact.bodyB.node?.removeFromParent()
            contact.bodyA.node?.removeFromParent()
        }
    }
}
