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
    
    fileprivate func next_is(game_name: String) -> Bool {
        if let next_state = self.training_state.training_flow[self.training_state.view_count].keys.first {
            return next_state == game_name
        }
        return false
    }
    
    var body: some View {
        print(" CARDS: ", self.words)
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
                        
                        if (self.curr_i >= self.words.count-1) {
                            if !self.done {
                                self.done = true
                                self.training_state.view_count += 1
                            }
                            self.curr_i = 0
                        } else {
                            self.curr_i += 1
                        }
                        
                    }) {
                        Text("Next word")
                    }.buttonStyle(NormalButtonStyle())
                    
                    Spacer()
                    
                    
                    if self.done {

                        if self.next_is(game_name: "match_translation") {
                            NavigationLink(destination:
                    
                                MatchTranslationView(true_word: match_translation_true_word(ts: self.training_state),
                                                     all_words: match_translation_all_words(ts: self.training_state))
                            ) { Text("Next game") }.buttonStyle(NormalButtonStyle())
                            
                        } else if self.next_is(game_name: "match_word") {
                            NavigationLink(destination:
                                
                                MatchWordsView(words: match_word_words(ts: self.training_state))
                                
                            ) { Text("Next game") }.buttonStyle(NormalButtonStyle())
                        
                        } else if self.next_is(game_name: "word_search") {
                            
                            NavigationLink(destination:
                                
                                WordSearchView(grid: word_search_grid(ts: self.training_state),
                                               words: word_search_words(ts: self.training_state))
                                
                            ) { Text("Next game") }.buttonStyle(NormalButtonStyle())
                            
                        } else {
                            NavigationLink(destination:
                                
                                FinishTrainView()
                            ) { Text("Finish") }.buttonStyle(NormalButtonStyle())
                                
                        }
                    }
                    
                    
                    
                    
                    
                    Button(action: {
                        self.training_state.view_count += 1
                        print("TRAINING STATE VIEW COUNT IN CARDS = ", self.training_state.view_count)
                    }) {
                        Text("ADD VIEW COUNT")
                    }
                    
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
