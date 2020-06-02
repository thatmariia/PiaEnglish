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
        
        refresh()
    }
    
    func refresh() {
        let collections = db.collection("collections")
        
        collections.addSnapshotListener { (snap, err) in
            if (err != nil) {
                print("Error CollectionsObserver: \(err!.localizedDescription)")
                return
            }
            
            for change in snap!.documentChanges {
                let doc = change.document
                let collection = get_collection(from: doc)
                
                switch change.type {
                case .added:
                    if !self.collections.contains(collection){
                        self.collections.append(collection) }
                    break
                    
                case .modified:
                    for i in 0..<self.collections.count {
                        if doc.documentID == self.collections[i].id {
                            self.collections[i] = collection
                            break
                        }
                    }
                    
                case .removed:
                    for i in 0..<self.collections.count {
                        if doc.documentID == self.collections[i].id {
                            self.collections.remove(at: i)
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
