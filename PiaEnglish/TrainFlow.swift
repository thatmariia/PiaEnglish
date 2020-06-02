//
//  TrainFlow.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 02/06/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import Foundation

class TrainFlow {
    
    var game_words: [Word]
    var training_time: Int
    var games: [[String : [String : Any]]] = []
    
    init(game_words: [Word], training_time: Int) {
        self.game_words = game_words
        self.training_time = training_time
    }
    
    func construct(){
        let cards = get_cards()
        let match_translations = get_match_translation()
        let match_words = get_match_words()
        let word_searches = get_word_search()
        
        var games = match_translations + match_words + word_searches
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
    
    func get_cards() -> [[String : [String : Any]]] {
        var cards: [[String : [String : Any]]] = []
        for _ in 0..<1/*self.training_time*/ {
            let card = ["Cards" : [
                "words" : self.game_words
                ]]
            cards.append(card)
        }
        return cards
    }
    
    func get_match_translation() -> [[String : [String : Any]]] {
        var usage = [Int](repeating: 0, count: self.game_words.count)
        var match_translations: [[String : [String : Any]]] = []
        
        while !self._exhausted(usage: usage) {
            
            /// getting the least used word index and making it true word
            let li = _get_least_exhausted(from: usage)
            let true_word = self.game_words[li]
            usage[li] += 1
            
            /// getting the other 3 words
            var all_words: [Word] = [true_word]
            while all_words.count < min(4, self.game_words.count) {
                let i = Int.random(in: 0..<usage.count)
                let word = self.game_words[i]
                if  !all_words.contains(word){
                    all_words.append(word)
                    //usage[i] += 1
                }
            }
            
            let match_translation = ["match_translation" : [
                "true_word" : true_word,
                "all_words" : all_words
            ]]
            match_translations.append(match_translation)
        }
        
        return match_translations
    }
    
    func get_match_words() -> [[String : [String : Any]]] {
        var usage = [Int](repeating: 0, count: self.game_words.count)
        var match_words: [[String : [String : Any]]] = []
        
        while !self._exhausted(usage: usage) {
            
            /// picking some least used words
            var words: [Word] = []
            while words.count < min(8, self.game_words.count) {
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
        return match_words
    }
    
    func get_word_search() -> [[String : [String : Any]]] {
        /// select all the words that are <= the size of the grid
        var allowed_words: [Word] = []
        for word in self.game_words {
            if word.english.count <= grid_size {
                let cap_word = Word(id: word.id,
                                    english: word.english.uppercased(),
                                    russian: word.russian.uppercased(),
                                    learned_by: word.learned_by)
                allowed_words.append(cap_word)
            }
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
            for grid_word in wordsearch.cur_grid_words {
                let index = allowed_words.firstIndex(of: grid_word)!
                usage[index] += 1
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
        }
        return word_searches
    }
    
}
