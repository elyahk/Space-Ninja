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
class GameScene: SKScene {
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let walkAnimation =
        [
            SKTexture(imageNamed: "sprite_0"),
            SKTexture(imageNamed: "sprite_1"),
            SKTexture(imageNamed: "sprite_2"),
            SKTexture(imageNamed: "sprite_3"),
            SKTexture(imageNamed: "sprite_4"),
            SKTexture(imageNamed: "sprite_5"),
            SKTexture(imageNamed: "sprite_6")
        ]
        
        let box = SKSpriteNode(texture: walkAnimation[0])
        box.run(SKAction.animate(with: walkAnimation, timePerFrame: 0.05))
        box.position = location
        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        
        addChild(box)
    }
}

// A sample SwiftUI creating a GameScene and sizing it
// at 300x400 points
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
