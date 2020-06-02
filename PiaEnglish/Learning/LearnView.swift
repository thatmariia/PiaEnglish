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
    @EnvironmentObject var testing_state: TestingState
    // TODO:: check at least 4 words chosen
    
    //@ObservedObject var collections_observer: CollectionsObserver
    //@ObservedObject var all_words_observer: AllWordsObserver
    @EnvironmentObject var all_words_observer: AllWordsObserver
    @EnvironmentObject var collections_observer: CollectionsObserver
    

    
    fileprivate func training_next_is(game_name: String) -> Bool {
        if self.training_state.view_count > self.training_state.training_flow.count-1 {
            return false
        }
        if let next_state = self.training_state.training_flow[self.training_state.view_count].keys.first {
            return next_state == game_name
        }
        return false
    }
    
    fileprivate func testing_next_is(game_name: String) -> Bool {
        if self.testing_state.view_count > self.testing_state.testing_flow.count-1 {
            return false
        }
        if let next_state = self.testing_state.testing_flow[self.testing_state.view_count].keys.first {
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
                        
                        LearnSettingsView()
                        
                    } else if self.testing_state.now_testing {
                        
                        VStack{
                        
                            if self.testing_next_is(game_name: "spoken_match") {
                                
                                SpokenMatch(true_word: testing_spoken_match_true_word(ts: self.testing_state),
                                            all_words: testing_spoken_match_all_words(ts: self.testing_state))
                            
                            } else if self.testing_next_is(game_name: "match_translation") {
                                    
                                MatchTranslationView(true_word: testing_match_translation_true_word(ts: self.testing_state),
                                                     all_words: testing_match_translation_all_words(ts: self.testing_state))
                                
                            } else {
                                FinishTestView()
                            }
                        }.onAppear {
                            
                            let test_flow = GameFlow(game_words: self.testing_state.game_words, training_time: self.testing_state.training_time)
                            test_flow.construct_testing()
                            self.testing_state.testing_flow = test_flow.games
                            
                            // TODO:: init curr score word to empty [Word: Int] for each game word
                            // TODO:: reseat all this shit in the finish test view
                            self.testing_state.cur_score_word = [:]// empy
                            self.testing_state.max_score_word = test_flow.usages
                            
                            self.testing_state.max_total_score = test_flow.max_score
                            
                            print("*_*_* TEST FLOWWW ", self.testing_state.testing_flow)
                        }
                          
                    } else if self.training_state.now_training {
                        /// training
                        
                        VStack{
                            
                            if self.training_next_is(game_name: "cards") {
                                CardsView(words: training_cards_words(ts: self.training_state))
                            
                            } else if self.training_next_is(game_name: "spoken_match") {
                                
                                SpokenMatch(true_word: training_spoken_match_true_word(ts: self.training_state),
                                            all_words: training_spoken_match_all_words(ts: self.training_state))
                            
                            } else if self.training_next_is(game_name: "match_translation") {
                                    
                                MatchTranslationView(true_word: training_match_translation_true_word(ts: self.training_state),
                                                     all_words: training_match_translation_all_words(ts: self.training_state))
                                
                            } else if self.training_next_is(game_name: "match_word") {
                                    
                                MatchWordsView(words: training_match_word_words(ts: self.training_state))
                                    
                                
                            } else if self.training_next_is(game_name: "word_search") {
                                
                                    
                                WordSearchView(grid: training_word_search_grid(ts: self.training_state),
                                               words: training_word_search_words(ts: self.training_state))
                                
                            } else {
                                    
                                    FinishTrainView()
                                
                            }
                            
                        }.onAppear {
                            let train_flow = GameFlow(game_words: self.training_state.game_words, training_time: self.training_state.training_time)
                            train_flow.construct_training()
                            self.training_state.training_flow = train_flow.games
                            print("*_*_* TRAIN FLOWWW ", self.training_state.training_flow)
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
