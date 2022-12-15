//
//  File.swift
//  Space Ninja
//
//  Created by eldorbek nusratov on 12/15/22.
//

import SpriteKit

class Meteor: SKSpriteNode {
    private var type: MeteorType = .rock

    convenience init(type: MeteorType) {
        self.init(imageNamed: type.rawValue)
        self.type = type
    }

    static func addMeteor(type: MeteorType, for scene: GameScene, position: CGPoint) -> Meteor {
        let meteor = Meteor(imageNamed: type.rawValue)
        meteor.size = CGSize(width: 45, height: 45)
        meteor.physicsBody = SKPhysicsBody(circleOfRadius: meteor.size.width / 2)
        meteor.physicsBody?.allowsRotation = true
        meteor.physicsBody?.isDynamic = true
        meteor.physicsBody?.affectedByGravity = true
        meteor.anchorPoint = .init(x: 0.5, y: 0.5)
        meteor.position = position
        meteor.name = Names.meteor
        meteor.physicsBody?.contactTestBitMask = PhysicsCategory.kyo
        meteor.physicsBody?.categoryBitMask = PhysicsCategory.meteor
        meteor.physicsBody?.collisionBitMask = PhysicsCategory.ground
        meteor.physicsBody?.friction = 0

        scene.addChild(meteor)

        return meteor
    }
}


// MARK: - Type

enum MeteorType: String {
    case rock = "rock_29"
    case rock2 = "rock_31"
    case explosion = "meteora_up_explode_03"
}
