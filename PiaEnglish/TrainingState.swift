//
//  TrainingState.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 01/06/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import Foundation
import SwiftUI

class TrainingState : ObservableObject {
    @Published var view_count = 0
    @Published var training_flow : [[String : [String : Any]]] = []
}

func match_translation_true_word(ts: TrainingState) -> Word {
    let dict = ts.training_flow[ts.view_count]["match_translation"]!
    return dict["true_word"] as! Word
}

func match_translation_all_words(ts: TrainingState) -> [Word] {
    let dict = ts.training_flow[ts.view_count]["match_translation"]!
    return dict["all_words"] as! [Word]
}

func match_word_words(ts: TrainingState) -> ([Word], [Word]) {
    let dict = ts.training_flow[ts.view_count]["match_word"]!
    return dict["words"] as! ([Word], [Word])
}

func word_search_grid(ts: TrainingState) -> [[String]] {
    let dict = ts.training_flow[ts.view_count]["word_search"]!
    return dict["grid"] as! [[String]]
}

func word_search_words(ts: TrainingState) -> [Word] {
    let dict = ts.training_flow[ts.view_count]["word_search"]!
    return dict["words"] as! [Word]
}

func cards_words(ts: TrainingState) -> [Word] {
    let dict = ts.training_flow[ts.view_count]["cards"]!
    return dict["words"] as! [Word]
}

/*
func get_next_view(view_count: Int, training_flow: [[String : [String : Any]]]) -> NavigationLink<some View, some View> {
    if let next_view_name = training_flow[view_count].keys.first {
        let next = training_flow[view_count]
        
        switch next_view_name {
            
        case "match_translation":
            let true_word = next["match_translation"]!["true_word"]
            let all_words = next["match_translation"]!["all_words"]
            return NavigationLink(destination:
                MatchTranslationView(true_word: true_word as! Word, all_words: all_words as! [Word])
            ) { Text("Next game") }
        
        case "match_word":
            let words = next["match_word"]!["words"]
            return NavigationLink(destination:
                MatchWordsView(words: words as! ([Word], [Word]))
            ) { Text("Next game") }
        
        case "word_search":
            let grid = next["word_search"]!["grid"]
            let words = next["word_search"]!["words"]
            return
                WordSearchView(grid: grid as! [[String]], words: words as! [Word])
            
        default:
            print("unknown game :(")
            return Text("no next view")
        }
        
    } else {
        print("error game :(")
        return Text("error, no next view")
    }
}

*/
