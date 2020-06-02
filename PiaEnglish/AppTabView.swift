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
    
    init() {
        UITabBar.appearance().barTintColor = UIColor(named: "GradEnd")
        //UITabBar.appearance().isTranslucent = true
    }
    
    var body: some View {
        ZStack{
                TabView{
                    
                    LearnView(/*collections_observer: self.collections_observer, all_words_observer: AllWordsObserver()*/)
                        .tabItem {
                            VStack{
                                Image(systemName: "book.circle")
                                .font(.system(size: 30, weight: Font.Weight.ultraLight))
                                Text("training")
                               
                            }
                            
                    }
                    
                    CollectionsView(/*collections_observer: self.collections_observer*/)
                        .tabItem {
                            VStack{
                            Image(systemName: "paperclip.circle")
                                .font(.system(size: 30, weight: Font.Weight.ultraLight))
                            Text("collections")
                            }
                    }
                    
                }.accentColor(.white)
        }
        
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
