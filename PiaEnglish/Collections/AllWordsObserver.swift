//
//  AllWordsObserver.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 02/06/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import Foundation
import Firebase

class AllWordsObserver : ObservableObject {
    
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
            
            for change in snap!.documentChanges {
                    //let new_word = get_word(from: doc)
                    //self.all_words.append(new_word)
                let doc = change.document
                let word = get_word(from: doc)
                
                switch change.type {
                case .added:
                    self.all_words.append(word)
                    break
                
                case .modified:
                    for i in 0..<self.all_words.count {
                        if doc.documentID == self.all_words[i].id {
                            self.all_words[i] = word
                            break
                        }
                    }
                case .removed:
                    //var remove_i = -1
                    for i in 0..<self.all_words.count {
                        if doc.documentID == self.all_words[i].id {
                            self.all_words.remove(at: i)
                            break
                        }
                    }
                    
                default:
                    continue
                }
            }
        }
        
    }

    
}

