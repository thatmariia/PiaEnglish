//
//  TestingState.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 02/06/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import Foundation

class TestingState : ObservableObject {
    @Published var now_testing = false
    @Published var game_words: [Word] = []
    @Published var training_time = 1
    @Published var view_count = 0
    @Published var testing_flow : [[String : [String : Any]]] = []
    
    @Published var curr_total_score = 0
    @Published var max_total_score = 0
    
    @Published var cur_score_word: [Word: Int] = [:]
    @Published var max_score_word: [Word: Int] = [:]
}

func testing_match_translation_true_word(ts: TestingState) -> Word {
    let dict = ts.testing_flow[ts.view_count]["match_translation"]!
    return dict["true_word"] as! Word
}

func testing_match_translation_all_words(ts: TestingState) -> [Word] {
    let dict = ts.testing_flow[ts.view_count]["match_translation"]!
    return dict["all_words"] as! [Word]
}

func testing_spoken_match_true_word(ts: TestingState) -> Word {
    let dict = ts.testing_flow[ts.view_count]["spoken_match"]!
    return dict["true_word"] as! Word
}

func testing_spoken_match_all_words(ts: TestingState) -> [Word] {
    let dict = ts.testing_flow[ts.view_count]["spoken_match"]!
    return dict["all_words"] as! [Word]
}

func testing_spoken_match_translation_true_word(ts: TestingState) -> Word {
    let dict = ts.testing_flow[ts.view_count]["spoken_match_translation"]!
    return dict["true_word"] as! Word
}

func testing_spoken_match_translation_all_words(ts: TestingState) -> [Word] {
    let dict = ts.testing_flow[ts.view_count]["spoken_match_translation"]!
    return dict["all_words"] as! [Word]
}
