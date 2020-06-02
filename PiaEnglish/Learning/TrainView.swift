//
//  TrainView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 26/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct TrainView: View {
    
    @EnvironmentObject var training_state: TrainingState
    
    @ObservedObject var words_observer: CollectionContentsObserver
    
    var training_time: Int
    
    fileprivate func next_is(game_name: String) -> Bool {
        if self.training_state.view_count > self.training_state.training_flow.count-1 {
            return false
        }
        if let next_state = self.training_state.training_flow[self.training_state.view_count].keys.first {
            return next_state == game_name
        }
        return false
    }
    
    fileprivate func get_game_words() -> [Word] {
        var game_words: [Word] = []
        
        for word in words_observer.words {
            if !word.learned_by.contains(username) && !game_words.contains(word){
                game_words.append(word)
            }
        }
        return game_words
    }
    
    var body: some View {
        
        let game_words = get_game_words()
        
        return ZStack(alignment: .top){
            
            PiaBackground().edgesIgnoringSafeArea(.all)
            
            VStack{
                
                if next_is(game_name: "cards") {
                    CardsView(words: cards_words(ts: training_state))
                
                } else if next_is(game_name: "match_translation") {
                    //NavigationLink(destination:
                        
                        MatchTranslationView(true_word: match_translation_true_word(ts: training_state),
                                             all_words: match_translation_all_words(ts: training_state))
                    //) { Text("Next game") }.buttonStyle(NormalButtonStyle())
                    
                } else if next_is(game_name: "match_word") {
                    //NavigationLink(destination:
                        
                        MatchWordsView(words: match_word_words(ts: training_state))
                        
                    //) { Text("Next game") }.buttonStyle(NormalButtonStyle())
                    
                } else if next_is(game_name: "word_search") {
                    
                    //NavigationLink(destination:
                        
                        WordSearchView(grid: word_search_grid(ts: training_state),
                                       words: word_search_words(ts: training_state))
                        
                    //) { Text("Next game") }.buttonStyle(NormalButtonStyle())
                    
                } else {
                    //NavigationLink(destination:
                        
                        FinishTrainView()
                    //) { Text("Finish") }.buttonStyle(NormalButtonStyle())
                    
                }
                
            }
            
            
            /*
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
             
             }*/
            
        }
        .onAppear {
            let train_flow = TrainFlow(game_words: game_words, training_time: self.training_time)
            train_flow.construct()
            self.training_state.training_flow = train_flow.games
            print("*_*_* FLOWWW ", self.training_state.training_flow)
        }
        
        
    }
}

/*
 struct TrainView_Previews: PreviewProvider {
 static var previews: some View {
 TrainView()
 }
 }
 */
