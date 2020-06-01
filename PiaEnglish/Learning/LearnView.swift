//
//  LearnView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 25/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct LearnView: View {
    @EnvironmentObject var training_state: TrainingState
    // TODO:: check at least 4 words chosen
    
    @ObservedObject var collections_observer: CollectionsObserver
    
    @State var chosen_collections: [Collection] = []
    
    @State var time_selected = true
    @State var chosen_time = default_training_time
    
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
    
    fileprivate func time_button(timename: String, time: Int) -> some View {
        return HStack{
            VStack{
                
                Button(action: {
                    self.time_selected = true
                    self.chosen_time = time
                }) {
                    Text(timename)
                }.buttonStyle(SelectionButtonStyle(is_active: chosen_time == time))
                
            }
            Spacer().frame(width: 15)
        }
    }
    
    fileprivate func scroll_times() -> some View {
        return ScrollView(.horizontal, showsIndicators: false){
            HStack {
                
                time_button(timename: "Short", time: 5)
                time_button(timename: "Medium", time: 7)
                time_button(timename: "Long", time: 10)
                
            }
            
        }
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
            
            HStack {
                Text("Select collections").font(.largeTitle).fontWeight(.bold)
                Spacer()
            }
            
            if (collections_observer.collections.count > 0){
                scroll_collections()
                
                Spacer().frame(height: 15)
                
                HStack {
                    Text("Select training time").font(.largeTitle).fontWeight(.bold)
                    Spacer()
                }
                
                scroll_times()
                
                
            } else {
                Text("You have no collections :(")
            }
            
            Spacer()
            
            // testing
            NavigationLink(destination:
                TestView()
            ) {
                Text("Test")
            }.disabled(chosen_collections == [])
                .buttonStyle(BigButtonStyle())
            
            Spacer().frame(height: 15)

            
            // training
            NavigationLink(destination:
                TrainView(words_observer: CollectionContentsObserver(english_words: get_engliah_words()),
                          training_time: chosen_time)
            ){
                    Text("Train")
            }.disabled(chosen_collections == [] || !time_selected)
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
