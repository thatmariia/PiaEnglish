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
        //UITabBar.appearance().barTintColor = UIColor(named: "GradEnd")
        UITabBar.appearance().isTranslucent = true
    }
    
    var body: some View {
        TabView{
            
            LearnView(collections_observer: collections_observer)
                .tabItem {
                    Text("learn")
            }
            
            CollectionsView(collections_observer: collections_observer)
                .tabItem {
                    Text("collection")
            }
            
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
