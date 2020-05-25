//
//  WordSearchView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 25/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct WordSearchView: View {
    
    var grid: [[String]]
    var words: [String]
    
    var body: some View {
        NavigationView{
            VStack {
                
                VStack{
                    
                    Text("Words to find:")
                    ForEach(words, id: \.self) { word in
                        VStack {
                            Text(word)
                            Text("meow")
                        }
                    }
                }
                
                Spacer()
                
                // grid here
                VStack {
                    ForEach(0..<grid_size, id: \.self) { i in
                        HStack(alignment: .center) {
                            Spacer()
                            ForEach(0..<grid_size, id: \.self) { j in
                                
                                HStack{
                                ZStack{
                                    Button(action: {
                                        print("hit " + self.grid[i][j])
                                    }) {
                                        Text(self.grid[i][j])
                                    }
                                }
                                Spacer()
                                }
                                
                            }
                            
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
}

/*struct WordSearchView_Previews: PreviewProvider {
 static var previews: some View {
 WordSearchView(grid: [["A", "B", "C"], ["D", "E", "F"], ["G", "H", "I"]])
 }
 }*/
