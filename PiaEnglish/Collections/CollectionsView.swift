//
//  CollectionsView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 25/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct CollectionsView: View {
    
    @ObservedObject var collections_observer: CollectionsObserver
    
    // TODO:: add option to delete collection
    
    fileprivate func scroll_collections() -> some View {
        return VStack{
            
            //List{
            
            ForEach(collections_observer.collections) { collection in
                
                VStack{
                    
                    
                    NavigationLink(destination: CollectionContentsView(collection_name: collection.name,
                                                                       words_observer: CollectionContentsObserver(collection_name: collection.name))) {
                                                                        
                                                                        HStack{
                                                                            Text(format_string(str: collection.name))
                                                                            Spacer()
                                                                            Image(systemName: "chevron.right").foregroundColor(.white)
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
                        }
                        
                        NavigationLink(destination: AddCollectionView(collections: collections_observer.collections)) {
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
                }.navigationBarTitle("Collections").navigationBarHidden(true)
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
