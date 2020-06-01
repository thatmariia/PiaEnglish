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
            
            print("EXTRACTED FOR \(self.collection_name) : ", doc!.data()!["english_words"])
            
            if doc!.exists{
                
                self.english_words = doc!.get("english_words") as! [String]
                self.query_english_words(english: self.english_words)
            } else {
                self.english_words = []
            }
        }
        
    }
    
    func query_english_words(english: [String]) {
        
        /*let nr_ten_batches = Int(floor(Double(english.count / 10)))
        
        for batch_i in 0..<nr_ten_batches {
            let start_i = batch_i * 10
            let end_i = (batch_i == nr_ten_batches-1) ? english.count : (batch_i+1) * 10
            if end_i != start_i {
                let english_slice = Array(english[start_i..<end_i])*/
        
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
            print("AFTER EXTRACTION: ")
            print(self.words)
            
            /*for doc in snap!.documents {
                let word = get_word(from: doc)
                self.words.append(word)
            }*/
            
            
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
