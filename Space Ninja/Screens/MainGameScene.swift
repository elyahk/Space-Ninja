//
//  ContentView.swift
//  Space Ninja
//
//  Created by Eldorbek Nusratov on 12/12/22.
//

import SwiftUI
import SpriteKit
import AVFoundation

struct MainGameScene: View {
    @State var counter: Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @State var audioPlayer: AVAudioPlayer!

    var scene: GameScene {
        let scene = GameScene()
        scene.scaleMode = .resizeFill

        return scene
    }

    var body: some View {
        ZStack {
            SpriteView(scene: scene)
                .ignoresSafeArea()

            VStack { VStack {Text("TIME")
                    .foregroundColor(Color.white)
                    .padding(.leading, -10.0)
                Text("\(counter)")
                    .onReceive(timer) { _ in
                        counter += 1
                    }
                    .foregroundColor(Color.white)
                .padding(.leading, -10.0)}
                Spacer()
            }
         }
        .onAppear {
            let sound = Bundle.main.path(forResource: "background_music", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            self.audioPlayer.play()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainGameScene()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
