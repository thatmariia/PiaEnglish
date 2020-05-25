//
//  CollectionsObserver.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 25/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import Foundation
import Firebase


class CollectionsObserver : ObservableObject {
    
    @Published var collections = [Collection]()
    
    init(){
        
        let collections = db.collection("collections")
        
        collections.addSnapshotListener { (snap, err) in
            if (err != nil) {
                print("Error CollectionsObserver: \(err!.localizedDescription)")
                return
            }
            
            for doc in snap!.documents {
                let collection = get_collection(from: doc)
                self.collections.append(collection)
            }
        }
    }
}
