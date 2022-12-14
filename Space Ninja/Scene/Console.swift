//
//  File.swift
//  Space Ninja
//
//  Created by eldorbek nusratov on 12/14/22.
//

import SpriteKit

class Console {
    let emptySpace = 30
    let bHeight = 40

    lazy var leftButton: SKSpriteNode = {
        let node = SKSpriteNode(color: UIColor.green, size: .init(width: bHeight, height: bHeight))
        node.name = Names.leftButton
        node.position = .init(x: emptySpace + bHeight, y: bHeight)
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.isDynamic = false
        node.zPosition = -1

        return node
    }()

    lazy var rightButton: SKSpriteNode = {
        let node = SKSpriteNode(color: UIColor.green, size: .init(width: bHeight, height: bHeight))
        node.name = Names.rightButton
        node.position = .init(x: emptySpace + bHeight * 2 + 10, y: bHeight)
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.isDynamic = false
        node.zPosition = -1

        return node
    }()

    lazy var attackButton: SKSpriteNode = {
        let node = SKSpriteNode(color: UIColor.green, size: .init(width: bHeight, height: bHeight))
        node.name = Names.attackButton
        node.position = .init(x: Int(width) - emptySpace - bHeight, y: bHeight)
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.isDynamic = false
        node.zPosition = -1

        return node
    }()

    lazy var jumpButton: SKSpriteNode = {
        let node = SKSpriteNode(color: UIColor.green, size: .init(width: self.bHeight, height: self.bHeight))
        node.name = Names.jumpButton
        node.position = .init(x: Int(attackButton.position.x) - 20 - bHeight, y: bHeight)
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.isDynamic = false
        node.zPosition = -1

        return node
    }()

    lazy var shootButton: SKSpriteNode = {
        let node = SKSpriteNode(color: UIColor.green, size: .init(width: bHeight, height: bHeight))
        node.name = Names.shootButton
        node.position = .init(x: Int(jumpButton.position.x) - 20 - bHeight, y: bHeight)
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.isDynamic = false
        node.zPosition = -1

        return node
    }()


}
