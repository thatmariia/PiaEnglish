//
//  PiaBackground.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 30/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI

struct PiaBackground: View {
    var body: some View {

        return RadialGradient(gradient: Gradient(colors: [Color("GradCenter"), Color("GradEdges")]),
                              center: .center, startRadius: 50, endRadius: 300).overlay(Color.white.opacity(0.1))
        
    }
}

struct PiaBackground_Previews: PreviewProvider {
    static var previews: some View {
        PiaBackground()
    }
}
