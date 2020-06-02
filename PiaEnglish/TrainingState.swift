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
    @Published var now_training = false
    @Published var game_words: [Word] = []
    @Published var training_time = 0
    @Published var view_count = 0
    @Published var training_flow : [[String : [String : Any]]] = []
}

func training_match_translation_true_word(ts: TrainingState) -> Word {
    let dict = ts.training_flow[ts.view_count]["match_translation"]!
    return dict["true_word"] as! Word
}

func training_match_translation_all_words(ts: TrainingState) -> [Word] {
    let dict = ts.training_flow[ts.view_count]["match_translation"]!
    return dict["all_words"] as! [Word]
}

func training_spoken_match_true_word(ts: TrainingState) -> Word {
    let dict = ts.training_flow[ts.view_count]["spoken_match"]!
    return dict["true_word"] as! Word
}

func training_spoken_match_all_words(ts: TrainingState) -> [Word] {
    let dict = ts.training_flow[ts.view_count]["spoken_match"]!
    return dict["all_words"] as! [Word]
}

func training_match_word_words(ts: TrainingState) -> ([Word], [Word]) {
    let dict = ts.training_flow[ts.view_count]["match_word"]!
    return dict["words"] as! ([Word], [Word])
}

func training_word_search_grid(ts: TrainingState) -> [[String]] {
    let dict = ts.training_flow[ts.view_count]["word_search"]!
    return dict["grid"] as! [[String]]
}

func training_word_search_words(ts: TrainingState) -> [Word] {
    let dict = ts.training_flow[ts.view_count]["word_search"]!
    return dict["words"] as! [Word]
}

func training_cards_words(ts: TrainingState) -> [Word] {
    let dict = ts.training_flow[ts.view_count]["cards"]!
    return dict["words"] as! [Word]
}
