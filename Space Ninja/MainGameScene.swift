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
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let kyo = KYOPriteNode(imageNamed: "kyo_run_01")
        kyo.makeAction(type: .win)
        kyo.position = location
        kyo.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
        
        let enemy = EnemyPriteNode(imageNamed: "kyo_run_01")
        enemy.makeAction(type: .attack)
        enemy.position = CGPoint(x: location.x + 50, y: location.y + 50)
        enemy.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 80, height: 80))
        
        addChild(kyo)
        addChild(enemy)
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
            SpriteView(scene: scene)
                .frame(width: .infinity, height: .infinity)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                HStack {
                    Button {
                        
                    } label: {
                        Text("Left")
                            .foregroundColor(.white)
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Right")
                            .foregroundColor(.white)
                    }
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
            .environment(\.horizontalSizeClass, .compact) // 2
    }
}
