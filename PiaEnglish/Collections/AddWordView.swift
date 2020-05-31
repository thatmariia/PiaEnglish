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
    @State var now_searching = false
    @ObservedObject var search_observer = SearchObserver()
    
    @State var adding = false
    @State var adding_english = false
    @State var adding_russian = false
    @State var new_word = Word(id: "", english: "", russian: "", learned_by: [])
    
    @State var already_in_collection = false
    @State var already_in_collection_db = false
    @State var already_in_db = false
    @State var already_in_db_only = false
    
    //@ObservedObject var keyboardResponder = KeyboardResponder()
    
    fileprivate func word_entered() -> Bool {
        
        // TODO:: check if the last char is space ??
        
        // TODO:: add space to alphabets and -'
        
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
    
    /// checks whether new word already exists in db
    fileprivate func word_exists_in_db(word: Word) -> Bool {
        if (word.english.count == 0 || word.russian.count == 0){ return false }
        // TODO:: strip spaces off
        var word_copy = word
        word_copy.english = word.english.trimmingCharacters(in: .whitespacesAndNewlines)
        word_copy.russian = word.russian.trimmingCharacters(in: .whitespacesAndNewlines)
        for db_word in search_observer.all_words {
            
            if word_matching(db_word: db_word.russian, comp_word: word_copy.russian) &&
                word_matching(db_word: db_word.english, comp_word: word_copy.english){
                return true
            }
        }
        return false
    }
    
    /// checks whether the word already exists in collection
    fileprivate func word_exists_in_collection(word: Word) -> Bool {
        if collection_words.contains(word){
            return true
        }
        if (word.english.count == 0 || word.russian.count == 0){ return false }
        var word_copy = word
        word_copy.english = word.english.trimmingCharacters(in: .whitespacesAndNewlines)
        word_copy.russian = word.russian.trimmingCharacters(in: .whitespacesAndNewlines)
        for collection_word in collection_words {
            
            if word_matching(db_word: collection_word.russian, comp_word: word_copy.russian) &&
                word_matching(db_word: collection_word.english, comp_word: word_copy.english){
                return true
            }
        }
        return false
    }
    
    /// resets new word after it being added to collection
    fileprivate func reset_new_word() {
        new_word = Word(id: "", english: "", russian: "", learned_by: [])
    }
    
    /// adds a word from db to collection when entered as new word
    fileprivate func add_existing_word(with english: String, and russian: String) {
        
        let english_copy = english.trimmingCharacters(in: .whitespacesAndNewlines)
        let russian_copy = russian.trimmingCharacters(in: .whitespacesAndNewlines)
        
        for word in search_observer.all_words {
            if word_matching(db_word: word.english, comp_word: english_copy) &&
                word_matching(db_word: word.russian, comp_word: russian_copy) {
                let word_commiter =  NewWordCommiter(new_word: word, collection: self.collection_name)
                word_commiter.add_word_to_collection()
                reset_new_word()
                return
            }
        }
    }
    
    /// adds searched word to collection when pressed
    fileprivate func suggested_word_button(_ i: Int) -> some View {
        let matching_words = select_matching()
        return VStack {
            Button(action: {
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
                
                HStack{
                    Spacer()
                    Text(format_string(str: matching_words[i].english))
                    Image(systemName: "arrow.left.and.right")
                    Text(format_string(str: matching_words[i].russian))
                    Spacer()
                }
            }.alert(isPresented: $already_in_collection) { () -> Alert in
                in_collection_alert()
            }
            
            Divider()
        }
    }
    
    fileprivate func add_word_button() -> some View {
        return Button(action: {
            
            let w = Word(id: "", english: self.new_word.english, russian: self.new_word.russian, learned_by: [])
            
            if !self.word_exists_in_db(word: w){
                self.already_in_db_only = false
                self.already_in_collection_db = false
                
                var new_word_copy = self.new_word
                new_word_copy.english = self.new_word.english.trimmingCharacters(in: .whitespacesAndNewlines)
                new_word_copy.russian = self.new_word.russian.trimmingCharacters(in: .whitespacesAndNewlines)
                
                let word_commiter = NewWordCommiter(english: new_word_copy.english,
                                                    russian: new_word_copy.russian,
                                                    collection: self.collection_name)
                word_commiter.commit_new_word()
                self.reset_new_word()
            } else {
                self.already_in_db_only = true
                
                if self.word_exists_in_collection(word: w){
                    self.already_in_collection_db = true
                    self.already_in_db_only = false
                }
            }
        }) {
            Text("Add the word")
        }.buttonStyle(NormalButtonStyle())
    }
    
    fileprivate func in_db_only_alert() -> Alert {
        return Alert(title: Text("This word already exists."),
                     message: Text("Do you want to add it to the collection?"), primaryButton: .cancel(), secondaryButton: .default(Text("Add"), action: {
                        self.add_existing_word(with: self.new_word.english, and: self.new_word.russian)
                     }))
    }
    
    fileprivate func in_collection_alert() -> Alert {
        return Alert(title: Text(""),
                     message: Text("The word is already in this collection"),
                     dismissButton: .cancel())
    }
    
    var body: some View {
        
        let placeholder = HStack {
            Spacer().frame(width: 10)
            Image(systemName: "magnifyingglass").accentColor(.white)
            Text("Search").foregroundColor(.white)
            Spacer()
        }
        
        let placeholder_english = HStack {
            Spacer().frame(width: 10)
            Text("English word").foregroundColor(.white)
            Spacer()
        }
        
        let placeholder_russian = HStack {
            Spacer().frame(width: 10)
            Text("Russian word").foregroundColor(.white)
            Spacer()
        }
        
        return ZStack(alignment: .top){
            
            PiaBackground().edgesIgnoringSafeArea(.all)
            //ScrollView(.vertical, showsIndicators: true){
            
            GeometryReader{ geom in
                VStack {
                    
                    if !self.adding{
                        ZStack(alignment: .leading) {
                            if self.search_word.isEmpty { placeholder }
                            TextField("", text: self.$search_word, onEditingChanged: {_ in
                                self.now_searching = !self.now_searching
                            }).textFieldStyle(NormalTextFieldStyle(is_focused: self.now_searching))
                                .accentColor(Color("GradStart"))
                        }
                        
                        /// suggestion from db for the searched for word
                        if (self.search_word.count > 0) && (self.select_matching().count > 0){
                            ScrollView(.vertical, showsIndicators: false) {
                                VStack{
                                    ForEach(0..<min(10, self.select_matching().count), id: \.self) { i in
                                        self.suggested_word_button(i)
                                    }
                                }
                            }.frame(maxHeight: geom.size.height/2)
                        }
                        Spacer().frame(height: 16)
                    }
                    Text("Didn't find what you were looking for?")
                    Spacer().frame(height: 8)
                    Button(action: {
                        self.adding = !self.adding
                    }) {
                        Text("Add a new word")
                    }.buttonStyle(NormalSelectionButtonStyle(is_selected: self.adding))
                    
                    if self.adding {
                        HStack{
                            Text("English:")
                            Spacer()
                        }
                        
                      
                        ZStack(alignment: .leading) {
                            if self.new_word.english.isEmpty { placeholder_english }
                            TextField("", text: self.$new_word.english, onEditingChanged: {_ in
                                self.adding_english = !self.adding_english
                            }).textFieldStyle(NormalTextFieldStyle(is_focused: self.adding_english))
                                .accentColor(Color("GradStart"))
                        }
                        
                        
                        //TextField("english", text: self.$new_word.english)
                        
                        HStack{
                            Text("Russian:")
                            Spacer()
                        }
                        ZStack(alignment: .leading) {
                            if self.new_word.russian.isEmpty { placeholder_russian }
                            TextField("", text: self.$new_word.russian, onEditingChanged: {_ in
                                self.adding_russian = !self.adding_russian
                            }).textFieldStyle(NormalTextFieldStyle(is_focused: self.adding_russian))
                                .accentColor(Color("GradStart"))
                        }
                        //TextField("russian", text: self.$new_word.russian)
                        
                        self.add_word_button().disabled(!self.word_entered())
                            .alert(isPresented: self.$already_in_collection_db) { () -> Alert in
                                self.in_collection_alert()
                        }
                        
                        Text("").alert(isPresented: self.$already_in_db_only) { () -> Alert in
                            self.in_db_only_alert()
                        }
                    }
                    Spacer()
                }.padding()
                .keyboardAdaptive()
               
            }
            
        }.navigationBarTitle("Add to " + format_string(str: collection_name))
    }
}

/*
 struct AddWordView_Previews: PreviewProvider {
 static var previews: some View {
 AddWordView()
 }
 }
 */
