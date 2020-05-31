//
//  SelectedStyle.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 31/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import Foundation
import SwiftUI

struct SelectionButtonStyle: ButtonStyle {
    
    var is_active: Bool
    
    func makeBody(configuration: SelectionButtonStyle.Configuration) -> some View {
        configuration.label
            .padding(10)
            
            .background(
                Color.white.opacity(configuration.isPressed || is_active ? 1.0 : 0.3)
            ).cornerRadius(40)
            
            .foregroundColor(
                configuration.isPressed || is_active ? Color("GradEnd").opacity(1.0) : Color.white.opacity(1.0)
            )
            
            .font(.subheadline)
            
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}
