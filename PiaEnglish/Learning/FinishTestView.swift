//
//  FinishTestView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 02/06/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct FinishTestView: View {
    @EnvironmentObject var testing_state: TestingState
    var body: some View {
        return ZStack(alignment: .top){
            
            PiaBackground().edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                Image(systemName: "hand.thumbsup").foregroundColor(.white).font(.system(size: 40))
                
                Spacer().frame(height: 40)
                
                Text("Congratulations, you're").font(.title).fontWeight(.bold).foregroundColor(.white)
                
                Spacer().frame(height: 20)
                
                Button(action: {
                    self.testing_state.now_testing = false
                    self.testing_state.game_words = []
                    self.testing_state.view_count = 0
                    self.testing_state.testing_flow = []
                    
                    self.testing_state.curr_total_score = 0
                    self.testing_state.max_total_score = 0
                    self.testing_state.cur_score_word = [:]
                    self.testing_state.max_score_word = [:]
                }) {
                    Text("Done!")
                }.buttonStyle(BigButtonStyle())
                
                Spacer()
            }.padding()
            
        }.navigationBarTitle("").navigationBarHidden(true)
    }
}

