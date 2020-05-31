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
        
        if (self.english_words.count == 0) {
            return
        }
        
        let query = db.collection("words").whereField("english", in: self.english_words)
        
        query.addSnapshotListener { (snap, err) in
            if (err != nil) {
                print("Error CollectionContentsObserver: \(err!.localizedDescription)")
                return
            }
            
            for change in snap!.documentChanges {
                let doc = change.document
                let word = get_word(from: doc)
                
                switch change.type {
                case .added:
                    self.words.append(word)
                    break
                
                case .modified:
                    for i in 0..<self.words.count {
                        if doc.documentID == self.words[i].id {
                            self.words[i] = word
                            break
                        }
                    }
                case .removed:
                    //var remove_i = -1
                    for i in 0..<self.words.count {
                        if doc.documentID == self.words[i].id {
                            self.words.remove(at: i)
                            break
                        }
                    }
                    
                default:
                    continue
                }
            }
            
            /*for doc in snap!.documents {
                let word = get_word(from: doc)
                self.words.append(word)
            }*/
            
            
        }
    }
    
}
