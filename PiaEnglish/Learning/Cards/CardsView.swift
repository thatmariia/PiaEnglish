//
//  CardsView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 01/06/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct CardsView: View {
    
    var words: [Word]
    
    @State var curr_i = 0
    @State var done = false
    
    var body: some View {
        return ZStack(alignment: .top){
            PiaBackground().edgesIgnoringSafeArea(.all)
            
            GeometryReader { geom in
                VStack{
                    
                    Spacer()
                    
                    VStack {
                        
                        Spacer()
                        
                        Text(format_string(str: self.words[self.curr_i].english)).font(.title).fontWeight(.bold)
                        Divider()
                        Text(format_string(str:self.words[self.curr_i].russian)).font(.body)
                        .foregroundColor(Color("GradEnd"))
                        
                        Spacer()
                        
                        Button(action: {
                            play_audio_of(word: self.words[self.curr_i].english)
                        }) {
                            Image(systemName: "play.fill").foregroundColor(.white).font(.system(size: 40))
                            
                        }
                        
                        Spacer()
                        
                    }
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: geom.size.width*0.8, height: geom.size.height*2/3, alignment: .center)
                        .background(Color.white.opacity(0.3)).cornerRadius(40)
                        .overlay(RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.white, lineWidth: 2)
                        )
                    
                    Spacer()
                    /// show next word card
                    Button(action: {
                        
                        if (self.curr_i == self.words.count-1) {
                            self.done = true
                        } else {
                            self.curr_i += 1
                        }
                        
                    }) {
                        Text(self.done ? "Completed" : "Next")
                    }.buttonStyle(NormalButtonStyle())
                    
                    Spacer()
                }
                
                
            }
        }.navigationBarTitle("").navigationBarHidden(true)
    }
}

/*
 struct CardsView_Previews: PreviewProvider {
 static var previews: some View {
 CardsView()
 }
 }*/
