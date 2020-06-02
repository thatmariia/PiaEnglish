//
//  CollectionsView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 25/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct CollectionsView: View {
    
    //@EnvironmentObject var words_observer: CollectionContentsObserver
    //@ObservedObject var collections_observer: CollectionsObserver
    @EnvironmentObject var collections_observer: CollectionsObserver
    
    @State var editing = false
    @State var update = 1
    
    // TODO:: add option to delete collection
    
    fileprivate func edit_button() -> some View {
        return Button(action: {
            self.editing = !self.editing
            //self.update += 1
        }) {
            Image(systemName: "ellipsis").foregroundColor(.white)
        }
    }
    
    fileprivate func delete_collection(collection_name: String){
        let collection_commiter = NewCollectionCommiter(collection_name: collection_name)
        collection_commiter.remove_collection()
        
        collections_observer.collections = []
        collections_observer.refresh()
    }
    
    fileprivate func scroll_collections() -> some View {
        
        print("COLLECTIONS: ", collections_observer.collections)
        
        return VStack{
            
            //List{
            
            ForEach(collections_observer.collections) { collection in
                
                VStack{
                    
                    HStack{
                    
                    NavigationLink(destination:
                        CollectionContentsView(collection_name: collection.name
                                                                       /*words_observer: CollectionContentsObserver(collection_name: collection.name))*/ )) {
                                                                        
                                                                        HStack{
                                                                            Text(format_string(str: collection.name))
                                                                            Spacer()
                                                                            if !self.editing{
                                                                                Image(systemName: "chevron.right").foregroundColor(.white)
                                                                            }
                                                                        }
                    }.disabled(self.editing)
                        
                        if self.update > 0 {
                            Text("")
                        }
                      
                        if self.editing {
                            Button(action: {
                                self.delete_collection(collection_name: collection.name)
                                
                                self.update += 1
                                if self.update > 10 { self.update = 1}
                            }) {
                                Image(systemName: "trash").foregroundColor(.white)
                            }.buttonStyle(BorderlessButtonStyle())
                        }
                        
                    }
                    Divider()
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top){
                
                PiaBackground().edgesIgnoringSafeArea(.all)
                ScrollView(.vertical, showsIndicators: true){
                    
                    VStack {
                        
                        HStack {
                            Text("Collections").font(.largeTitle).fontWeight(.bold)
                            Spacer()
                            edit_button()
                        }
                        
                        NavigationLink(destination: AddCollectionView(/*curr_collections: collections_observer.collections*/)) {
                            VStack{
                                HStack{
                                    Image(systemName: "plus.circle").foregroundColor(.white)
                                    Text("Add a new collection")
                                    Spacer()
                                }
                                Divider()
                            }
                        }
                        
                        
                        
                        scroll_collections()
                    }.padding()
                }.navigationBarTitle("Collections").navigationBarHidden(true).foregroundColor(.white)
                
            }
        }
    }
}

/*
 struct CollectionsView_Previews: PreviewProvider {
 static var previews: some View {
 CollectionsView()
 }
 }
 */
