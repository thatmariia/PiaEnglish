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
    
    fileprivate func collection_button(_ i: Int) -> Button<Text> {
        return Button(action: {
            
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
    
    fileprivate func scroll_collections() -> ScrollView<HStack<ForEach<Range<Int>, Int, Button<Text>>>> {
        return ScrollView(.horizontal, showsIndicators: false){
            HStack {
                ForEach(0..<collections_observer.collections.count, id: \.self) { i in
                    
                    self.collection_button(i)
                    
                }
            }
        }
    }
    
    var body: some View {
        
        return NavigationView {
            VStack {
                
                Text("Choose collections:")
                
                if (collections_observer.collections.count > 0){
                    scroll_collections()
                } else {
                    Text("You have no collections :(")
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
