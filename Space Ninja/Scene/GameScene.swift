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
    var meteorHighSpeed: Int = 4000
    var meteorLowSpeed: Int = 2000
    var miceHighSpeed: Int = 3000
    var miceLowSpeed: Int = 800
    var miceCount: Int = 1
    var meteorCount: Int = 1

    init(scene: GameScene) {
        self.scene = scene
        randomMice()
        randomMeteor()
    }

    func addMice() {
        guard let randomType = EnemyType.allCases.randomElement() else { return }
        for _ in 0..<miceCount {

            _ = Mice.addMice(type: randomType, for: scene)

            if miceLowSpeed > 20, miceHighSpeed > 30 {
                miceLowSpeed -= 50
                miceHighSpeed -= 50
            } else {
                miceCount = miceCount < 3 ? miceCount + 1 : 3
            }
        }
    }

    func addMeteor() {
        guard let randomType = MeteorType.allCases.randomElement() else { return }
        for _ in 0..<meteorCount {
            let random = CGFloat.random(in: 100...(width - 50))
            _ = Meteor.addMeteor(type: randomType, for: scene, position: .init(x: random, y: height - 50))
            if meteorLowSpeed > 40, meteorHighSpeed > 50 {
                meteorLowSpeed -= 80
                meteorHighSpeed -= 80
            } else {
                meteorCount = meteorCount < 3 ? meteorCount + 1 : 3
            }
        }
    }

    func randomMeteor() {
        if meteorHighSpeed > meteorLowSpeed {
            let random = Int.random(in: meteorLowSpeed...meteorHighSpeed)
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(random)) { [weak self] in
                self?.addMeteor()
                self?.randomMeteor()
            }
        }
    }

    func randomMice() {
        if miceHighSpeed > miceLowSpeed {
            let random = Int.random(in: miceLowSpeed...miceHighSpeed)
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(random)) { [weak self] in
                self?.addMice()
                self?.randomMice()
            }
        }
    }
}


class GameScene: SKScene {
    var gameOver: () -> Void = { }
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
            _ = gameController
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

    func addKYOIfPosible() {
        if bacgroundScene.lifeCount > 0 {
            kyo = KYO.addKYO(for: self)
        } else {
            gameOver()
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
        } else if aCategory | bCategory == PhysicsCategory.kyo | PhysicsCategory.meteor {
            kyoDie(contact.bodyA.node, contact.bodyB.node)
        } else if aCategory | bCategory == PhysicsCategory.meteor | PhysicsCategory.ground {
            removeMeteor(contact.bodyA.node, contact.bodyB.node)
        }
    }

    func removeMeteor(_ nodeA: SKNode?, _ nodeB: SKNode?) {
        if PhysicsCategory.meteor == nodeA?.physicsBody?.categoryBitMask {
            nodeA?.removeFromParent()
        } else if PhysicsCategory.meteor == nodeB?.physicsBody?.categoryBitMask {
            nodeB?.removeFromParent()
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
        if let kyo = nodeA as? KYO {
            nodeB?.removeFromParent()
            kyo.die()
        } else if let kyo = nodeB as? KYO {
            nodeA?.removeFromParent()
            kyo.die()
        }

        bacgroundScene.lifeCount -= 1
        addKYOIfPosible()
    }
}
