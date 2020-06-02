//
//  CardsView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 01/06/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct CardsView: View {
    
    @EnvironmentObject var training_state: TrainingState
    
    var words: [Word]
    
    @State var curr_i = 0
    @State var done = false
    //@State var finalized = false
    
    /*fileprivate func next_is(game_name: String) -> Bool {
        if self.training_state.view_count > self.training_state.training_flow.count-1 {
            return false
        }
        if let next_state = self.training_state.training_flow[self.training_state.view_count].keys.first {
            return next_state == game_name
        }
        return false
    }*/
    
    var body: some View {
        print(" CARDS: ", self.words)
        return  ZStack(alignment: .top){
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
                        
                        if (self.curr_i >= self.words.count-1) {
                            if !self.done {
                                self.done = true
                            } else {
                                self.curr_i = 0
                            }
                        } else {
                            self.curr_i += 1
                        }
                        
                    }) {
                        Text("Next word")
                    }.buttonStyle(NormalButtonStyle())
                    
                    Spacer()
                    
                    if self.done {
                        Button(action: {
                            if self.training_state.now_training{
                                self.training_state.view_count += 1
                                
                            }
                        }) {
                            Text("Next game")
                        }.buttonStyle(NormalButtonStyle())
                    }
                    
                    Spacer().frame(height: 8)
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
