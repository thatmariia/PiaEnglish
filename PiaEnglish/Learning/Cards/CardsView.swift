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
    @EnvironmentObject var testing_state: TestingState
    
    var words: [Word]
    
    @State var curr_i = 0
    @State var done = false
    
    var body: some View {
        return  ZStack(alignment: .top){
            PiaBackground().edgesIgnoringSafeArea(.all)
            
            VStack{
                ProgressView()
                Spacer().frame(height: 15)
            
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
                    //.padding()
                    .frame(width: geom.size.width, height: geom.size.height*2/3, alignment: .center)
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
                            }
                            self.curr_i = 0
                            play_audio_of(word: self.words[self.curr_i].english)
                            
                        } else {
                            self.curr_i += 1
                            play_audio_of(word: self.words[self.curr_i].english)
                        }
                        
                    }) {
                        Text("Next word")
                    }.buttonStyle(NormalButtonStyle(is_disabled: false))
                    
                    Spacer()
                    
                    //if self.done {
                        Button(action: {
                            if self.training_state.now_training{
                                self.training_state.view_count += 1
                                
                            } else if self.testing_state.now_testing{
                                self.testing_state.view_count += 1
                            }
                        }) {
                            Text("Next game")
                        }.buttonStyle(NormalButtonStyle(is_disabled: !self.done))
                            .disabled(!self.done)
                    //}
                    
                    Spacer().frame(height: 8)
                }
                }.padding()
                
            }.onAppear {
                play_audio_of(word: self.words[self.curr_i].english)
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
