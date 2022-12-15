//
//  LeaderView.swift
//  Space Ninja
//
//  Created by Antonio Esposito on 15/12/22.
//

import SwiftUI


struct LeaderView: View {
    var body: some View {
        ZStack {
            
            Image("fbg1")
                .resizable()
                .ignoresSafeArea()
                .frame(width: width, height: height)
                .scaledToFill()
            
            VStack {
                Spacer()
                VStack {
                    Image("leader_icon")
                        .resizable()
                        .frame(width: 300, height: 50)
                        .scaledToFill()
                    
                    Text(" Eldor - 70 secs")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                    
                    Text("Antonio - 50 secs ")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                    
                    Text("Maura - 40 secs")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                }
                .background {
                    Image("leader_board")
                        .resizable()
                        .frame(width: .infinity, height: .infinity)
                        .padding([.leading, .trailing], 125)
                        .padding([.bottom, .top], -5)
                        .scaledToFill()
                }
            }
        }
    }
}

struct LeaderView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderView()
            .previewInterfaceOrientation(.landscapeLeft)
            .environment(\.horizontalSizeClass, .compact)
    }
}





