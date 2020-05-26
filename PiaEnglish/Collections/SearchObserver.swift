//
//  SearchObserver.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 26/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import Foundation
import Firebase

class SearchObserver : ObservableObject {
    
    @Published var all_words = [Word]()
    
    //let entered_word: String
    var language = "english"
    
    init(/*entered_word: String*/) {
        //self.entered_word = entered_word
        
        
        let query = db.collection("words") // TODO:: change when firebase introduces substring search
        
        self.all_words = []
        query.addSnapshotListener { (snap, err) in
            if (err != nil) {
                print("Error SearchObserver: \(err!.localizedDescription)")
                return
            }
            
            for doc in snap!.documents {
                    let new_word = get_word(from: doc)
                    self.all_words.append(new_word)
            }
        }
        
    }

    
}
