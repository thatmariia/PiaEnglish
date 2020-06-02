//
//  MatchWordsView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 01/06/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct MatchWordsView: View {
    
    @EnvironmentObject var training_state: TrainingState
    @State var done = false
    
    var words: ([Word], [Word])
    @State var matched_indices: [Int] = []
    
    @State var curr_selection_eng: String = ""
    @State var curr_selection_rus: String = ""
    
    @State var matched_words: [Word] = []
    
    fileprivate func check_match(){
        if (curr_selection_rus == "" || curr_selection_eng == ""){ return }
        
        for word in words.0 {
            if (word.english == curr_selection_eng) &&
                (word.russian == curr_selection_rus) {
                matched_words.append(word)
            }
        }
        curr_selection_eng = ""
        curr_selection_rus = ""
    }
    
    fileprivate func is_enabled_eng(eng: String) -> Bool {
        for word in matched_words {
            if word.english == eng {
                return false
            }
        }
        return true
    }
    
    fileprivate func is_active_eng(eng: String) -> Bool {
        if !is_enabled_eng(eng: eng) {
            return true
        }
        if curr_selection_eng == eng {
            return true
        }
        return false
    }
    
    fileprivate func is_enabled_rus(rus: String) -> Bool {
        for word in matched_words {
            if word.russian == rus {
                return false
            }
        }
        return true
    }
    
    fileprivate func is_active_rus(rus: String) -> Bool {
        if !is_enabled_rus(rus: rus) {
            return true
        }
        if curr_selection_rus == rus {
            return true
        }
        return false
    }

    fileprivate func words_eng(word: Word) -> some View {
        return VStack{
            
            Button(action: {
                
                if self.curr_selection_eng == word.english {
                    self.curr_selection_eng = ""
                } else {
                    self.curr_selection_eng = word.english
                    self.check_match()
                    if (self.words.0.count == self.matched_words.count) {
                        self.done = true
                    }
                }
            }) {
                Text(format_string(str: word.english))
            }.buttonStyle(SelectionButtonStyle(is_active: is_active_eng(eng: word.english)))
            .disabled(!is_enabled_eng(eng: word.english))
            
            Spacer().frame(height: 10)
        }
    }
    
    fileprivate func words_rus(word: Word) -> some View {
        return VStack{
            
            Button(action: {
                
                if self.curr_selection_rus == word.russian {
                    self.curr_selection_rus = ""
                } else {
                    self.curr_selection_rus = word.russian
                    self.check_match()
                    if (self.words.0.count == self.matched_words.count) {
                        self.done = true
                    }
                }
            }) {
                Text(format_string(str: word.russian))
            }.buttonStyle(SelectionButtonStyle(is_active: is_active_rus(rus: word.russian)))
                .disabled(!is_enabled_rus(rus: word.russian))
            
            Spacer().frame(height: 10)
        }
    }
    
    var body: some View {
        
        return ZStack(alignment: .top){
        PiaBackground().edgesIgnoringSafeArea(.all)
            
            VStack{
                
                Text("Find matches").foregroundColor(.white)
                
                Spacer().frame(height: 15)
            
            HStack{
                 
                /// english words
                ScrollView(.vertical){
                VStack {
                    ForEach(words.0) { word in
                        self.words_eng(word: word)
                    }
                }
                }
                
                Spacer().frame(minWidth: 8)
                
                /// russian words
                ScrollView(.vertical){
                VStack {
                    ForEach(words.1) { word in
                        self.words_rus(word: word)
                    }
                }
                }
                
            }
                Spacer()
                
                if done {
                    Button(action: {
                        self.training_state.view_count += 1
                    }) {
                        Text("Next game")
                    }.buttonStyle(NormalButtonStyle())
                }
                
                Spacer().frame(height: 8)
        
            }.padding()
        
        
            }.navigationBarTitle("").navigationBarHidden(true)
        
    }
}

/*
struct MatchWordsView_Previews: PreviewProvider {
    static var previews: some View {
        MatchWordsView()
    }
}*/
