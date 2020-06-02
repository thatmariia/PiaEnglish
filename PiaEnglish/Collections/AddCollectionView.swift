//
//  AddCollectionView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 26/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct AddCollectionView: View {
    
    @EnvironmentObject var search_observer: CollectionsObserver
    
    @State var new_collection = ""
    @State var exists = false
    @State var adding = false
    
    fileprivate func collection_exists() -> Bool {
        for collection in search_observer.collections {
            if word_matching(db_word: collection.name, comp_word: new_collection) {
                return true
            }
        }
        return false
    }
    
    fileprivate func is_english() -> Bool {
        for char in new_collection {
            if !eng_allowed.contains(char) { return false }
        }
        return true
    }
    
    var body: some View {
        
        let placeholder = HStack {
            Spacer().frame(width: 10)
            Text("New collection name (english)").foregroundColor(.white)
            Spacer()
        }
        
        return ZStack(alignment: .top){
            PiaBackground().edgesIgnoringSafeArea(.all)
            
            VStack{
                
                HStack{
                    Text("Enter collection name:")
                    Spacer()
                }
                
                ZStack(alignment: .leading) {
                    if self.new_collection == "" { placeholder }
                    
                    TextField("", text: $new_collection, onEditingChanged: {_ in
                        self.adding = !self.adding
                    }).textFieldStyle(NormalTextFieldStyle(is_focused: adding))
                        .accentColor(Color("GradStart"))
                }
                
                Spacer().frame(height: 16)
                
                Button(action: {
                    self.exists = self.collection_exists()
                    if !self.exists && self.is_english() {
                        let collection_commiter = NewCollectionCommiter(collection_name: self.new_collection)
                        collection_commiter.commit_collection()
                        self.new_collection = ""
                        /*self.search_observer.collections = []
                        self.search_observer.refresh()*/
                        
                    }
                }) {
                    Text("Add the collection")
                }.buttonStyle(NormalButtonStyle())
                    .alert(isPresented: $exists) { () -> Alert in
                        Alert(title: Text(""), message: Text("Collection with this name already exists"), dismissButton: .cancel())
                    
                }
                .disabled(self.new_collection == "" || !self.is_english())
                
                Spacer()
                
                
            }.padding()
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
