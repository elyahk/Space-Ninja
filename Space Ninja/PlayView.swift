//
//  PlayView.swift
//  Space Ninja
//
//  Created by Antonio Esposito on 13/12/22.
//

import SwiftUI

struct PlayView: View {
    var body: some View {
        
        
        ZStack{
        VStack {
            HStack{
                Image("life_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .padding(.bottom, -5.0)
                    .frame(width: 50, height: 50);
                Text("7")
Image("wool_ball_icon")
                    .resizable()
                        .aspectRatio(contentMode: .fill)
                        .padding(.trailing, 1.0)
                        .frame(width: 40, height: 40)
                Text("00")
                Spacer()
VStack {Text("TIME")
                        .padding(.leading, -10.0)
                    Text ("00")
                        .padding(.leading, -10.0)}
                .padding();
                Spacer()
                Spacer()
            }
          Spacer()
            HStack {
                Image ("joypad")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .opacity(0.3)
                    .padding()
                ;
                Spacer()
                Image ("button0")
                .resizable() .frame(width: 60, height: 60)
                .opacity(0.3);
                VStack {Image ("button2")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .opacity(0.3);
                    Image ("button1")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .opacity(0.3);}}
        }
            
            
            
                .background(Image("finalbackground")
                    .resizable()
                    .edgesIgnoringSafeArea(.all))

       

            
            
        }
        
      
        
        
    }
}





struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
            .previewInterfaceOrientation(.landscapeLeft)

    }
}
