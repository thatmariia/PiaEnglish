//
//  CollectionContentsView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 25/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI
import Firebase


struct CollectionContentsView: View {
    
    var collection_name: String
    var words_observer: CollectionContentsObserver
    
    @State var new_word = Word(id: "", english: "", russian: "", learned_by: [])
    @State var update = 1
    
    fileprivate func learned_status(word: Word) -> String{
        print("LEARNED STATUS = ", word.learned_by)
        if word.learned_by.contains(username) {
            return "L"
        }
        return "NL"
        
    }
    
    fileprivate func delete_word(word: Word) {
        // TODO:: figure out why view disappears when deleting
        let word_commiter = NewWordCommiter(new_word: word, collection: self.collection_name)
        word_commiter.remove_word_from_collection()
    }
    
    fileprivate func collection_word(word: Word) -> some View{
        print("*** callled collection word with word = ", word)
        return HStack{
            
            Button(action: {
                /// super genious force refresh workaround
                self.update += 1
                
                let learned_toggle_commiter: LearnedToggleCommiter
                
                if word.learned_by.contains(username) {
                    // was learned, not anymore

                    if let word_index = self.words_observer.words.firstIndex(of: word) {
                        
                        if let user_index = self.words_observer.words[word_index].learned_by.firstIndex(of: username) {
                            self.words_observer.words[word_index].learned_by.remove(at: user_index)
                        }
                    }
                    learned_toggle_commiter = LearnedToggleCommiter(word: word, is_now_learned: false)
                } else {
                    // the other way arounf

                    if let word_index = self.words_observer.words.firstIndex(of: word) {
                        self.words_observer.words[word_index].learned_by.append(username)
                    }
                    learned_toggle_commiter = LearnedToggleCommiter(word: word, is_now_learned: true)
                }
                learned_toggle_commiter.toggle_learned()
                
                self.update += 1
                if (self.update % 10 == 0) {self.update = 1}
                

            }) {
                
                Text(learned_status(word: word))
            }.buttonStyle(BorderlessButtonStyle())
                .frame(width: 10, height: 10)
            
            /// super genious force refresh workaround
            if (update >= 1) {
                Text("")
            }
            
            Spacer().frame(width: 10)
            
            Text(word.english).frame(minWidth: 30)
            
            
            Button(action: {
                print("hit play")
                play_audio_of(word: word.english)
            }) {
                Text("play")
            }.buttonStyle(BorderlessButtonStyle())
            .frame(minWidth: 20)
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
            //ScrollView(.vertical, showsIndicators: true) {
                Text("coll name = " + collection_name)
                
                NavigationLink(destination: AddWordView(collection_name: collection_name, collection_words: words_observer.words)) {
                    Text("Add new word")
                }
                //Spacer()
                
                // TODO:: fix not appearing after adding a word
                if (words_observer.words.count > 0){
                    //ForEach(0..<words_observer.words.count){ i in
                    List{
                    ForEach(words_observer.words){ word in
                        self.collection_word(word: word)
                    }.onDelete { (index) in
                        
                        print("BEFORE DELETE = ", self.words_observer.words.count)

                        let i = index.first!
                        let delete_word = self.words_observer.words[i]
                        
                        // TODO:: fix deleting whole thing when comitiing
                        self.delete_word(word: delete_word)
                        self.words_observer.words.remove(at: i)
                        self.update += 1
                        
                        print("AFTER DELETE = ", self.words_observer.words.count)
                        
                        }
                    }
                }
            Spacer()
            //}
            }
        }.padding()
        .buttonStyle(BigButtonStyle())
    }
}

/*
 struct CollectionContentsView_Previews: PreviewProvider {
 static var previews: some View {
 CollectionContentsView()
 }
 }
 */
