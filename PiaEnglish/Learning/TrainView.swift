//
//  TrainView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 26/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct TrainView: View {
    let gw = WordSearchGenerator(used_words: [], unused_words: ["meow", "woof", "wow"])
    
    var body: some View {
        self.gw.generate()
        return NavigationView{
            
            VStack {
                
                NavigationLink(destination: WordSearchView(grid: gw.grid, words: gw.cur_grid_words)){
                    Text("Go to word search")
                }

            }
        }
    }
}

struct TrainView_Previews: PreviewProvider {
    static var previews: some View {
        TrainView()
    }
}
