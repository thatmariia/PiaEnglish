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

let grid_size = 8

let eng_capital_letters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]

let rus_allowed = "АаБбВвГгДдЕеЁёЖжЗзИиЙйКкЛлМмНнОоПпРрСсТтУуФфХхЦцЧчШшЩщЪъЫыЬьЭэЮюЯя -'"
let eng_allowed = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ -'"

let rus_alphabet = "АаБбВвГгДдЕеЁёЖжЗзИиЙйКкЛлМмНнОоПпРрСсТтУуФфХхЦцЧчШшЩщЪъЫыЬьЭэЮюЯя"
let eng_alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ -'"

func word_matching(db_word: String, comp_word: String) -> Bool {

    let word_cap = comp_word.prefix(1).uppercased() + comp_word.dropFirst()
    if db_word.contains(comp_word) ||
        db_word.contains(comp_word.uppercased()) ||
        db_word.contains(comp_word.lowercased()) ||
        db_word.contains(word_cap) {
        return true
    }
    
    return false
}

let username = "piazok"

func format_string(str: String) -> String {
    return str.prefix(1).uppercased() + str.dropFirst().lowercased()
}

var default_training_time = 1
