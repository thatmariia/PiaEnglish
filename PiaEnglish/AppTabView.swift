//
//  TabView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 25/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI
import Foundation

struct AppTabView: View {
    
    @ObservedObject var collections_observer = CollectionsObserver()
    
    @EnvironmentObject var testing_state: TestingState
    @EnvironmentObject var training_state: TrainingState
    
    init() {
        UITabBar.appearance().barTintColor = UIColor(named: "GradEdges")
        //UITabBar.appearance().isTranslucent = true
    }
    
    var body: some View {
        ZStack{
                TabView{
                    
                    LearnView()
                        .tabItem {
                            VStack{
                                Image(systemName: "book.circle")
                                .font(.system(size: 30, weight: Font.Weight.ultraLight))
                                Text("training")
                               
                            }
                            
                    }
                    
                    CollectionsView()
                        .tabItem {
                            VStack{
                            Image(systemName: "paperclip.circle")
                                .font(.system(size: 30, weight: Font.Weight.ultraLight))
                            Text("collections")
                            }
                    }.disabled(testing_state.now_testing || training_state.now_training)
                    
                }.accentColor(.white)
        }
        
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
