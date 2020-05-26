//
//  LearnView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 25/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct LearnView: View {
    
    @ObservedObject var collections_observer = CollectionsObserver()
    
    @State var collections_chosen: [Collection] = []
    
    fileprivate func get_color(collection: Collection) -> Color{
        if (collections_chosen.contains(collection)) {
            return .green
        }
        return .red
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                Text("Choose collections")
                
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack {
                        
                        ForEach(0..<collections_observer.collections.count, id: \.self) { i in
                            
                            Button(action: {
                                
                                let collection = self.collections_observer.collections[i]
                                
                                if (self.collections_chosen.contains(collection)) {
                                    if let index = self.collections_chosen.firstIndex(of: collection) {
                                        self.collections_chosen.remove(at: index)
                                    }
                                } else {
                                    self.collections_chosen.append(collection)
                                }
                                
                                print("chosen collections = ", self.collections_chosen)
                                
                            }) {
                                Text(self.collections_observer.collections[i].name).foregroundColor(self.get_color(collection: self.collections_observer.collections[i]))
                            }
                            
                        }
                        
                    }
                }
                Spacer()
                
                // testing
                
                NavigationLink(destination: TestView()) {
                    Text("Test")
                }.disabled(collections_chosen == [])
                
                // training
                
                NavigationLink(destination: TrainView()) {
                    Text("Train")
                }.disabled(collections_chosen == [])
                
                Spacer()
                
            }
        }
    }
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
    }
}
