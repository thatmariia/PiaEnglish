//
//  SpokenMatch.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 02/06/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct SpokenMatchView: View {
    
    @EnvironmentObject var training_state: TrainingState
    @EnvironmentObject var testing_state: TestingState
    
    var true_word: Word
    var all_words: [Word]
    
    @State var curr_selection = ""
    @State var done = false
    
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
            }) {
                HStack{
                    Spacer()
                    Text(format_string(str: word.english))
                    Spacer()
                }
            }.buttonStyle(NormalSelectionButtonStyle(is_selected:
                self.correct_selection() && word.english == self.true_word.english))
            .disabled(correct_selection())
            
            Spacer().frame(height: 10)
            
        }.padding(5)
    }
    
    var body: some View {
        return  ZStack(alignment: .top){
        PiaBackground().edgesIgnoringSafeArea(.all)
            VStack{
                ProgressView()
                Spacer().frame(height: 15)
                
                Text("Match the spoken word".uppercased()).foregroundColor(.white)
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
                            self.eng_words(word)
                        }
                    }
                    }
                    
                    Spacer().frame(width: 8)
                    
                    ScrollView(.vertical, showsIndicators: false){
                    VStack {
                        ForEach(half_words(half: 2)) { word in
                            self.eng_words(word)
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
                            self.testing_state.view_count += 1
                        }
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


