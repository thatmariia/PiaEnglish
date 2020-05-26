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
    
    @State var searching = false
    @State var adding = false
    
    @State var new_word = Word(id: "", english: "", russian: "", learned_by: [])
    
    fileprivate func word_entered() -> Bool {
        if new_word.english.count > 0 && new_word.russian.count > 0 {
            return true
        }
        return false
    }
    
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
        ScrollView(.vertical, showsIndicators: true) {
            Text("coll name = " + collection_name)
            
            // TODO:: add a new word
            Button(action: {
                self.searching = true
                // TODO:: search for a word in db
            }) {
                Text("Search for new word")
            }
            
            if searching{
                
                Button(action: {
                    self.adding = true
                }) {
                    Text("Add new word")
                }
                
                if adding {
                    Text("english:")
                    TextField("english", text: $new_word.english)
                    
                    Text("russian:")
                    TextField("russian", text: $new_word.russian)
                    
                    Button(action: {
                        print("adding...")
                        let word_commiter = NewWordCommiter(english: self.new_word.english,
                                                            russian: self.new_word.russian,
                                                            collection: self.collection_name)
                        word_commiter.commit_word()
                    }) {
                        Text("Add word")
                    }.disabled(!word_entered())
                    
                }
                
            }
            
            
            collection_words()
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
