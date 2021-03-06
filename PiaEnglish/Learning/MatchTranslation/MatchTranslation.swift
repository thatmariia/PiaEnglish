//
//  MatchTranslation.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 01/06/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct MatchTranslationView: View {
    
    var true_word: Word
    var all_words: [Word]
    
    @State var curr_selection = ""
    
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
            }) {
                Text(format_string(str: word.english))
            }.buttonStyle(NormalSelectionButtonStyle(is_selected: self.correct_selection()))
            .disabled(correct_selection())
            
        }
    }
    
    var body: some View {
        return ZStack(alignment: .top){
        PiaBackground().edgesIgnoringSafeArea(.all)
            VStack{
                
                Text("Choose a correct translation for").foregroundColor(.white)
                Text(format_string(str: true_word.russian))
                    .font(.title).fontWeight(.bold).foregroundColor(.white)
                
                Spacer()
                
                HStack {
                    
                    ScrollView(.vertical){
                    VStack {
                        ForEach(half_words(half: 1)) { word in
                            self.eng_words(word)
                        }
                    }
                    }
                    
                    ScrollView(.vertical){
                    VStack {
                        ForEach(half_words(half: 2)) { word in
                            self.eng_words(word)
                        }
                    }
                    }
                    
                }
                
                Spacer()
                
                if correct_selection() {
                    Text("Correct!")
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
