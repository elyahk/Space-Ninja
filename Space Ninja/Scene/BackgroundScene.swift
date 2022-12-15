//
//  BackgroundScene.swift
//  Space Ninja
//
//  Created by eldorbek nusratov on 12/15/22.
//

import Foundation
import SpriteKit

class BackgroundScene {
    var lifeCount: Int = 3 {
        didSet {
            lifeText.text = "\(lifeCount)"
        }
    }

    var ballCount: Int = 0 {
        didSet {
            ballText.text = "\(ballCount)"
        }
    }

    lazy var stage: SKSpriteNode = {
        let stage = SKSpriteNode(texture: SKTexture(imageNamed: "ground_01"), size: .init(width: width, height: 80))
        stage.anchorPoint = .init(x: 0.5, y: 0.5)
        stage.position = .init(x: width / 2, y: stage.size.height/2)
        stage.physicsBody = SKPhysicsBody(rectangleOf: stage.size)
        stage.physicsBody?.affectedByGravity = false
        stage.physicsBody?.isDynamic = false
        stage.physicsBody?.categoryBitMask = PhysicsCategory.ground
        stage.zPosition = -1
        stage.physicsBody?.friction = 0

        return stage
    }()

    lazy var background: SKSpriteNode = {
        let stage = SKSpriteNode(texture: SKTexture(imageNamed: "finalbackground"), size: .init(width: width, height: height))
        stage.anchorPoint = .init(x: 0.5, y: 0.5)
        stage.position = .init(x: width / 2, y: height / 2 )
        stage.zPosition = -10

        return stage
    }()

    lazy var lifeIcon: SKSpriteNode = {
        let stage = SKSpriteNode(texture: SKTexture(imageNamed: .lifeIcon))
        stage.size = .init(width: 30, height: 30)
        stage.anchorPoint = .init(x: 0.5, y: 0.5)
        stage.position = .init(x: 35, y: height - 30)
        stage.zPosition = -2

        return stage
    }()

    lazy var lifeText: SKLabelNode = {
        var view = SKLabelNode()
        view = SKLabelNode(fontNamed: "AvenirNext-Bold")
        view.text = "\(lifeCount)"
        view.horizontalAlignmentMode = .left
        view.fontSize = 35
        view.position = .init(x: lifeIcon.position.x + lifeIcon.size.width / 2 + 10, y: lifeIcon.position.y - 10)

        return view
    }()

    lazy var ballIcon: SKSpriteNode = {
        let stage = SKSpriteNode(texture: SKTexture(imageNamed: .woolBallIcon))
        stage.size = .init(width: 30, height: 30)
        stage.anchorPoint = .init(x: 0.5, y: 0.5)
        stage.position = .init(x: 125, y: height - 30)
        stage.zPosition = -2

        return stage
    }()

    lazy var ballText: SKLabelNode = {
        var view = SKLabelNode()
        view = SKLabelNode(fontNamed: "AvenirNext-Bold")
        view.text = "\(ballCount)"
        view.horizontalAlignmentMode = .left
        view.fontSize = 35
        view.position = .init(x: ballIcon.position.x + ballIcon.size.width / 2 + 10, y: ballIcon.position.y - 10)

        return view
    }()

    lazy var planet1: SKSpriteNode = {
        let stage = SKSpriteNode(texture: SKTexture(imageNamed: "planet_02"))  // saturn
        stage.size = .init(width: 50, height: 50)
        stage.anchorPoint = .init(x: 0.5, y: 0.5)
        stage.position = .init(x: 240 , y: height - 190 )
        stage.zPosition = -2

        return stage
    }()

    lazy var planet2: SKSpriteNode = {
        let stage = SKSpriteNode(texture: SKTexture(imageNamed: "sun_1")) //sun
        stage.size = .init(width: 100, height: 100)
        stage.anchorPoint = .init(x: 0.5, y: 0.5)
        stage.position = .init(x: width / 2, y: 250 )
        stage.zPosition = -2

        return stage
    }()

    lazy var planet3: SKSpriteNode = {
        let stage = SKSpriteNode(texture: SKTexture(imageNamed: "planet_01"))
        stage.size = .init(width: 30, height: 30)
        stage.anchorPoint = .init(x: 0.5, y: 0.5)
        stage.position = .init(x: 800, y: height - 100)
        stage.zPosition = -2

        return stage
    }()





    lazy var planet4: SKSpriteNode = {
        let stage = SKSpriteNode(texture: SKTexture(imageNamed: "woll_ball_01")) //wool
        stage.size = .init(width: 60, height: 60)
        stage.anchorPoint = .init(x: 0.5, y: 0.5)
        stage.position = .init(x: 700 , y: height-120 )
        stage.zPosition = -2

        return stage
    }()



    lazy var planet5: SKSpriteNode = {
        let stage = SKSpriteNode(texture: SKTexture(imageNamed: "woll_ball_01")) //wool
        stage.size = .init(width: 60, height: 60)
        stage.anchorPoint = .init(x: 0.5, y: 0.5)
        stage.position = .init(x: 700 , y: height-120 )
        stage.zPosition = -2

        return stage
    }()


    lazy var planet6: SKSpriteNode = {
        let stage = SKSpriteNode(texture: SKTexture(imageNamed: "woll_ball_01")) //wool
        stage.size = .init(width: 60, height: 60)
        stage.anchorPoint = .init(x: 0.5, y: 0.5)
        stage.position = .init(x: 700 , y: height-120 )
        stage.zPosition = -2

        return stage
    }()


    lazy var planet7: SKSpriteNode = {
        let stage = SKSpriteNode(texture: SKTexture(imageNamed: "sun_1")) //sun piccolo
        stage.size = .init(width: 50, height: 50)
        stage.anchorPoint = .init(x: 0.5, y: 0.5)
        stage.position = .init(x: 500, y: height  - 150 )
        stage.zPosition = -2

        return stage

    }()

    lazy var planet8: SKSpriteNode = {
        let stage = SKSpriteNode(texture: SKTexture(imageNamed: "planet_01"))
        stage.size = .init(width: 40, height: 40)
        stage.anchorPoint = .init(x: 0.5, y: 0.5)
        stage.position = .init(x: 820, y: height - 80)
        stage.zPosition = -2

        return stage
    }()

    lazy var planet9: SKSpriteNode = {
        let stage = SKSpriteNode(texture: SKTexture(imageNamed: "planet_01"))
        stage.size = .init(width: 30, height: 30)
        stage.anchorPoint = .init(x: 0.5, y: 0.5)
        stage.position = .init(x: 850, y: height - 120)
        stage.zPosition = -2

        return stage
    }()

    lazy var planets: [SKSpriteNode] = [
        planet1,
        planet2,
        planet3,
        planet4,
        planet5,
        planet6,
        planet7,
        planet8,
        planet9
    ]
}
