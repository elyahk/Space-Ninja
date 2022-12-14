//
//  File.swift
//  Space Ninja
//
//  Created by eldorbek nusratov on 12/13/22.
//

import Foundation
import SpriteKit

class KYO: SKSpriteNode {
    func makeAction(type action: KYOAction) {
        let actionTextures: [SKTexture] = action.actionNames.map {
            SKTexture(imageNamed: $0)
        }
        let action = SKAction.animate(with: actionTextures, timePerFrame: 0.1, resize: true, restore: true)
        run(SKAction.repeat(action, count: 1))
    }

    func moveLeft() {
        physicsBody?.velocity = CGVector(dx: 130, dy: 0)
    }

    func moveRight() {
        physicsBody?.velocity = CGVector(dx: -130, dy: 0)
    }

    func stop() {
        physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    }

    func jump() {
        physicsBody?.velocity = CGVector(dx: physicsBody?.velocity.dx ?? 0, dy: 20)
    }

    func attack() {

    }

    func shoot() {

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
