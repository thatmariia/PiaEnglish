//
//  Collection.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 25/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import Foundation
import Firebase

struct Collection : Hashable, Identifiable {
    var id: String
    
    var name: String
    var english_words: [String]
}

func get_collection(from collection_snap: QueryDocumentSnapshot) -> Collection{
    let collection = Collection(id: collection_snap.documentID,
                                name: collection_snap.documentID,
                                english_words: collection_snap.get("english_words") as! [String])
    return collection
}
