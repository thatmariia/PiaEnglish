//
//  TestView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 26/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        return NavigationView{
            ZStack(alignment: .top){
                
                PiaBackground().edgesIgnoringSafeArea(.all)
                
                Text("TESTINGGG")
                    
                
            }
            
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
