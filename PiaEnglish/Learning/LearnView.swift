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
    
    fileprivate func is_selected(collection: Collection) -> Bool{
        if (chosen_collections.contains(collection)) {
            return true
        }
        return false
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
    
    fileprivate func collection_button(_ i: Int) -> some View {
        return Button(action: {
            
            let collection = self.collections_observer.collections[i]
            
            if (self.chosen_collections.contains(collection)) {
                if let index = self.chosen_collections.firstIndex(of: collection) {
                    self.chosen_collections.remove(at: index)
                }
            } else {
                self.chosen_collections.append(collection)
            }
            
        }) {
            Text(self.collections_observer.collections[i].name)
        }.buttonStyle(SelectionButtonStyle(is_active: self.is_selected(collection: self.collections_observer.collections[i])))
    }
    
    fileprivate func scroll_collections() -> some View {
        return ScrollView(.horizontal, showsIndicators: false){
            HStack {
                ForEach(0..<collections_observer.collections.count, id: \.self) { i in
                    
                    HStack{
                    VStack{
                        self.collection_button(i)
                    }
                    Spacer().frame(width: 15)
                    }
                    
                }
            }
        }
    }
    
    fileprivate func generate_LearnView(geom: GeometryProxy) -> some View {
        return VStack(spacing: 10) {
            
            // TODO:: why doesnt align to left?
            HStack {
                Text("Select collections:").font(.title)
                Spacer()
            }
            
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
            .buttonStyle(BigButtonStyle())
            
            Spacer().frame(height: 15)
            
            // training
            NavigationLink(destination: TrainView(words_observer: CollectionContentsObserver(english_words: get_engliah_words()),
                                                  english_words: get_engliah_words())) {
                                                    Text("Train")
            }.disabled(chosen_collections == [])
            .buttonStyle(BigButtonStyle())
            
            Spacer()
            
        }
        .padding()
        .frame(minHeight: geom.size.height)
        //.background(PiaBackground())
    }
    
    var body: some View {
        
        return NavigationView{
            ZStack(alignment: .top){
                    
                    PiaBackground().edgesIgnoringSafeArea(.all)
                GeometryReader{geom in
                    
                    
                    
                    
                        
                    self.generate_LearnView(geom: geom)
                }
                
                        
                    
                }.navigationBarTitle("").navigationBarHidden(true)
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
