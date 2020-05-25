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
    var body: some View {
        TabView{
            
            LearnView()
                .tabItem {
                    Text("learn")
            }
            
            CollectionsView()
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
