//
//  Globals.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 25/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage
import AVFoundation

let storage = Storage.storage()
let storage_bucket = "gs://piaenglish-915c2.appspot.com/"

var player = AVAudioPlayer()

let db = Firestore.firestore()

let grid_size = 5

