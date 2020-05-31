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
        return LinearGradient(gradient: Gradient(colors: [Color("GradStart"), Color("GradEnd")]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

struct PiaBackground_Previews: PreviewProvider {
    static var previews: some View {
        PiaBackground()
    }
}
