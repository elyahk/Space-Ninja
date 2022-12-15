//
//  File.swift
//  Space Ninja
//
//  Created by eldorbek nusratov on 12/13/22.
//

import SpriteKit

enum SHadowAction: String {
    case attack1
    case attack2
    case die
    case stand
    case win

    var actionCounts : Int {
        switch self {
        case .win:
            return 4
        case .stand:
            return 2
        case .attack1:
            return 2
        case .die:
            return 13
        case .attack2:
            return 9
        }
    }

    var actionNames: [String] {
        var actions: [String] = []

        for i in 1...actionCounts {
            actions.append("shadow_\(self.rawValue)_\(i)")
        }

        return actions
    }
}

class Shadow: SKSpriteNode {
    func makeAction(type action: SHadowAction) {
        let actionTextures: [SKTexture] = action.actionNames.map {
            SKTexture(imageNamed: $0)
        }
        let action = SKAction.animate(with: actionTextures, timePerFrame: 0.1, resize: true, restore: true)
        run(SKAction.repeatForever(action))
    }

    static func addShadow(for scene: GameScene) -> Shadow {
        let shadow = Shadow(texture: SKTexture(imageNamed: "shadow_stand_1"))
        shadow.size = CGSize(width: 60, height: 60)
        shadow.physicsBody = SKPhysicsBody(rectangleOf: shadow.size)
        shadow.physicsBody?.allowsRotation = false
        shadow.physicsBody?.isDynamic = true
        shadow.physicsBody?.affectedByGravity = true
        shadow.anchorPoint = .init(x: 0.5, y: 0.5)
        shadow.position = CGPoint(x: width - 100, y: 200)
        shadow.physicsBody?.categoryBitMask = PhysicsCategory.shadow
        shadow.physicsBody?.collisionBitMask = PhysicsCategory.ground
        shadow.name = Names.shadow
        shadow.physicsBody?.friction = 0
        scene.addChild(shadow)

        return shadow
    }

}

