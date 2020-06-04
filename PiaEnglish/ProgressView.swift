//
//  ProgressView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 04/06/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct ProgressView: View {
    
    @EnvironmentObject var testing_state: TestingState
    @EnvironmentObject var training_state: TrainingState
    
    fileprivate func get_percetange(of num: Int, out_of denum: Int) -> Double {
        return Double(num) / Double(denum)
    }
    
    fileprivate func is_achieved(by circle: Int) -> Bool {
        let val = 0.25 * Double(circle)
        if testing_state.now_testing {
            let percentage = get_percetange(of:     testing_state.view_count+1,
                                            out_of: testing_state.testing_flow.count)
            return percentage >= val
        }
        if training_state.now_training {
            let percentage = get_percetange(of:     training_state.view_count+1,
                                            out_of: training_state.training_flow.count)
            return percentage >= val
        }
        return false
    }
    
    fileprivate func quit() {
        if testing_state.now_testing {
            testing_state.now_testing = false
            testing_state.game_words = []
            testing_state.view_count = 0
            testing_state.testing_flow = []
            
            testing_state.curr_total_score = 0
            testing_state.max_total_score = 0
            testing_state.cur_score_word = [:]
            testing_state.max_score_word = [:]
            return
        }
        
        if training_state.now_training {
            training_state.now_training = false
            training_state.game_words = []
            training_state.training_time = 0
            training_state.view_count = 0
            training_state.training_flow = []
            return
        }
    }
    
    var body: some View {
        let s = CGFloat(15)
        return HStack {
            Button(action: {
                self.quit()
            }) {
                Image(systemName: "multiply.circle.fill").font(.system(size: s))
            }
            Image(systemName: is_achieved(by: 1) ? "circle.fill" : "circle").font(.system(size: s))
            Image(systemName: is_achieved(by: 2) ? "circle.fill" : "circle").font(.system(size: s))
            Image(systemName: is_achieved(by: 3) ? "circle.fill" : "circle").font(.system(size: s))
        }.foregroundColor(.white)
        
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}
