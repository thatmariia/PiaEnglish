//
//  AddCollectionView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 26/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct AddCollectionView: View {
    
    var collections: [Collection]
    
    @State var new_collection = ""
    @State var exists = false
    
    fileprivate func collection_exists() -> Bool {
        for collection in collections {
            if word_matching(db_word: collection.name, comp_word: new_collection) {
                return true
            }
        }
        return false
    }
    
    var body: some View {
        return ZStack(alignment: .top){
        PiaBackground().edgesIgnoringSafeArea(.all)
            
        VStack{
            Text("Enter collection name")
            
            TextField("add collection", text: $new_collection, onEditingChanged: { (changed) in
            }) {
                self.exists = self.collection_exists()
                if !self.exists {
                    let collection_commiter = NewCollectionCommiter(collection_name: self.new_collection)
                    collection_commiter.commit_collection()
                    
                }
            }.alert(isPresented: $exists) { () -> Alert in
                Alert(title: Text(""), message: Text("Collection already exists"), dismissButton: .cancel())
            }
        }
        }.navigationBarTitle("New collection")
    }
}

/*
struct AddCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        AddCollectionView()
    }
}
*/
