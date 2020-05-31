//
//  NormalTextFieldStyle.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 31/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import Foundation
import SwiftUI

struct NormalTextFieldStyle: TextFieldStyle {
    
    var is_focused: Bool
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
        
            .foregroundColor(
                is_focused ? Color("GradEnd").opacity(1.0) : Color.white.opacity(1.0)
            )
            .background(Color.white.opacity(is_focused ? 1.0 : 0.3)).cornerRadius(40)
            
            .overlay(RoundedRectangle(cornerRadius: 40)
                .stroke(Color.white, lineWidth: 2)
            )
    }
    
}


