//
//  File.swift
//  Space Ninja
//
//  Created by eldorbek nusratov on 12/14/22.
//

import Foundation
import SpriteKit


class GameController {
    let scene: GameScene

    init(scene: GameScene) {
        self.scene = scene
    }

    func makeEnemy(type: EnemyType) -> Mice {
        return Mice.addMice(type: type, for: scene)
    }

    func addMeteor() {
        let random = CGFloat.random(in: 100...(width - 50))
        _ = Meteor.addMeteor(type: .rock, for: scene, position: .init(x: random, y: height - 50))
    }
}


class GameScene: SKScene {
    var mices: [Mice] = []
    var console: Console = .init()
    var bacgroundScene: BackgroundScene = .init()
    var shurikens: [SKSpriteNode] = []
    lazy var gameController = { GameController(scene: self) }()
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
            }
        }

        let mice = gameController.makeEnemy(type: .red)
        gameController.addMeteor()

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

        guard let aCategory = contact.bodyA.node?.physicsBody?.categoryBitMask,
              let bCategory = contact.bodyB.node?.physicsBody?.categoryBitMask else { return }

        if aName == Names.shuriken && bName == Names.shadow {
            contact.bodyA.node?.removeFromParent()
        } else if aName == Names.shadow && bName == Names.shuriken {
            contact.bodyB.node?.removeFromParent()
        } else if aName == Names.shuriken && bName == Names.mice || aName == Names.mice && bName == Names.shuriken {
            miceDie(contact.bodyA.node, contact.bodyB.node)
        } else if aCategory | bCategory == PhysicsCategory.kyo | PhysicsCategory.mice {
            kyoDie(contact.bodyA.node, contact.bodyB.node)
        }
    }

    func miceDie(_ nodeA: SKNode?, _ nodeB: SKNode?) {
        if let mice = nodeA as? Mice {
            mice.die()
            nodeB?.removeFromParent()
        } else if let mice = nodeB as? Mice {
            nodeA?.removeFromParent()
            mice.die()
        }

        bacgroundScene.ballCount += 1
    }

    func kyoDie(_ nodeA: SKNode?, _ nodeB: SKNode?) {
        if let kyo = nodeA as? KYO, let mice = nodeB as? Mice {
            mice.die()
            kyo.die()
        } else if let kyo = nodeB as? KYO, let mice = nodeA as? Mice {
            mice.die()
            kyo.die()
        }

        bacgroundScene.lifeCount -= 1
    }
}
