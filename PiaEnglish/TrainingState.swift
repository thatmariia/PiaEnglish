//
//  TrainingState.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 01/06/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import Foundation

class TrainingState : ObservableObject {
    @Published var view_count = 0
    @Published var training_flow : [[String : Any]] = []
}
