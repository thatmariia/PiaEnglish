//
//  LearnSettingsView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 02/06/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct LearnSettingsView: View {
    @EnvironmentObject var training_state: TrainingState
    @EnvironmentObject var testing_state: TestingState
    
    @EnvironmentObject var all_words_observer: AllWordsObserver
    @EnvironmentObject var collections_observer: CollectionsObserver
    
    @State var chosen_collections: [Collection] = []
    
    @State var time_selected = true
    @State var chosen_time = default_training_time
    
    @State var chosen_training = false
    @State var chosen_testing = false
    
    @State var game_words: [Word] = []
    @State var enough_words_selected = false
    @State var acrivity_attempted = false
    
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
    
    fileprivate func get_game_words() {
        let english_words = get_engliah_words()
        
        for word in all_words_observer.all_words {
            if !word.learned_by.contains(username) &&
                !self.game_words.contains(word) &&
                english_words.contains(word.english){
                self.game_words.append(word)
            }
        }
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
            Text(format_string(str: self.collections_observer.collections[i].name))
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
                
                time_button(timename: "Very short", time: 1)
                time_button(timename: "Short", time: 2)
                time_button(timename: "Medium", time: 3)
                time_button(timename: "Long", time: 4)
                time_button(timename: "Very long", time: 5)
                time_button(timename: "Death row", time: 10)
                
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
                Text("Select collections").font(.title).fontWeight(.bold).foregroundColor(.white)
                Spacer()
            }
            
            if (collections_observer.collections.count > 0){
                scroll_collections()
                
                Spacer().frame(height: 15)
                
                HStack {
                    Text("Select training time").font(.title).fontWeight(.bold).foregroundColor(.white)
                    Spacer()
                }
                
                scroll_times()
                
                
            } else {
                Text("You have no collections :(")
            }
            
            Spacer()

            
            Button(action: {
                self.acrivity_attempted = true
                self.game_words = []
                self.get_game_words()
                if self.game_words.count >= min_game_words {
                    self.enough_words_selected = true
                    self.testing_state.game_words = self.game_words
                    self.training_state.now_training = false
                    self.testing_state.now_testing = true
                    
                    self.chosen_training = false
                    self.chosen_testing = true
                } else {
                    self.enough_words_selected = false
                }
            }) {
                Text("Test")
            }.disabled(chosen_collections == [] || chosen_training)
                .buttonStyle(BigButtonStyle())
            
            Spacer().frame(height: 15)
            
            Button(action: {
                self.acrivity_attempted = true
                self.game_words = []
                self.get_game_words()
                if self.game_words.count >= min_game_words {
                    self.enough_words_selected = true
                    self.training_state.game_words = self.game_words
                    self.training_state.training_time = self.chosen_time
                    self.testing_state.now_testing = false
                    self.training_state.now_training = true
                    
                    self.chosen_training = true
                    self.chosen_testing = false
                } else {
                    self.enough_words_selected = false
                }
            }) {
                Text("Train")
            }.disabled(chosen_collections == [] || !time_selected || chosen_testing)
                .buttonStyle(BigButtonStyle())
            
            Spacer()
            
            Text("Nothing to learn, select more")
                .foregroundColor(Color.white.opacity(
                    (!enough_words_selected && acrivity_attempted) ? 1.0 : 0.0)
                )
            
        }
        .padding()
        .frame(minHeight: geom.size.height)
        
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
