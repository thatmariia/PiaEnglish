//
//  FinishTestView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 02/06/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import Foundation
import SwiftUI

struct FinishTestView: View {
    @EnvironmentObject var testing_state: TestingState
    
    fileprivate func get_percetange_str(of num: Int, out_of denum: Int) -> String {
        if denum != 0 {
            let percentage = Int(round(100 * Double(num) / Double(denum)))
            return "\(percentage)%"
        } else {
            return "error"
        }
    }
    
    
    var body: some View {
        
        print("FINISH TEST \n")
        print("curr score per word = ", testing_state.cur_score_word)
        print("max score per word = ", testing_state.max_score_word)
        print("curr score = ", testing_state.curr_total_score)
        print("max score = ", testing_state.max_total_score)
        
        return ZStack(alignment: .top){
            
            PiaBackground().edgesIgnoringSafeArea(.all)
            
            
            
            VStack {
                
                Spacer().frame(height: 20)
                
                HStack{
                    Spacer()
                    Image(systemName: "rosette").foregroundColor(.white).font(.system(size: 40))
                    Text(get_percetange_str(of: testing_state.curr_total_score, out_of: testing_state.max_total_score))
                        .font(.system(size: 40)).fontWeight(.heavy).foregroundColor(.white)
                    Spacer()
                }
                
                Spacer().frame(height: 20)
                
                if (testing_state.cur_score_word != [:]) {
                    ScrollView(.vertical, showsIndicators: false){
                        Divider()
                        ForEach(testing_state.game_words, id: \.self) { word in
                            VStack{
                                HStack{
                                    
                                    Text(format_string(str: word.english))
                                    Spacer()
                                    Text(self.get_percetange_str(of:     self.testing_state.cur_score_word[word]!,
                                                                 out_of: self.testing_state.max_score_word[word]!))
                                    
                                }
                                
                                Divider()
                            }
                        }
                    }
                }
                
                Spacer()
                
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
                
                Spacer().frame(height: 20)
                
            }.padding()
            
        }.navigationBarTitle("").navigationBarHidden(true)
    }
}

