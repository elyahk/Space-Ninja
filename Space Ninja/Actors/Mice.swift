//
//  File.swift
//  Space Ninja
//
//  Created by eldorbek nusratov on 12/13/22.
//

import SpriteKit


class Mice: SKSpriteNode {
    private var type: EnemyType = .blue

    convenience init(type: EnemyType) {
        self.init(imageNamed: "")
        self.type = type
    }

    func makeAction(type action: EnemyAction, repeated: Bool = true, timePerFrame: TimeInterval = 0.1, completion: @escaping () -> Void = { }) {
        let actionTextures: [SKTexture] = type.actionNames(action: action).map {
            SKTexture(imageNamed: $0)
        }

        let action = SKAction.animate(with: actionTextures, timePerFrame: timePerFrame, resize: false, restore: true)
        let finalAction = repeated ? SKAction.repeatForever(action) : action
        run(finalAction) {
            completion()
        }
    }

    func die() {
        makeAction(type: .die, repeated: false, timePerFrame: 0.05) { [weak self] in
            self?.removeFromParent()
        }
    }

    static func addMice(type: EnemyType, for scene: GameScene) -> Mice {
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


// MARK: - Type

enum EnemyType: String, CaseIterable {
    case blue
    case green
    case orange
    case red

    func actionNames(action: EnemyAction) -> [String] {
        var actions: [String] = []

        for i in 1...action.actionCounts {
            actions.append("enemy_\(self.rawValue)_\(action.rawValue)_\(i)")
        }

        return actions
    }
}

enum EnemyAction: String {
    case attack
    case die
    case run

    var actionCounts : Int {
        switch self {
        case .attack:
            return 2
        case .die:
            return 5
        case .run:
            return 3
        }
    }
}


