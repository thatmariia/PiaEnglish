//
//  TrainView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 26/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct TrainView: View {
    
    @ObservedObject var words_observer: CollectionContentsObserver
    //var english_words: [String] /// the ones associated with chosen collections
    
    fileprivate func get_game_words() -> [Word] {
        var game_words: [Word] = []
        
        for word in words_observer.words {
            if !word.learned_by.contains(username){
                game_words.append(word)
            }
        }
        
        return game_words
    }
    
    fileprivate func get_matchwords_words() -> ([Word], [Word]) {
        let words = Array(get_game_words()[0..<min(5, get_game_words().count)])
        return (words.shuffled(), words.shuffled())
    }
    
    var body: some View {
        // TODO:: check for same words
        let game_words = get_game_words()
        let wordsearch = WordSearchGenerator(used_words: [], unused_words: game_words)
        wordsearch.generate()
        
        return  ZStack(alignment: .top){
            
            PiaBackground().edgesIgnoringSafeArea(.all)
            VStack {
                ///cards
                NavigationLink(destination: CardsView(words: get_game_words())) {
                    Text("Go to cards")
                }
                
                /// words matching
                NavigationLink(destination:
                MatchWordsView(words: get_matchwords_words())) {
                    Text("Go to words matching")
                }
                
                
                /// wordsearch
                NavigationLink(destination: WordSearchView(grid: wordsearch.grid,
                                                           words: wordsearch.cur_grid_words)){
                                                            Text("Go to word search")
                }
                
            }.padding()
            }.navigationBarTitle("").navigationBarHidden(true)
        
    }
}

/*
 struct TrainView_Previews: PreviewProvider {
 static var previews: some View {
 TrainView()
 }
 }
 */
