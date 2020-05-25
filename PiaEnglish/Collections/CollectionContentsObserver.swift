//
//  CollectionContentsObserver.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 25/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import Foundation
import Firebase

class CollectionContentsObserver : ObservableObject {
    
    var english_words = [String]()
    @Published var words = [Word]()
    
    init(english_words: [String]) {
        self.english_words = english_words
        
        let query = db.collection("words").whereField("english", arrayContains: self.english_words) // should be in
        
        query.addSnapshotListener { (snap, err) in
            if (err != nil) {
                print("Error CollectionContentsObserver: \(err!.localizedDescription)")
                return
            }
            
            for doc in snap!.documents {
                let word = get_word(from: doc)
                self.words.append(word)
            }
            
            
        }
    }
    
}
