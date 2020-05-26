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
    
    @State var new_word = Word(id: "", english: "", russian: "", learned_by: [])
    
    
    
    fileprivate func collection_words() -> ForEach<[Word], String, HStack<TupleView<(Text, Button<Text>)>>> {
        return ForEach(words_observer.words){ word in
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
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: true) {
                Text("coll name = " + collection_name)
                
                NavigationLink(destination: AddWordView(collection_name: collection_name, collection_words: words_observer.words)) {
                    Text("Add new word")
                }
                
                // TODO:: fix not appearing after adding a word
                if (words_observer.words.count > 0){
                    collection_words()
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
