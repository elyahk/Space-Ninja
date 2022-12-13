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
                
                
               
                
                Spacer()
            }
          
            
            
            Spacer()
            
            HStack {
                Image ("joypad");
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
