//
//  AddWordView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 26/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct AddWordView: View {
    
    let collection_name: String
    
    @State var search_word = ""
    @ObservedObject var search_observer = SearchObserver()
    
    @State var adding = false
    @State var new_word = Word(id: "", english: "", russian: "", learned_by: [])
    
    fileprivate func word_entered() -> Bool {
        if new_word.english.count > 0 && new_word.russian.count > 0 {
            return true
        }
        return false
    }
    
    fileprivate func select_matching() -> [Word] {
        
        var language = "english"
        
        if (search_word.count > 0){
            if (rus_alphabet.contains(search_word.prefix(1))){
                language = "russian"
            }
        }
        
        var words: [Word] = []
        for db_word in search_observer.all_words {
            
            let str_db_word : String
            if language == "english"{
                str_db_word = db_word.english
            } else {
                str_db_word = db_word.russian
            }
            //print("comparing word = ", str_db_word)
            if word_matching(db_word: str_db_word){
                print("APPENDED")
                words.append(db_word)
            }
        }
        return words
    }
    
    fileprivate func word_matching(db_word: String) -> Bool {
        print("search_word = ", search_word)
        let word_cap = search_word.prefix(1).uppercased() + search_word.dropFirst()
        print(word_cap, " - word_cap")
        if db_word.contains(search_word) ||
            db_word.contains(search_word.uppercased()) ||
            db_word.contains(search_word.lowercased()) ||
            db_word.contains(word_cap) {
            return true
        }
        
        return false
    }
    
    fileprivate func suggested_word_button(_ i: Int) -> Button<Text> {
        let matching_words = select_matching()
        return Button(action: {
            let word = matching_words[i]
            // TODO:: also check if the word is in the collection already
            
            let word_commiter =  NewWordCommiter(new_word: word, collection: self.collection_name)
            word_commiter.add_word_to_collection()
        }) {
            Text(matching_words[i].english)
        }
    }
    
    var body: some View {
        
        return NavigationView {
            
            VStack {

                TextField("word search", text: $search_word, onEditingChanged: { (changed) in
                }) {
                }
                
                if (search_word.count > 0) && (select_matching().count > 0){
                    VStack{
                        ForEach(0..<min(10, select_matching().count), id: \.self) { i in
                            self.suggested_word_button(i)
                        }
                    }
                }
                
                Spacer()
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
                    
                    // TODO:: check if already exists and if yes just add the word from db
                    
                    Button(action: {
                        print("adding...")
                        let word_commiter = NewWordCommiter(english: self.new_word.english,
                                                            russian: self.new_word.russian,
                                                            collection: self.collection_name)
                        word_commiter.commit_new_word()
                    }) {
                        Text("Add word")
                    }.disabled(!word_entered())
                    
                }
                
                
                
            }
        }
    }
}

/*
 struct AddWordView_Previews: PreviewProvider {
 static var previews: some View {
 AddWordView()
 }
 }
 */
