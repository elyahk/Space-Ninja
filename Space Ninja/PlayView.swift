//
//  PlayView.swift
//  Space Ninja
//
//  Created by Antonio Esposito on 13/12/22.
//

import SwiftUI

struct PlayView: View {
    var body: some View {
        
        VStack {
            HStack{
                Image("life_icon")
               
                Image("wool_ball_icon");
                Spacer()
                
                Image("time_icon")
                    .resizable(resizingMode: .stretch)
                    .padding(.leading, -100.0)
                    .frame(width: /*@START_MENU_TOKEN@*/200.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/200.0/*@END_MENU_TOKEN@*/)
                    ;
                
                Spacer()
            }
          
            
            
            Spacer()
            
            HStack {
                Image ("joypad")
                    .resizable(capInsets: EdgeInsets(top: -30.0, leading: 0.0, bottom: 0.0, trailing: -160.0))
                    
                    ;
                Spacer()
                Image ("button0");
                Image ("button1");
                Image ("button2");
                
            }
        }
        
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
            .previewInterfaceOrientation(.landscapeLeft)

    }
}
