//
//  TrainFlow.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 02/06/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import Foundation

class GameFlow {
    
    var game_words: [Word]
    var training_time: Int
    var games: [[String : [String : Any]]] = []
    var init_usages: [Word: Int] = [:]
    var usages: [Word: Int] = [:]
    var max_score = 0
    
    init(game_words: [Word], training_time: Int) {
        self.game_words = game_words
        self.training_time = training_time
    }
    
    func construct_testing() {
        let mt = get_match_translation()
        let match_translations = mt.0
        let mt_usage = mt.1
        
        let smt = get_spoken_match_translations()
        let spoken_matches = smt.0
        let smt_usage = smt.1
        
        let cc = get_check_correctness()
        let check_correctness = cc.0
        let ss_usage = cc.1
        
        var games = match_translations + spoken_matches + check_correctness
        games = games.shuffled()
        games = games.shuffled()
        
        self.games = games
        
        let total_usages = _get_total_usages(from: [mt_usage, smt_usage, ss_usage])
        self.usages = total_usages.0
        self.init_usages = total_usages.1
        self.max_score = total_usages.2
    }
    
    func _get_total_usages(from usages: [[Int]]) -> ([Word : Int], [Word : Int], Int) {
        var init_usages: [Word : Int] = [:]
        var total_usages: [Word : Int] = [:]
        var sum = 0
        
        for i in 0..<self.game_words.count {
            init_usages[game_words[i]] = 0
            total_usages[game_words[i]] = 0
            
            for usage in usages {
                total_usages[game_words[i]]! += usage[i]
                sum += usage[i]
            }
        }
        
        return (total_usages, init_usages, sum)
    }
    
    func construct_training() {
        let cards = get_cards().0
        let match_translations = get_match_translation().0
        let match_words = get_match_words().0
        let word_searches = get_word_search().0
        let spoken_matches = get_spoken_matches().0
        
        var games: [[String : [String : Any]]]
        if word_searches.count > 0 {
            games = match_translations + match_words + word_searches + spoken_matches
        } else {
            games = match_translations + match_words + spoken_matches
        }
        games = games.shuffled()
        games = games.shuffled()
        
        self.games = cards + games
    }
    
    func _exhausted(usage: [Int]) -> Bool {
        for u in usage {
            if u < training_time { return false }
        }
        return true
    }
    
    func _get_least_exhausted(from usage: [Int]) -> Int{
        return usage.firstIndex(of: usage.min()!)!
    }
    
    func get_check_correctness() -> ([[String : [String : Any]]], [Int]) {
        var usage = [Int](repeating: 0, count: self.game_words.count)
        var check_correctnesses: [[String : [String : Any]]] = []
        
        while !self._exhausted(usage: usage) {
            let li = _get_least_exhausted(from: usage)
            let true_word = self.game_words[li]
            usage[li] += 1
            
            let check_correctness1 = ["check_correctness" : [
                "true_word" : true_word,
                "wrong_word" : true_word
            ]]
            check_correctnesses.append(check_correctness1)
            
            var wrong_word = true_word
            while wrong_word == true_word {
                let i = Int.random(in: 0..<usage.count)
                let word = self.game_words[i]
                if true_word != word {
                    wrong_word = word
                    break
                }
            }
            
            usage[li] += 1
            let check_correctness2 = ["check_correctness" : [
                "true_word" : true_word,
                "wrong_word" : wrong_word
            ]]
            check_correctnesses.append(check_correctness2)
        }
        return (check_correctnesses, usage)
    }
    
    func get_spoken_match_translations() -> ([[String : [String : Any]]], [Int]) {
        var usage = [Int](repeating: 0, count: self.game_words.count)
        var spoken_matches: [[String : [String : Any]]] = []
        
        while !self._exhausted(usage: usage) {
            /// getting true word
            let li = _get_least_exhausted(from: usage)
            let true_word = self.game_words[li]
            usage[li] += 1
            
            /// getting the other 3 words
            var all_words: [Word] = [true_word]
            while all_words.count < min(Int.random(in: 6..<16), self.game_words.count) {
                let i = Int.random(in: 0..<usage.count)
                let word = self.game_words[i]
                if  !all_words.contains(word){
                    all_words.append(word)
                }
            }
            
            let spoken_match = ["spoken_match_translation" : [
                "true_word" : true_word,
                "all_words" : all_words.shuffled()
            ]]
            spoken_matches.append(spoken_match)
        }
        return (spoken_matches, usage)
    }
    
    func get_spoken_matches() -> ([[String : [String : Any]]], [Int]) {
        var usage = [Int](repeating: 0, count: self.game_words.count)
        var spoken_matches: [[String : [String : Any]]] = []
        
        while !self._exhausted(usage: usage) {
            /// getting true word
            let li = _get_least_exhausted(from: usage)
            let true_word = self.game_words[li]
            usage[li] += 1
            
            /// getting the other 3 words
            var all_words: [Word] = [true_word]
            while all_words.count < min(Int.random(in: 6..<16), self.game_words.count) {
                let i = Int.random(in: 0..<usage.count)
                let word = self.game_words[i]
                if  !all_words.contains(word){
                    all_words.append(word)
                }
            }
            
            let spoken_match = ["spoken_match" : [
                "true_word" : true_word,
                "all_words" : all_words.shuffled()
            ]]
            spoken_matches.append(spoken_match)
        }
        return (spoken_matches, usage)
    }
    
    func get_cards() -> ([[String : [String : Any]]], [Int]) {
        var cards: [[String : [String : Any]]] = []
        for _ in 0..<1/*self.training_time*/ {
            let card = ["cards" : [
                "words" : self.game_words
                ]]
            cards.append(card)
        }
        return (cards, [])
    }
    
    func get_match_translation() -> ([[String : [String : Any]]], [Int]) {
        var usage = [Int](repeating: 0, count: self.game_words.count)
        var match_translations: [[String : [String : Any]]] = []
        
        while !self._exhausted(usage: usage) {
            
            /// getting the least used word index and making it true word
            let li = _get_least_exhausted(from: usage)
            let true_word = self.game_words[li]
            usage[li] += 1
            
            /// getting the other 3 words
            var all_words: [Word] = [true_word]
            while all_words.count < min(Int.random(in: 4..<10), self.game_words.count) {
                let i = Int.random(in: 0..<usage.count)
                let word = self.game_words[i]
                if  !all_words.contains(word){
                    all_words.append(word)
                }
            }
            
            let match_translation = ["match_translation" : [
                "true_word" : true_word,
                "all_words" : all_words.shuffled()
            ]]
            match_translations.append(match_translation)
        }
        
        return (match_translations, usage)
    }
    
    func get_match_words() -> ([[String : [String : Any]]], [Int]) {
        var usage = [Int](repeating: 0, count: self.game_words.count)
        var match_words: [[String : [String : Any]]] = []
        
        while !self._exhausted(usage: usage) {
            
            /// picking some least used words
            var words: [Word] = []
            while words.count < min(Int.random(in: 6..<16), self.game_words.count) {
                let i1 = _get_least_exhausted(from: usage)
                let i2 = Int.random(in: 0..<usage.count)
                let i = [i1, i2].randomElement()!
                let word = self.game_words[i]
                if !words.contains(word) {
                    words.append(word)
                    usage[i] += 1
                }
            }
            let match_word = ["match_word" : [
                "words" : (words.shuffled(), words.shuffled())
            ]]
            match_words.append(match_word)
        }
        return (match_words, usage)
    }
    
    func get_word_search() -> ([[String : [String : Any]]], [Int]) {
        /// select all the words that are <= the size of the grid
        var allowed_words: [Word] = []
        for word in self.game_words {
            if word.english.count < grid_size {
                let cap_word = Word(id: word.id,
                                    english: word.english.uppercased(),
                                    russian: word.russian.uppercased(),
                                    learned_by: word.learned_by)
                allowed_words.append(cap_word)
            }
        }
        
        if allowed_words.count == 0 {
            return ([], [])
        }
        
        allowed_words = allowed_words.sorted { (a, b) -> Bool in
            return a.english.count > b.english.count
        }
        
        var usage = [Int](repeating: 0, count: allowed_words.count)
        var word_searches: [[String : [String : Any]]] = []
        
        var using_words = allowed_words
        
        while !self._exhausted(usage: usage) {
            
            /// making a new wordsearch
            let wordsearch = WordSearchGenerator(used_words: [], unused_words: using_words)
            wordsearch.generate()
            /// incrementing usages
            print("GRID WORDS = ", wordsearch.cur_grid_words)
            for grid_word in wordsearch.cur_grid_words {
                let index = allowed_words.firstIndex(of: grid_word)!
                usage[index] += 1
                print("INDEX = ", index)
            }
            /// prioritizing unused words and randomly adding others for the next go
            using_words = wordsearch.unused_words
            for word in allowed_words.shuffled() {
                if !using_words.contains(word) {
                    using_words.append(word)
                }
            }
            
            let word_search = ["word_search" : [
                "grid" : wordsearch.grid,
                "words" : wordsearch.cur_grid_words
            ]]
            word_searches.append(word_search)
            print("USAGE = ", usage)
        }
        return (word_searches, usage)
    }
    
}
