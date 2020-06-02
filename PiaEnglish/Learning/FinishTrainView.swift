//
//  FinishTrainView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 02/06/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct FinishTrainView: View {
    @EnvironmentObject var training_state: TrainingState
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
                    self.training_state.now_training = false
                    self.training_state.game_words = []
                    self.training_state.training_time = 0
                    self.training_state.view_count = 0
                    self.training_state.training_flow = []
                }) {
                    Text("Done!")
                }.buttonStyle(BigButtonStyle())
                
                Spacer()
            }.padding()
            
            }.navigationBarTitle("").navigationBarHidden(true)
    }
}
