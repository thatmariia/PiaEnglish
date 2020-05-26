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
    
    let english: String
    let russian: String
    let collection: String
    
    init(english: String, russian: String, collection: String) {
        self.english = english
        self.russian = russian
        self.collection = collection
        
        // TODO:: add english word to the collection
        
        db.collection("collections").document(collection).setData(["english_words" : self.english], merge: true) { (err) in
            if (err != nil) {
                print("Error WordCommiter collection: \(err!.localizedDescription)")
            }
        }
        
        // TODO:: add a new word in words
        
        db.collection("words").addDocument(data: ["english" : self.english, "russian" : self.russian, "learned_by" : []]) { (err) in
            if (err != nil) {
                print("Error WordCommiter words: \(err!.localizedDescription)")
            }
        }
    }
}
