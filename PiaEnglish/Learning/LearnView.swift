//
//  LearnView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 25/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct LearnView: View {
    @EnvironmentObject var training_state: TrainingState
    // TODO:: check at least 4 words chosen
    
    @ObservedObject var collections_observer: CollectionsObserver
    //@ObservedObject var all_words_observer: AllWordsObserver
    @EnvironmentObject var all_words_observer: AllWordsObserver
    

    
    fileprivate func next_is(game_name: String) -> Bool {
        if self.training_state.view_count > self.training_state.training_flow.count-1 {
            return false
        }
        if let next_state = self.training_state.training_flow[self.training_state.view_count].keys.first {
            return next_state == game_name
        }
        return false
    }
    
    var body: some View {
        
        return NavigationView{
            ZStack(alignment: .top){
                
                PiaBackground().edgesIgnoringSafeArea(.all)
                GeometryReader{geom in
                    
                    if !self.training_state.now_training {
                        
                        LearnSettingsView(collections_observer: CollectionsObserver()/*, all_words_observer: AllWordsObserver()*/)
                        
                    } else if self.training_state.now_training {
                        /// training
                        
                        VStack{
                            
                            if self.next_is(game_name: "cards") {
                                CardsView(words: cards_words(ts: self.training_state))
                            
                            } else if self.next_is(game_name: "match_translation") {
                                //NavigationLink(destination:
                                    
                                MatchTranslationView(true_word: match_translation_true_word(ts: self.training_state),
                                                     all_words: match_translation_all_words(ts: self.training_state))
                                //) { Text("Next game") }.buttonStyle(NormalButtonStyle())
                                
                            } else if self.next_is(game_name: "match_word") {
                                //NavigationLink(destination:
                                    
                                MatchWordsView(words: match_word_words(ts: self.training_state))
                                    
                                //) { Text("Next game") }.buttonStyle(NormalButtonStyle())
                                
                            } else if self.next_is(game_name: "word_search") {
                                
                                //NavigationLink(destination:
                                    
                                WordSearchView(grid: word_search_grid(ts: self.training_state),
                                               words: word_search_words(ts: self.training_state))
                                    
                                //) { Text("Next game") }.buttonStyle(NormalButtonStyle())
                                
                            } else {
                                //NavigationLink(destination:
                                    
                                    FinishTrainView()
                                //) { Text("Finish") }.buttonStyle(NormalButtonStyle())
                                
                                
                            }
                            
                        }.onAppear {
                            let train_flow = TrainFlow(game_words: self.training_state.game_words, training_time: self.training_state.training_time)
                            train_flow.construct()
                            self.training_state.training_flow = train_flow.games
                            print("*_*_* FLOWWW ", self.training_state.training_flow)
                        }
                        
                        
                    }
                }
            }.navigationBarTitle("").navigationBarHidden(true)
        }
    }
}

/*
 struct LearnView_Previews: PreviewProvider {
 static var previews: some View {
 LearnView()
 }
 }
 */
