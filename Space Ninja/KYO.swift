//
//  File.swift
//  Space Ninja
//
//  Created by eldorbek nusratov on 12/13/22.
//

import Foundation
import SpriteKit

class KYO: SKSpriteNode {
    static func makeKYO() -> KYO {
        let kyo = KYO(texture: SKTexture(imageNamed: "kyo_attack_1"))
        kyo.size = CGSize(width: 50, height: 50)
        kyo.physicsBody = SKPhysicsBody(rectangleOf: kyo.size)
        kyo.physicsBody?.allowsRotation = false
        kyo.physicsBody?.isDynamic = true
        kyo.physicsBody?.affectedByGravity = true
        kyo.anchorPoint = .init(x: 0.5, y: 0.5)
        kyo.position = CGPoint(x: 10, y: 200)
        kyo.physicsBody?.categoryBitMask = PhysicsCategory.kyo
        kyo.physicsBody?.collisionBitMask = PhysicsCategory.ground
        kyo.physicsBody?.friction = 0

        return kyo
    }

    func makeAction(type action: KYOAction) {
        let actionTextures: [SKTexture] = action.actionNames.map {
            SKTexture(imageNamed: $0)
        }
        let action = SKAction.animate(with: actionTextures, timePerFrame: 0.1, resize: true, restore: true)
//        run(SKAction.repeat(action, count: 1))
        run(action) {
            self.texture = SKTexture(imageNamed: "kyo_attack_1")
        }
    }

    func moveLeft() {
        physicsBody?.velocity = CGVector(dx: -130, dy: 0)
    }

    func moveRight() {
        physicsBody?.velocity = CGVector(dx: 130, dy: 0)
    }

    func stop() {
        physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    }

    func jump() {
        physicsBody?.velocity = CGVector(dx: physicsBody?.velocity.dx ?? 0, dy: 200)
    }

    func attack() {
        makeAction(type: .attack)
    }

    func shoot() {
        makeAction(type: .shoot)
    }
}

enum KYOAction: String {
    case run
    case jump
    case attack
    case die
    case shoot
    case stand
    case win

    var actionCounts : Int {
        switch self {
        case .run:
            return 3
        case .jump:
            return 3
        case .attack:
            return 4
        case .die:
            return 13
        case .shoot:
            return 5
        case .stand:
            return 2
        case .win:
            return 8
        }
    }

    var actionNames: [String] {
        var actions: [String] = []

        for i in 1...actionCounts {
            actions.append("kyo_\(self.rawValue)_\(i)")
        }

        return actions
    }
}
