//
//  CustomTabItemButtonStyle.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 04/06/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import Foundation
import SwiftUI

struct CustomTabItemButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(10)
            
            .foregroundColor(
                configuration.isPressed ? Color("GradCenter") : .white
            )
    }
}
