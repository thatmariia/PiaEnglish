//
//  MatchTranslation.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 01/06/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct MatchTranslation: View {
    
    var true_word: Word
    var all_words: [Word]
    
    var body: some View {
        return ZStack(alignment: .top){
        PiaBackground().edgesIgnoringSafeArea(.all)
            VStack{
                
                Text("Choose a correct translation for")
                Text(true_word.russian)
                
                
                
            }
        }.navigationBarTitle("").navigationBarHidden(true)
        
        
    }
}

/*
struct MatchTranslation_Previews: PreviewProvider {
    static var previews: some View {
        MatchTranslation()
    }
}*/
