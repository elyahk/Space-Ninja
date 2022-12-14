//
//  ContentView.swift
//  Space Ninja
//
//  Created by Eldorbek Nusratov on 12/12/22.
//

import SwiftUI
import SpriteKit


// A sample SwiftUI creating a GameScene and sizing it
struct MainGameScene: View {
    var scene: GameScene2 {
        let scene = GameScene2()
        scene.scaleMode = .resizeFill
        

        return scene
    }

    var body: some View {
        ZStack {
            SpriteView(scene: scene)
                .ignoresSafeArea()
            VStack {
                Spacer()
                HStack {
                    Button("Left") {
                        scene.runLeft()
                    }
                    .padding()
                    Button("Right") {
                        scene.runRight()
                    }
                    .padding()
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainGameScene()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

extension CGPoint {
    static func +(_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}


// A simple game scene with falling boxes

//class GameScene: SKScene {
//    let stageCategory: UInt32 = 0x1 << 1
//    let enemyCategory: UInt32 = 0x1 << 2
//    let kyoCategory: UInt32 = 0x1 << 3
//    let shadowCategory: UInt32 = 0x1 << 4
//
//    lazy var stage: SKSpriteNode = {
//        let stage = SKSpriteNode(imageNamed: "ground_01")
//        stage.size = CGSize(width: width, height: 100.0)
//        stage.physicsBody?.categoryBitMask = stageCategory
//        stage.physicsBody = SKPhysicsBody(rectangleOf: stage.size)
//        stage.physicsBody?.collisionBitMask = kyoCategory
//        stage.anchorPoint = CGPoint(x: 0, y: 0)
//        stage.position = CGPoint(x: 0, y: 0)
//        stage.physicsBody?.affectedByGravity = false
//        stage.physicsBody?.isDynamic = false
//        stage.zPosition = -1
//
//        return stage
//    }()
//
//    lazy var background: SKSpriteNode = {
//        var background = SKSpriteNode(imageNamed: "finalbackground_2")
//        background.size = CGSize(width: width, height: height - stage.size.height)
//        background.physicsBody = SKPhysicsBody(rectangleOf: background.size)
//        background.anchorPoint = CGPoint(x: 0, y: 0)
//        background.position = CGPoint(x: 0, y: stage.size.height)
//        background.physicsBody?.affectedByGravity = false
//        background.physicsBody?.isDynamic = false
//        background.zPosition = 0
//
//        return background
//    }()
//
//    lazy var kyo: KYO = {
//        let kyo = KYO(texture: SKTexture(imageNamed: "kyo_attack_1"))
//        kyo.size = CGSize(width: 50, height: 50)
//        kyo.physicsBody?.categoryBitMask = kyoCategory
//        kyo.physicsBody?.collisionBitMask = stageCategory
//        kyo.anchorPoint = .zero
//        kyo.physicsBody = SKPhysicsBody(rectangleOf: kyo.size)
//        kyo.position = CGPoint(x: 10, y: 100)
//        kyo.physicsBody?.allowsRotation = false
//        kyo.physicsBody?.isDynamic = true
//        kyo.physicsBody?.affectedByGravity = true
//
//        return kyo
//    }()
//
//    lazy var shadow: Shadow = {
//        let shadow = Shadow(imageNamed: "kyo_run_01")
//        shadow.size = .init(width: 164, height: 164)
//        shadow.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width:164, height:164))
//        shadow.physicsBody?.allowsRotation = false
//        shadow.makeAction(type: .attack1)
//        shadow.position = CGPoint(x: width - 100, y: 20)
//
//        return shadow
//    }()
//
//    lazy var enemy: Mice = {
//        let enemy = Mice(imageNamed: "kyo_run_01")
//        enemy.makeAction(type: .run)
//        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
//        enemy.physicsBody?.categoryBitMask = enemyCategory
//        enemy.physicsBody?.collisionBitMask = stageCategory
//        enemy.anchorPoint = .zero
//        enemy.position = CGPoint(x: width - 200, y: stage.size.height + 200)
//        enemy.anchorPoint = .zero
//
//        return enemy
//    }()
//
//    override func didMove(to view: SKView) {
//        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
//        physicsWorld.gravity = CGVector(dx: 0.0, dy: -3.0)
//        addChild(background)
//        addChild(stage)
//        addChild(kyo)
//        addChild(shadow)
//        addChild(enemy)
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        let location = touch.location(in: self)
//
//        let shuriken = SKSpriteNode(imageNamed: "shuriken_01")
//        shuriken.size = CGSize(width: 30.0, height: 30.0)
//        shuriken.position = CGPoint(x: kyo.position.x + 20, y: kyo.position.y)
//        shuriken.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 30))
//        shuriken.physicsBody?.affectedByGravity = false
//        shuriken.physicsBody?.isDynamic = true
//
//        addChild(shuriken)
//        kyo.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 0))
//        shoot(shuriken: shuriken)
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        kyo.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0))
//    }
//
//    func shoot(shuriken: SKSpriteNode) {
//        shuriken.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 0))
//    }
//}
