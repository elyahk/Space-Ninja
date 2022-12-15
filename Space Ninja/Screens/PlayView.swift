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
                    .foregroundColor(Color.white)
Image("wool_ball_icon")
                    .resizable()
                        .aspectRatio(contentMode: .fill)
                        .padding(.trailing, 1.0)
                        .frame(width: 50, height: 50)
                Text("00")
                    .foregroundColor(Color.white)
                Spacer()
                VStack {Text("TIME")
                        .foregroundColor(Color.white)
                        .padding(.leading, -10.0)
    Text ("00")
        .foregroundColor(Color.white)
                        .padding(.leading, -10.0)}
                .padding();
                Spacer()
                Spacer()
            }
          Spacer()
            HStack (spacing: -90 ) {
                
                Button(action: {
                    // Button action here
                }) {
                    Image ("joypad_button_left")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .opacity(0.2)
                    .padding([.leading, .bottom], -20.0)}
                Button(action: {
                    // Button action here
                }) {
                    Image ("joypad_button_right")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .opacity(0.2)
                    .padding([.leading, .bottom], -20.0)}
                .padding()
                
                
                ;
                Spacer()
                
                Button(action: {
                    // Eldor do some magic
                }) {
                    Image ("button0")
                        .resizable() .frame(width: 60, height: 60)
                    .opacity(0.1)};
                VStack {
                    Button(action: {
                        // Eldor do some magic
                    }) {
                        Image ("button2")
                            .resizable()
                            .frame(width: 40, height: 40)
                        .opacity(0.1)};
                    
                    Button(action: {
                        // Eldor do some magic
                    }) {
                        Image ("button1")
                            .resizable()
                            .frame(width: 60, height: 60)
                        .opacity(0.1)};}}
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
