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
}


// MARK: - Type

enum EnemyType: String {
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


