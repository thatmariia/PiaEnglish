//
//  LearnView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 25/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct LearnView: View {
    
    let gw = WordSearchGenerator(used_words: [], unused_words: ["meow", "woof"])
    
    var body: some View {
        
        VStack {
            
            Button(action: {
                self.gw.generate()
            }) {
                Text("button")
            }
            
        }
    }
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
    }
}
