//
//  PiaButtonStyle.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 30/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import Foundation
import SwiftUI

struct BigButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            
            .frame(width: 250)
            .padding(15)
            
            .foregroundColor(
                configuration.isPressed ? Color("GradEnd").opacity(1.0) : Color.white.opacity(1.0)
            )
            .background(Color.white.opacity(configuration.isPressed ? 1.0 : 0.3)).cornerRadius(40)
            //.fill()
            
            .overlay(RoundedRectangle(cornerRadius: 40)
                .stroke(Color.white, lineWidth: 2)
            )
            
            .font(.title)
            
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}
