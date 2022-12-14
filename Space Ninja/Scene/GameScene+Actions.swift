//
//  GameScene+Actions.swift
//  Space Ninja
//
//  Created by eldorbek nusratov on 12/14/22.
//

import SpriteKit

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
        shuriken.physicsBody?.contactTestBitMask = PhysicsCategory.shadow
        shuriken.name = Names.shuriken
        shurikens.append(shuriken)

        addChild(shuriken)

        shuriken.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 0))
    }

    func stop() {
        kyo.stop()
    }
}
