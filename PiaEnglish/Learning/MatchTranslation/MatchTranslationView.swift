//
//  MatchTranslation.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 01/06/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct MatchTranslationView: View {
    
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
        if curr_selection == true_word.english {
            return true
        }
        return false
    }
    
    fileprivate func eng_words(_ word: Word) -> some View {
        return VStack {
            Button(action: {
                self.curr_selection = word.english
                if self.correct_selection() {
                    self.done = true
                }
                self.clicked = true
                
                if self.testing_state.now_testing {
                    if self.clicked && self.done {
                        self.correct_answer = true
                    }
                    self.curr_selection = self.true_word.english
                    self.done = true
                }
                
            }) {
                Text(format_string(str: word.english))
            }.buttonStyle(NormalSelectionButtonStyle(is_selected:
                (self.correct_selection() && word.english == self.true_word.english))
            )
            .disabled(correct_selection() || (self.clicked && self.testing_state.now_testing))
            
            Spacer().frame(height: 10)
            
        }.padding(5)
    }
    
    var body: some View {
        return  ZStack(alignment: .top){
        PiaBackground().edgesIgnoringSafeArea(.all)
            VStack{
                
                Text("Choose a correct translation for").foregroundColor(.white)
                Text(format_string(str: true_word.russian))
                    .font(.title).fontWeight(.bold).foregroundColor(.white)
                
                Spacer().frame(height: 15)
                
                HStack {
                    
                    ScrollView(.vertical){
                    VStack {
                        ForEach(half_words(half: 1)) { word in
                            self.eng_words(word)
                        }
                    }
                    }
                    
                    Spacer().frame(minWidth: 8)
                    
                    ScrollView(.vertical){
                    VStack {
                        ForEach(half_words(half: 2)) { word in
                            self.eng_words(word)
                        }
                    }
                    }
                    
                }
                
                Spacer()
                
                if done {
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
                    }.buttonStyle(NormalButtonStyle())
                }
                
                Spacer().frame(height: 8)
            }.padding()
        }.navigationBarTitle("").navigationBarHidden(true)
        
        
        
    }
}
