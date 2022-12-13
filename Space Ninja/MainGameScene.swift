//
//  ContentView.swift
//  Space Ninja
//
//  Created by Eldorbek Nusratov on 12/12/22.
//

import SwiftUI
import SpriteKit

let height = UIScreen.main.bounds.width
let width = UIScreen.main.bounds.height

// A simple game scene with falling boxes

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

class KYOPriteNode: SKSpriteNode {
    func makeAction(type action: KYOAction) {
        let actionTextures: [SKTexture] = action.actionNames.map {
            SKTexture(imageNamed: $0)
        }
        let action = SKAction.animate(with: actionTextures, timePerFrame: 0.1, resize: true, restore: true)
        run(SKAction.repeatForever(action))
    }
}

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

class ShadowPriteNode: SKSpriteNode {
    func makeAction(type action: SHadowAction) {
        let actionTextures: [SKTexture] = action.actionNames.map {
            SKTexture(imageNamed: $0)
        }
        let action = SKAction.animate(with: actionTextures, timePerFrame: 0.1, resize: true, restore: true)
        run(SKAction.repeatForever(action))
    }
}

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

class EnemyPriteNode: SKSpriteNode {
    private var type: EnemyType = .blue
    
    convenience init(type: EnemyType) {
        self.init(imageNamed: "")
        self.type = type
    }
    
    func makeAction(type action: EnemyAction) {
        let actionTextures: [SKTexture] = type.actionNames(action: action).map {
            SKTexture(imageNamed: $0)
        }
        
        let action = SKAction.animate(with: actionTextures, timePerFrame: 0.1, resize: true, restore: true)
        run(SKAction.repeatForever(action))
    }
}

class GameScene: SKScene {
    var background = SKSpriteNode(imageNamed: "starrysky_bg")
    var stage = SKSpriteNode(imageNamed: "bg_05")

    lazy var planet: SKSpriteNode = {
        let kyo = SKSpriteNode(imageNamed: "planet_05")
        kyo.position = CGPoint(x: width / 2, y: height - 100)
        kyo.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
        kyo.physicsBody?.affectedByGravity = false
             
        return kyo
    }()
    
    lazy var kyo: KYOPriteNode = {
        let kyo = KYOPriteNode(texture: SKTexture(imageNamed: "kyo_run_01"), size: .init(width: 100, height: 100))
        kyo.makeAction(type: .attack)
        kyo.position = CGPoint(x: 230, y: 20)
        kyo.physicsBody = SKPhysicsBody(rectangleOf: kyo.size)
        kyo.physicsBody?.allowsRotation = false
        kyo.physicsBody?.isDynamic = true
        kyo.physicsBody?.affectedByGravity = true

        return kyo
    }()
    
    lazy var shadow: ShadowPriteNode = {
        let shadow = ShadowPriteNode(imageNamed: "kyo_run_01")
        shadow.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
        shadow.physicsBody?.allowsRotation = false
        shadow.makeAction(type: .attack1)
        shadow.position = CGPoint(x: width - 100, y: 20)
        shadow.xScale = 1.5
        shadow.yScale = 1.5
             
        return shadow
    }()
    
    lazy var enemy: EnemyPriteNode = {
        let enemy = EnemyPriteNode(imageNamed: "kyo_run_01")
        enemy.makeAction(type: .run)
        enemy.position = CGPoint(x: width - 200, y: 10)
        enemy.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
        enemy.xScale = 1.5
        enemy.yScale = 1.5
        
        return enemy
    }()
    
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.xScale = 3
        
        stage.position = CGPoint(x: frame.size.width / 2, y: stage.frame.height / 2)
        stage.xScale = 3
        
        addChild(background)
        addChild(stage)
        addChild(kyo)
        addChild(shadow)
        addChild(enemy)
        addChild(planet)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        let shuriken = SKSpriteNode(imageNamed: "shuriken_01")
        shuriken.size = CGSize(width: 30.0, height: 30.0)
        shuriken.position = CGPoint(x: kyo.position.x + 20, y: kyo.position.y)
        shuriken.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 30))
        shuriken.physicsBody?.affectedByGravity = false
        shuriken.physicsBody?.isDynamic = true
        
        addChild(shuriken)
        kyo.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 0))
        shoot(shuriken: shuriken)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        kyo.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0))
    }

    func shoot(shuriken: SKSpriteNode) {
        shuriken.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 0))
    }
}

// A sample SwiftUI creating a GameScene and sizing it
struct MainGameScene: View {
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: width, height: height)
        scene.scaleMode = .fill
        return scene
    }

    var body: some View {
        ZStack {
            Image("starrysky_bg")
                .resizable()
                .frame(width: .infinity, height: .infinity)
            
            SpriteView(scene: scene)
                .frame(width: .infinity, height: .infinity)
                .ignoresSafeArea()
                .background(Color.clear)
            
            VStack {
                Spacer()
//                HStack {
//                    Button {
//
//                    } label: {
//                        Text("<- ")
//                            .foregroundColor(.yellow)
//                            .font(.system(size: 40, weight: .bold))
//                    }
//
//                    Button {
//
//                    } label: {
//                        Text(" ->")
//                            .foregroundColor(.yellow)
//                            .font(.system(size: 40, weight: .bold))
//                    }
//                    Spacer()
//                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainGameScene()
            .previewInterfaceOrientation(.landscapeLeft)
            .environment(\.horizontalSizeClass, .compact) // 2
    }
}

extension CGPoint {
    static func +(_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}
