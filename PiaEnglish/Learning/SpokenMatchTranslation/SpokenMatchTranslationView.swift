//
//  SpokenMatch.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 02/06/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct SpokenMatchTranslationView: View {
    
    @EnvironmentObject var training_state: TrainingState
    @EnvironmentObject var testing_state: TestingState
    
    var true_word: Word
    var all_words: [Word]
    
    @State var curr_selection = ""
    @State var done = false
    
    @State var correct_answer = false
    @State var clicked = false
    
    fileprivate func half_words(half: Int) -> [Word]{
        if all_words.count == 0 { return [] }
        if half == 1 {
            
            let end_half = Int(floor(Double(all_words.count) / 2.0))
            return Array(all_words[0..<end_half])
            
        } else {

            let start_half = Int(floor(Double(all_words.count) / 2.0))
            return Array(all_words[start_half..<all_words.count])
            
        }
    }
    
    fileprivate func correct_selection() -> Bool {
        if curr_selection == true_word.russian {
            return true
        }
        return false
    }
    
    fileprivate func rus_words(_ word: Word) -> some View {
        return VStack {
            Button(action: {
                self.curr_selection = word.russian
                if self.correct_selection() {
                    self.done = true
                }
                self.clicked = true
                if self.testing_state.now_testing {
                    if self.clicked && self.done {
                        self.correct_answer = true
                    }
                    self.curr_selection = self.true_word.russian
                    self.done = true
                }
            }) {
                HStack{
                    Spacer()
                    Text(format_string(str: word.russian))
                    Spacer()
                }
            }.buttonStyle(NormalSelectionButtonStyle(is_selected:
                
                (self.correct_selection() && word.russian == self.true_word.russian))
                )
                .disabled(correct_selection() || (self.clicked && self.testing_state.now_testing))
            
            Spacer().frame(height: 10)
            
        }.padding(5)
    }
    
    var body: some View {
        return  ZStack(alignment: .top){
        PiaBackground().edgesIgnoringSafeArea(.all)
            VStack{
                ProgressView()
                Spacer().frame(height: 15)
                
                Text("Match the spoken word").foregroundColor(.white)
                Spacer().frame(height: 8)
                Button(action: {
                    play_audio_of(word: self.true_word.english)
                }) {
                    Image(systemName: "play.fill").foregroundColor(.white).font(.system(size: 40))
                }
                
                Spacer().frame(height: 15)
                
                HStack {
                    
                    ScrollView(.vertical, showsIndicators: false){
                    VStack {
                        ForEach(half_words(half: 1)) { word in
                            self.rus_words(word)
                        }
                    }
                    }
                    
                    Spacer().frame(width: 8)
                    
                    ScrollView(.vertical){
                    VStack {
                        ForEach(half_words(half: 2)) { word in
                            self.rus_words(word)
                        }
                    }
                    }
                    
                }
                
                Spacer()
                
                //if done {
                    Button(action: {
                        if self.training_state.now_training{
                            self.training_state.view_count += 1
                            
                        } else if self.testing_state.now_testing{
                            if self.correct_answer {
                                self.testing_state.curr_total_score += 1
                                self.testing_state.cur_score_word[self.true_word]! += 1
                            }
                            self.correct_answer = false
                            self.clicked = false
                            self.testing_state.view_count += 1
                        }
                        self.done = false
                    }) {
                        Text("Next game")
                    }.buttonStyle(NormalButtonStyle(is_disabled: !done))
                        .disabled(!done)
                //}
                
                Spacer().frame(height: 8)

            }.padding()
        }.navigationBarTitle("").navigationBarHidden(true)
    }
}


