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
    @EnvironmentObject var words_observer: CollectionContentsObserver
    
    @State var new_word = Word(id: "", english: "", russian: "", learned_by: [])
    @State var update = 1
    @State var editing = false
    
    fileprivate func learned_status(word: Word) -> Bool{
        if word.learned_by.contains(username) {
            return true
        }
        return false
    }
    
    fileprivate func delete_word(word: Word) {
        let word_commiter = NewWordCommiter(new_word: word, collection: self.collection_name)
        word_commiter.remove_word_from_collection()
        
        self.words_observer.words = []
        self.words_observer.english_words = []
        self.words_observer.collection_name = self.collection_name
        self.words_observer.start_listening_collection()
    }
    
    fileprivate func collection_word(word: Word) -> some View {
        return VStack{
            HStack{
                
                // learned status
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
                    Image(systemName: learned_status(word: word) ? "checkmark.circle.fill" : "checkmark.circle")
                }.buttonStyle(BorderlessButtonStyle())
                    .frame(width: 10, height: 10)
                
                /// super genious force refresh workaround
                if (update >= 1) {
                    Text("")
                }
                
                //Spacer().frame(width: 10)
                
                Text(format_string(str: word.english))
                Image(systemName: "arrow.left.and.right")
                Text(format_string(str: word.russian))
                
                Spacer()
                
                Button(action: {
                    play_audio_of(word: word.english)
                }) {
                    Image(systemName: "play.fill").foregroundColor(.white)
                }.buttonStyle(BorderlessButtonStyle())
                
                if (editing){
                    
                    Spacer().frame(width: 15)
                    
                    Button(action: {
                        self.delete_word(word: word)
                        self.update += 1
                    }) {
                        Image(systemName: "trash").foregroundColor(.white)
                    }.buttonStyle(BorderlessButtonStyle())
                    
                }
            }
            Divider()
        }
    }
    
    fileprivate func add_new_word() -> some View {
        return NavigationLink(destination: AddWordView(collection_name: collection_name, collection_words: words_observer.words)) {
            VStack{
                HStack{
                    Image(systemName: "plus.circle").foregroundColor(.white)
                    Text("Add a new word")
                    Spacer()
                }
                Divider()
            }
        }
    }
    
    fileprivate func edit_button() -> some View {
        return Button(action: {
            self.editing = !self.editing
            self.update += 1
        }) {
            Image(systemName: "ellipsis").foregroundColor(.white)
        }
    }
    
    var body: some View {
        ZStack(alignment: .top){
            PiaBackground().edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: true){
                VStack{
                    
                    add_new_word()
                    
                    if (words_observer.words.count > 0 && update > 0){
                        ForEach(words_observer.words) { word in
                            self.collection_word(word: word)
                        }
                    } else {
                        Text("No words in this collection")
                    }
                    Spacer()
                }.padding()
                
            }.navigationBarTitle(format_string(str: collection_name))
                .navigationBarItems(trailing:
                    edit_button()
            )
        }.onAppear {
            // TODO:: add to english words
            print("ON APPEAR")
            self.words_observer.words = []
            self.words_observer.english_words = []
            self.words_observer.collection_name = self.collection_name
            self.words_observer.start_listening_collection()
            
            //self.words_observer = CollectionContentsObserver(collection_name: self.collection_name)
            self.update = 5
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
