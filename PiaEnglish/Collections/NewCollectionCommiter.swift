//
//  NewCollectionCommiter.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 26/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import Foundation
import Firebase

class NewCollectionCommiter {
    
    var collection_name: String
    
    init(collection_name: String) {
        self.collection_name = collection_name
    }
    
    func remove_collection() {
        let doc = db.collection("collections").document(collection_name)
        doc.delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            }
        }
    }
    
    func commit_collection() {
        let new_doc = db.collection("collections").document(collection_name)
        new_doc.setData(["english_words": []]) { (err) in
            if (err != nil) {
                print("Error NewCollectionCommiter: \(err!.localizedDescription)")
            }
        }
    }
    
}
