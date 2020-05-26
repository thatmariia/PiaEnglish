//
//  WordSearchView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 25/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct WordSearchView: View {
    
    var grid: [[String]]
    var words: [String]
    
    @State var found_words: [String] = []
    
    @State var curr_entry: [(Int, Int)] = []
    
    @State var grid_state = [[Bool]](repeating: [Bool](repeating: false, count: grid_size), count: grid_size)
    // -1 : not filled, 0 : filled, 1 : contains found
    @State var found_cells: [(Int, Int)] = []
    
    fileprivate func get_entry_str(entry: [(Int, Int)]) -> String {
        var entry_str = ""
        for cell in entry {
            let char = grid[cell.0][cell.1]
            entry_str += char
        }
        return entry_str
    }
    
    fileprivate func contains_word(entry: [(Int, Int)]) -> Bool{
        
        let entry_str = get_entry_str(entry: entry)
        
        for word in words {
            if (word.contains(entry_str)) && (!found_words.contains(word)){
                return true
            }
        }
        return false
    }
    
    fileprivate func found_word() -> (Bool, String) {
        
        let curr_entry_str = get_entry_str(entry: curr_entry)
        
        for i in 0..<words.count {
            if (words[i] == curr_entry_str) {
                return (true, curr_entry_str)
            }
        }
        return (false, "")
    }
    
    fileprivate func is_adjacent(x: Int, y: Int) -> Bool {
        
        if curr_entry.count == 0 {
            return true
        }
        
        let x_last = curr_entry[curr_entry.count-1].0
        let y_last = curr_entry[curr_entry.count-1].1
        
        /// if adjacent on x but now y or vice versa
        if (abs(x - x_last) == 1 && abs(y - y_last) == 0) ||
           (abs(x - x_last) == 0 && abs(y - y_last) == 1) {
            return true
        }
        return false
    }
    
    fileprivate func handle_attempt(i: Int, j: Int) {
        let curr_cell = (i,j)
        
        var attempted_entry = self.curr_entry
        attempted_entry.append(curr_cell)
        
        if (!self.grid_state[i][j]) &&
            self.is_adjacent(x: i, y: j) &&
            self.contains_word(entry: attempted_entry)
        {
            
            self.curr_entry.append(curr_cell)
            self.grid_state[i][j] = true
            
        } else if (self.grid_state[i][j]) &&
                  (self.curr_entry.count > 0) {
            
            if (self.curr_entry[self.curr_entry.count-1] == curr_cell){
                // only allow to delete the last entered char
                self.curr_entry = self.curr_entry.dropLast()
                self.grid_state[i][j] = false
            }
        }
        
        // now check if the word matches any in the words array
        let found_word = self.found_word()
        if found_word.0 {
            self.found_words.append(found_word.1)
            
            for cell in self.curr_entry {
                if (!cell_in_list(cell: cell, list: self.found_cells)) {
                    self.found_cells.append(cell)
                }
            }
            
            self.curr_entry = []
            grid_state = [[Bool]](repeating: [Bool](repeating: false, count: grid_size), count: grid_size)
        }
    }
    
    fileprivate func cell_in_list(cell: (Int, Int), list: [(Int, Int)]) -> Bool {
        for entry_cell in list {
            if entry_cell == cell {
                return true
            }
        }
        return false
    }

    fileprivate func get_color(i: Int, j: Int) -> Color{
        let cell = (i,j)
        if (cell_in_list(cell: cell, list: curr_entry)){
            return .red
        }
        return .green
    }
    
    var body: some View {
        NavigationView{
            VStack {
                
                VStack{
                    
                    Text("Words to find:")
                    ForEach(words, id: \.self) { word in
                        VStack {
                            
                            if (self.found_words.contains(word)) {
                                Text(word).italic()
                            } else {
                                Text(word)
                            }
                        }
                    }
                }
                
                Spacer()
                
                // grid here
                VStack {
                    ForEach(0..<grid_size, id: \.self) { i in
                        HStack(alignment: .center) {
                            Spacer()
                            ForEach(0..<grid_size, id: \.self) { j in
                                
                                HStack{
                                    ZStack{
                                        Button(action: {
                                            
                                            self.handle_attempt(i: i, j: j)
                                            
                                            print("hit " + self.grid[i][j])
                                        }) {
                                            Text(self.grid[i][j]).foregroundColor(self.get_color(i: i, j: j)).fontWeight(.heavy)
                                        }
                                    }
                                    Spacer()
                                }
                                
                            }
                            
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
}

/*struct WordSearchView_Previews: PreviewProvider {
 static var previews: some View {
 WordSearchView(grid: [["A", "B", "C"], ["D", "E", "F"], ["G", "H", "I"]])
 }
 }*/