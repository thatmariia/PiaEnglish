//
//  LernedToggleCommiter.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 26/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import Foundation
import Firebase

class LearnedToggleCommiter {
    
    var word: Word
    var is_now_learned: Bool
    
    init(word: Word, is_now_learned: Bool) {
        self.word = word
        self.is_now_learned = is_now_learned
    }
    
    func toggle_learned() {
        
        let doc = db.collection("words").document(self.word.id)
        
        if self.is_now_learned {
        
            doc.setData(["learned_by" : FieldValue.arrayUnion([username])],
                        merge: true) { (err) in
                if (err != nil) {
                    print("Error LearnedToggleCommiter is_now_learned: \(err!.localizedDescription)")
                }
            }
        } else {
            
            doc.setData(["learned_by" : FieldValue.arrayRemove([username])], merge: true) { (err) in
                if (err != nil) {
                    print("Error LearnedToggleCommiter not is_now_learned: \(err!.localizedDescription)")
                }
            }
            
        }
        
    }
    
}
