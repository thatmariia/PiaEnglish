//
//  WordCommiter.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 26/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import Foundation
import Firebase

class NewWordCommiter {
    
    let new_word: Word
    let collection: String
    
    init(english: String, russian: String, learned_by: [String] = [], collection: String) {
        self.new_word = Word(id: "", english: english, russian: russian, learned_by: learned_by)
        self.collection = collection
    }
    
    init(new_word: Word, collection: String) {
        self.new_word = new_word
        self.collection = collection
    }
    
    func add_word_to_collection() {
        db.collection("collections").document(collection).setData(["english_words" : FieldValue.arrayUnion([self.new_word.english])], merge: true) { (err) in
            if (err != nil) {
                print("Error WordCommiter collection: \(err!.localizedDescription)")
            }
        }
    }
    
    func commit_new_word() {
        // TODO:: add english word to the collection
        
        print("adding word to collection = ", db.collection("collections").document(collection).documentID)
        
        add_word_to_collection()
        
        // TODO:: add a new word in words
        
        let new_document = db.collection("words").document()
    
        new_document.setData(get_word_dict(from: self.new_word), merge: true) { (err) in
            if (err != nil) {
                print("Error WordCommiter words: \(err!.localizedDescription)")
            }
        }
    }
}
