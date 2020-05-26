//
//  TrainView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 26/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct TrainView: View {
    
    @ObservedObject var words_observer: CollectionContentsObserver
    var english_words: [String] /// the ones associated with chosen collections
    
    fileprivate func get_game_words() -> [String] {
        var game_words: [String] = []
        let words = words_observer.words
        for word in words {
            game_words.append(word.english)
        }
        print("game words = ", game_words)
        return game_words
    }
    
    var body: some View {
        let game_words = get_game_words()
        let wordsearch = WordSearchGenerator(used_words: [], unused_words: game_words)
        wordsearch.generate()
        
        return NavigationView{
            
            VStack {
                
                NavigationLink(destination: WordSearchView(grid: wordsearch.grid,
                                                           words: wordsearch.cur_grid_words)){
                    Text("Go to word search")
                }

            }
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
