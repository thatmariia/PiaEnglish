//
//  WordSearchGenerator.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 25/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import Foundation

// TODO:: if a word is longer than grid size, make a snake thingie
class WordSearchGenerator {
    
    var used_words: [Word]//[String]
    var unused_words: [Word]//[String]
    var grid = [[String]]()
    var cur_grid_words: /*[String]*/ [Word] = []
    
    init(used_words: [Word],//[String],
         unused_words: [Word]) {//[String]) {
        if (unused_words.count == 0 && used_words.count > 0) {
            // When cycle repeats
            self.unused_words = used_words
            self.used_words = []
        }
        self.used_words = used_words
        self.unused_words = unused_words
        
        self.make_uppercase()
        
    }
    
    func make_uppercase() {
        for i in 0..<self.used_words.count {
            self.used_words[i].english = self.used_words[i].english.uppercased()
            self.used_words[i].russian = self.used_words[i].russian.uppercased()
        }
        for i in 0..<self.unused_words.count {
            self.unused_words[i].english = self.unused_words[i].english.uppercased()
            self.unused_words[i].russian = self.unused_words[i].russian.uppercased()
        }
    }
    
    func print_grid() {
        for i in 0..<grid_size{
            print(self.grid[i])
        }
    }
    
    func generate() {
        self.grid = self.empty_grid()
        
        let orientations = ["lr", "rl", "ud", "du"] // left-right, up-down
        let max_tries = Int(pow(Double(grid_size), 2)) * orientations.count*2
        
        self.cur_grid_words = []
        
        for word in self.unused_words {
            let eng_word = word.english
            var placed = false
            var tries_count = 0
            
            while (!placed) {
                if (tries_count >= max_tries){ break }
                tries_count += 1
                
                let orientation = orientations.randomElement()!
                
                var x_step = 0
                var y_step = 0
                
                
                switch orientation {
                case ("lr"):
                    x_step = 1
                case ("rl"):
                    x_step = -1
                case("ud"):
                    y_step = 1
                case("du"):
                    y_step = -1
                default:
                    continue
                }
                
                let x_start = Int.random(in: 0 ..< grid_size)
                let x_end = x_start + eng_word.count * x_step
                
                let y_start = Int.random(in: 0 ..< grid_size)
                let y_end = y_start + eng_word.count * y_step
                
                if !self.in_grid(x: x_end, y: y_end) { continue }
                
                if self.is_failed(word: eng_word, x_start: x_start, x_step: x_step, y_start: y_start, y_step: y_step) {
                    continue
                } else {
                    
                    for i in 0..<eng_word.count {
                        let ind = eng_word.index(eng_word.startIndex, offsetBy: i)
                        let char = String(eng_word[ind])
                        
                        let x_pos = x_start + i*x_step
                        let y_pos = y_start + i*y_step
                        
                        self.grid[x_pos][y_pos] = char
                    }
                    placed = true
                    
                    self.cur_grid_words.append(word)
                    
                    if (!self.used_words.contains(word)) {
                        self.used_words.append(word)
                    }
                    
                    if let index = self.unused_words.firstIndex(of: word) {
                        self.unused_words.remove(at: index)
                    }
                }
            }
        }
        
        for i in 0..<grid_size {
            for j in 0..<grid_size {
                if (self.grid[i][j] == "_") {
                    self.grid[i][j] = eng_capital_letters.randomElement()!
                }
            }
        }
        
        self.print_grid()
    }
    
    func is_failed(word: String, x_start: Int, x_step: Int, y_start: Int, y_step: Int) -> Bool{
        for i in 0..<word.count {
            let ind = word.index(word.startIndex, offsetBy: i)
            let char = String(word[ind])
            
            let x_pos = x_start + i*x_step
            let y_pos = y_start + i*y_step
            
            let pos_char = self.grid[x_pos][y_pos]
            if (pos_char != "_") {
                if (pos_char == char) {
                    continue
                } else {
                    return true
                }
            }
        }
        return false
    }
    
    func in_grid(x: Int, y: Int) -> Bool {
        if (x < 0 || x >= grid_size) { return false }
        if (y < 0 || y >= grid_size) { return false }
        return true
    }
    
    func empty_grid() -> [[String]]{
        let grid = [[String]](repeating: [String](repeating: "_", count: grid_size), count: grid_size)
        return grid
    }
    
}
