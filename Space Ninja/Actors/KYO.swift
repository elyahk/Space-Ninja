//
//  File.swift
//  Space Ninja
//
//  Created by eldorbek nusratov on 12/13/22.
//

import Foundation
import SpriteKit

enum MusicType {
    case none
    case jump
}

class KYO: SKSpriteNode {
    static var width: CGFloat { 50.0 }

    static func addKYO(for scene: GameScene) -> KYO {
        let kyo = KYO(texture: SKTexture(imageNamed: "kyo_attack_1"))
        kyo.size = CGSize(width: width, height: width)
        kyo.physicsBody = SKPhysicsBody(rectangleOf: kyo.size)
        kyo.physicsBody?.allowsRotation = false
        kyo.physicsBody?.isDynamic = true
        kyo.physicsBody?.affectedByGravity = true
        kyo.anchorPoint = .init(x: 0.5, y: 0.5)
        kyo.position = CGPoint(x: 10, y: 200)
        kyo.physicsBody?.categoryBitMask = PhysicsCategory.kyo
        kyo.physicsBody?.collisionBitMask = PhysicsCategory.ground
        kyo.physicsBody?.friction = 0
        scene.addChild(kyo)

        return kyo
    }

    func makeAction(type action: KYOAction, repeating: Bool = false, music: MusicType = .none) {
        removeAllActions()

        let actionTextures: [SKTexture] = action.actionNames.map {
            SKTexture(imageNamed: $0)
        }
        let action = SKAction.animate(with: actionTextures, timePerFrame: 0.1, resize: false, restore: true)
        var actions = [action]

        switch music {
        case .none: break
        case .jump:
            let music = SKAction.playSoundFileNamed(Music.jump, waitForCompletion: true)
            actions.append(music)
        }

        let finalAction = SKAction.sequence(actions)

        run(SKAction.repeat(finalAction, count: repeating ? 100 : 1)) {
            if !repeating {
                self.texture = SKTexture(imageNamed: "kyo_attack_1")
                self.size = CGSize(width: KYO.width, height: KYO.width)
            }
        }
    }

    func moveLeft() {
        physicsBody?.velocity = CGVector(dx: -130, dy: 0)
        makeAction(type: .run, repeating: true)
    }

    func moveRight() {
        physicsBody?.velocity = CGVector(dx: 130, dy: 0)
        makeAction(type: .run, repeating: true)
    }

    func stop() {
        physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        removeAllActions()
        texture = SKTexture(imageNamed: "kyo_attack_1")
    }

    func jump() {
        physicsBody?.velocity = CGVector(dx: physicsBody?.velocity.dx ?? 0, dy: 200)
        makeAction(type: .jump)
    }

    func attack() {
        makeAction(type: .attack, music: .jump)
    }

    func shoot() {
        makeAction(type: .shoot)
    }
}

extension KYO {
    func addCharacter(for scene: GameScene) {
        scene.addChild(self)
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
