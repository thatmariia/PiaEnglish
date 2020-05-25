//
//  CollectionContentsView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 25/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct CollectionContentsView: View {
    
    var collection_name: String
    var words_observer: CollectionContentsObserver
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            Text("coll name = " + collection_name)
            
            
            ForEach(words_observer.words){ word in
                HStack{
                    Text(word.english)
                    Button(action: {
                        print("hit play")
                        play_audio_of(word: word.english)
                    }) {
                        Text("play")
                    }
                }
            }
        }
    }
}

/*
struct CollectionContentsView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionContentsView()
    }
}
*/
