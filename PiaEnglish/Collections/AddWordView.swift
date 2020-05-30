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
    let collection_words: [Word]
    
    @State var search_word = ""
    @ObservedObject var search_observer = SearchObserver()
    
    @State var adding = false
    @State var new_word = Word(id: "", english: "", russian: "", learned_by: [])
    
    @State var already_in_collection = false
    @State var already_in_collection_db = false
    @State var already_in_db = false
    @State var already_in_db_only = false
    
    fileprivate func word_entered() -> Bool {
        
        for char in new_word.english {
            if !eng_alphabet.contains(char) { return false }
        }
        
        for char in new_word.russian {
            if !rus_alphabet.contains(char) {return false }
        }
        
        if new_word.english.count > 0 && new_word.russian.count > 0 {
            return true
        }
        return false
    }
    
    /// selects words from db that match the search word
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
            if word_matching(db_word: str_db_word, comp_word: search_word){
                print("APPENDED")
                words.append(db_word)
            }
        }
        return words
    }
    
    fileprivate func word_exists_in_db(word: Word) -> Bool {
        if (word.english.count == 0 || word.russian.count == 0){ return false }
        for db_word in search_observer.all_words {
            
            if word_matching(db_word: db_word.russian, comp_word: word.russian) &&
               word_matching(db_word: db_word.english, comp_word: word.english){
                return true
            }
        }
        return false
    }
    
    fileprivate func word_exists_in_collection(word: Word) -> Bool {
        if collection_words.contains(word){
            return true
        }
        if (word.english.count == 0 || word.russian.count == 0){ return false }
        for collection_word in collection_words {
            
            if word_matching(db_word: collection_word.russian, comp_word: word.russian) &&
               word_matching(db_word: collection_word.english, comp_word: word.english){
                return true
            }
        }
        return false
    }
    
    fileprivate func add_existing_word(with english: String, and russian: String) {
        for word in search_observer.all_words {
            if word.english == english &&
               word.russian == russian {
                let word_commiter =  NewWordCommiter(new_word: word, collection: self.collection_name)
                word_commiter.add_word_to_collection()
                return
            }
        }
    }
    
    /// adds searched word to collection when pressed
    fileprivate func suggested_word_button(_ i: Int) -> some View {
        let matching_words = select_matching()
        return Button(action: {
            let word = matching_words[i]
            
            if (!self.word_exists_in_collection(word: word)){
                self.already_in_collection = false
                let word_commiter =  NewWordCommiter(new_word: word, collection: self.collection_name)
                word_commiter.add_word_to_collection()
                self.search_word = ""
            } else {
                self.already_in_collection = true
            }
        }) {
            Text(matching_words[i].english)
        }.alert(isPresented: $already_in_collection) { () -> Alert in
            in_collection_alert()
        }
    }
    
    fileprivate func add_word_button() -> Button<Text> {
        return Button(action: {
            
            let w = Word(id: "", english: self.new_word.english, russian: self.new_word.russian, learned_by: [])
            
            if !self.word_exists_in_db(word: w){
                print("adding...")
                self.already_in_db_only = false
                self.already_in_collection_db = false
                let word_commiter = NewWordCommiter(english: self.new_word.english,
                                                    russian: self.new_word.russian,
                                                    collection: self.collection_name)
                word_commiter.commit_new_word()
            } else {
                self.already_in_db_only = true
                
                if self.word_exists_in_collection(word: w){
                    self.already_in_collection_db = true
                    self.already_in_db_only = false
                }
            }
        }) {
            Text("Add word")
        }
    }
    
    fileprivate func in_db_only_alert() -> Alert {
        return Alert(title: Text("This word already exists."),
                     message: Text("Do you want to add it to the collection?"), primaryButton: .cancel(), secondaryButton: .default(Text("Add"), action: {
                        self.add_existing_word(with: self.new_word.russian, and: self.new_word.english)
                     }))
    }
    
    fileprivate func in_collection_alert() -> Alert {
        return Alert(title: Text(""),
                     message: Text("The word is already in this collection"),
                     dismissButton: .cancel())
    }
    
    var body: some View {
        
        return NavigationView {
            
            VStack {

                TextField("word search", text: $search_word)
                
                /// suggestion from db for the searched for word
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
                    
                    add_word_button().disabled(!word_entered())
                    .alert(isPresented: $already_in_collection_db) { () -> Alert in
                        in_collection_alert()
                    }
                    
                    Text("").alert(isPresented: $already_in_db_only) { () -> Alert in
                        in_db_only_alert()
                    }
                    
                    
                }
                
                Spacer()
                
                
                
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
