//
//  CheckCorrectnessView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 02/06/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct CheckCorrectnessView: View {
    @EnvironmentObject var training_state: TrainingState
    @EnvironmentObject var testing_state: TestingState
    
    var true_word: Word
    var wrong_word: Word
    
    @State var curr_i = 0
    @State var done = false
    
    @State var correct_answer = false
    @State var clicked = false
    
    
    var body: some View {
        return  ZStack(alignment: .top){
            PiaBackground().edgesIgnoringSafeArea(.all)
            
            VStack{
                
                Text("Check whether the translation is correct").foregroundColor(.white)
                Spacer().frame(height: 10)
                
                GeometryReader { geom in
                    VStack{
                        
                        Spacer()
                        
                        Text(format_string(str: self.true_word.english)).font(.title).fontWeight(.bold)
                        Divider()
                        Text(format_string(str: self.wrong_word.russian)).font(.title).fontWeight(.bold)
                        
                        Spacer()
                        
                        if self.testing_state.now_testing && self.done && !self.correct_answer {
                            Spacer().frame(height: 10)
                            Text("Correct translation: " + format_string(str: self.true_word.russian)).foregroundColor(Color("GradEnd"))
                            Spacer().frame(height: 8)
                        }
                        
                        
                        
                    }.foregroundColor(.white)
                        .frame(width: geom.size.width, height: geom.size.height/2, alignment: .center)
                        .background(Color.white.opacity(0.3)).cornerRadius(40)
                        .overlay(RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.white, lineWidth: 2)
                    )
                }
                
                Spacer()
                
                HStack{
                
                    Button(action: {
                        play_audio_of(word: self.true_word.english)
                        self.clicked = true
                        /// is wrong?
                        if self.true_word.english != self.wrong_word.english {
                            self.correct_answer = true
                            self.done = true
                        }
                        if self.testing_state.now_testing {
                            self.done = true
                        }
                    }) {
                        Image(systemName: "multiply").font(.system(size: 40)).fixedSize().frame(width: 60, height: 60)
                    }
                    .buttonStyle(NormalSelectionButtonStyle(is_selected:
                        (correct_answer && self.true_word.english != self.wrong_word.english) ||
                        (testing_state.now_testing && clicked && self.true_word.english != self.wrong_word.english)
                    ))
                        .disabled((correct_answer) || (testing_state.now_testing && clicked))
                    
                    Spacer()
                    
                    Button(action: {
                        play_audio_of(word: self.true_word.english)
                        self.clicked = true
                        /// is right?
                        if self.true_word.english == self.wrong_word.english {
                            self.correct_answer = true
                            self.done = true
                        }
                        if self.testing_state.now_testing {
                            self.done = true
                        }
                    }) {
                        Image(systemName: "checkmark").font(.system(size: 40)).fixedSize().frame(width: 60, height: 60)
                        }
                    .buttonStyle(NormalSelectionButtonStyle(is_selected:
                        (correct_answer && self.true_word.english == self.wrong_word.english) ||
                        (testing_state.now_testing && clicked && self.true_word.english == self.wrong_word.english)
                    ))
                        .disabled((correct_answer) || (testing_state.now_testing && clicked))
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


