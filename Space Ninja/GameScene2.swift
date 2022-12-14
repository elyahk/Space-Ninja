//
//  File.swift
//  Space Ninja
//
//  Created by eldorbek nusratov on 12/14/22.
//

import Foundation
import SpriteKit

class GameScene2: SKScene {
    let stageCategory: UInt32 = 0x1 << 1
    let enemyCategory: UInt32 = 0x1 << 2
    let kyoCategory: UInt32 = 0x1 << 3
    let shadowCategory: UInt32 = 0x1 << 4

    lazy var stage: SKSpriteNode = {
        let stage = SKSpriteNode(color: .systemGray, size: .init(width: width, height: 80))
        stage.anchorPoint = .init(x: 0.5, y: 0.5)
        stage.position = .init(x: width / 2, y: stage.size.height/2)
        stage.physicsBody = SKPhysicsBody(rectangleOf: stage.size)
        stage.physicsBody?.affectedByGravity = false
        stage.physicsBody?.isDynamic = false
        stage.physicsBody?.categoryBitMask = stageCategory
        stage.zPosition = -1
        stage.physicsBody?.friction = 0

        return stage
    }()

    lazy var kyo: KYO = {
        let kyo = KYO(texture: SKTexture(imageNamed: "kyo_attack_1"))
        kyo.size = CGSize(width: 50, height: 50)
        kyo.physicsBody = SKPhysicsBody(rectangleOf: kyo.size)
        kyo.physicsBody?.allowsRotation = false
        kyo.physicsBody?.isDynamic = true
        kyo.physicsBody?.affectedByGravity = true
        kyo.anchorPoint = .init(x: 0.5, y: 0.5)
        kyo.position = CGPoint(x: 10, y: 200)
        kyo.physicsBody?.categoryBitMask = kyoCategory
        kyo.physicsBody?.collisionBitMask = stageCategory
        kyo.physicsBody?.friction = 0

        return kyo
    }()

    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -3.0)
        addChild(stage)
        addChild(kyo)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        move()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        stop()
    }

    private func move() {
        kyo.physicsBody?.velocity = CGVector(dx: 100, dy: 0)
    }

    private func stop() {
//        kyo.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    }
}
