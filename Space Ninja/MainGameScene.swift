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
    case run = "kyo_run"
    case jump = "kyo_jump"
    
    var actionNames: [String] {
        var actions: [String] = ["kyo_run"]
        
        return actions
    }
}

class KYOPriteNode: SKSpriteNode {
    func makeAction(type action: KYOAction) {
        let actionTextures =
        [
            SKTexture(imageNamed: "kyo_run_01"),
            SKTexture(imageNamed: "kyo_run_02"),
            SKTexture(imageNamed: "kyo_run_03")
        ]
        
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
        kyo.makeAction(type: .jump)
        kyo.position = location
        kyo.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
        
        addChild(kyo)
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
        SpriteView(scene: scene)
            .frame(width: .infinity, height: .infinity)
            .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainGameScene()
            .previewInterfaceOrientation(.landscapeLeft)
            .environment(\.horizontalSizeClass, .compact) // 2
    }
}
