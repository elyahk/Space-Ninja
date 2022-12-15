//
//  MainScreen.swift
//  Space Ninja
//
//  Created by Maura De Chiara  on 14/12/22.
//

import SwiftUI
import AVFoundation


struct MainScreen: View {
    @State var playGame: Bool = false
    
    @State var audioPlayer: AVAudioPlayer!

    var body: some View {
        ZStack {
            Image("fbg1")
                .resizable()
                .ignoresSafeArea()
                .frame(width: width, height: height)
                .scaledToFill()

            Button(action: {

            }) {
                Image("obf")
                    .resizable()
                    .frame(width: 300, height: 150)
                    .scaledToFill()

            }
            .frame(width: 300, height: 150)
            .position(x: width/2 + 10, y: height/2 + 145)
           
            Button(action: {
                playGame.toggle()
            }) {
                Image("sbf")
                    .resizable()
                    .frame(width: 300, height: 150)
                    .scaledToFill()
            }
            .frame(width: 300, height: 150)
            .position(x: width/2, y: height/2 + 70)

        }
        .fullScreenCover(isPresented: $playGame, content: {
            MainGameScene()
        })
        .onAppear {
            let sound = Bundle.main.path(forResource: "ninjatheme", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            self.audioPlayer.play()
        }
        
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
            .previewInterfaceOrientation(.landscapeLeft)
            .environment(\.horizontalSizeClass, .compact)
    }
}





