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
    var collection_name = ""
    @Published var words = [Word]() {
        willSet { objectWillChange.send() }
    }
    
    init(collection_name: String) {
        self.collection_name = collection_name
        
        let collections_ref = db.collection("collections").document(collection_name)
        
        collections_ref.getDocument { (doc, err) in
            if (err != nil) {
                print("Error CollectionContentsObserver get doc: \(err!.localizedDescription)")
                return
            }
            
            if doc!.exists{
                
                self.english_words = doc!.get("english_words") as! [String]
                self.query_english_words(english: self.english_words)
            } else {
                self.english_words = []
            }
        }
        
    }
    
    func query_english_words(english: [String]) {
        
        for eng in english{

        let query = db.collection("words").whereField("english", isEqualTo: eng)
        
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
        }
        }
        
        
        
        
        
        
    }
    
    init(english_words: [String]) {
        self.english_words = english_words
        
        if (self.english_words.count == 0) {
            return
        }
        
        self.query_english_words(english: self.english_words)
        
    
    }
    
}
