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
    var id = UUID()
    
    var name: String
    var english_words: [String]
}

func get_collection(from collection_snap: QueryDocumentSnapshot) -> Collection{
    let collection = Collection(name: collection_snap.documentID,
                                english_words: collection_snap.get("english_words") as! [String])
    return collection
}
