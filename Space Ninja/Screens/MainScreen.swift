//
//  MainScreen.swift
//  Space Ninja
//
//  Created by Maura De Chiara  on 14/12/22.
//

import SwiftUI

struct MainScreen: View {
    var body: some View {
        ZStack {
            Image("fbg1")
                .resizable()
                .ignoresSafeArea()
                .frame(width: width, height: height)
                .scaledToFill()
            
           
            Button(action: {

            }) {
                Image("sbf")
                    .resizable()
                    .frame(width: 300, height: 150)
                    .scaledToFill()
            }
            .frame(width: 300, height: 150)
            .position(x: width/2, y: height/2 + 70)

            
            Button(action: {

            }) {
                Image("obf")
                    .resizable()
                    .frame(width: 300, height: 150)
                    .scaledToFill()

            }
            .frame(width: 300, height: 150)
            .position(x: width/2 + 10, y: height/2 + 145)
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





