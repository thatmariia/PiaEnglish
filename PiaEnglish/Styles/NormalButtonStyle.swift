//
//  NormalButtonStyle.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 31/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import Foundation
import SwiftUI

struct NormalButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(10)
            
            .foregroundColor(
                configuration.isPressed ? Color("GradEnd").opacity(1.0) : Color.white.opacity(1.0)
            )
            .background(Color.white.opacity(configuration.isPressed ? 1.0 : 0.3)).cornerRadius(40)
            
            .overlay(RoundedRectangle(cornerRadius: 40)
                .stroke(Color.white, lineWidth: 2)
            )
            
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}
