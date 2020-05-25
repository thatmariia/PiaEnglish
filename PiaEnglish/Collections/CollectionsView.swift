//
//  CollectionsView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 25/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct CollectionsView: View {
    
    @ObservedObject var collections_observer = CollectionsObserver()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                
                ForEach(collections_observer.collections) { collection in
                    
                    NavigationLink(destination: CollectionContentsView(collection_name: collection.name,
                                                                       words_observer: CollectionContentsObserver(english_words: collection.english_words))) {
                        
                        Text(collection.name)
                    }
                }
                
            }
        }
    }
}

struct CollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionsView()
    }
}
