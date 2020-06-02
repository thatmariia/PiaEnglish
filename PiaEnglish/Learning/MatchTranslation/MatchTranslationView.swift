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
    
    var true_word: Word
    var all_words: [Word]
    
    @State var curr_selection = ""
    @State var done = false
    
    fileprivate func next_is(game_name: String) -> Bool {
        if let next_state = self.training_state.training_flow[self.training_state.view_count].keys.first {
            return next_state == game_name
        }
        return false
    }
    
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
                    self.training_state.view_count += 1
                    self.done = true
                }
            }) {
                Text(format_string(str: word.english))
            }.buttonStyle(NormalSelectionButtonStyle(is_selected:
                self.correct_selection() && word.english == self.true_word.english))
            .disabled(correct_selection())
            
            Spacer().frame(height: 10)
            
        }.padding(5)
    }
    
    var body: some View {
        return ZStack(alignment: .top){
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
                
                Spacer()
            }.padding()
        }.navigationBarTitle("").navigationBarHidden(true)
        
        
    }
}

/*
struct MatchTranslation_Previews: PreviewProvider {
    static var previews: some View {
        MatchTranslation()
    }
}*/
