//
//  LearnView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 25/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct LearnView: View {
    
    @ObservedObject var collections_observer: CollectionsObserver
    
    @State var chosen_collections: [Collection] = []
    
    fileprivate func get_color(collection: Collection) -> Color{
        if (chosen_collections.contains(collection)) {
            return .green
        }
        return .red
    }
    
    
    fileprivate func get_engliah_words() -> [String]{
        // get words associated with chosen collections
        var english_words: [String] = []
        for collection in chosen_collections {
            english_words += collection.english_words
        }
        print("passing english words = ", english_words)
        return english_words
    }
    
    
    var body: some View {
        
        return NavigationView {
            VStack {
                
                Text("Choose collections")
                
                if (collections_observer.collections.count > 0){
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            
                            ForEach(0..<collections_observer.collections.count, id: \.self) { i in
                                
                                Button(action: {
                                    
                                    let collection = self.collections_observer.collections[i]
                                    
                                    if (self.chosen_collections.contains(collection)) {
                                        if let index = self.chosen_collections.firstIndex(of: collection) {
                                            self.chosen_collections.remove(at: index)
                                        }
                                    } else {
                                        self.chosen_collections.append(collection)
                                    }
                                    
                                    print("chosen collections = ", self.chosen_collections)
                                    
                                }) {
                                    Text(self.collections_observer.collections[i].name).foregroundColor(self.get_color(collection: self.collections_observer.collections[i]))
                                }
                                
                            }
                            
                        }
                    }
                }
                Spacer()
                
                // testing
                NavigationLink(destination: TestView()) {
                    Text("Test")
                }.disabled(chosen_collections == [])
                
                // training
                NavigationLink(destination: TrainView(words_observer: CollectionContentsObserver(english_words: get_engliah_words()),
                                                      english_words: get_engliah_words())) {
                                                        Text("Train")
                }.disabled(chosen_collections == [])
                
                Spacer()
                
            }
        }
    }
}

/*
 struct LearnView_Previews: PreviewProvider {
 static var previews: some View {
 LearnView()
 }
 }
 */
