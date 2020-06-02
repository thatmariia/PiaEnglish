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
    
    let db_word_copy = db_word.trimmingCharacters(in: .whitespacesAndNewlines)
    let comp_word_copy = comp_word.trimmingCharacters(in: .whitespacesAndNewlines)
    
    let db_lc = db_word_copy.lowercased()
    let comp_lc = comp_word_copy.lowercased()
    
    if db_lc.contains(comp_lc) {
        return true
    }
    
    return false
}

let username = "piazok"

func format_string(str: String) -> String {
    let trimmed_str = str.trimmingCharacters(in: .whitespacesAndNewlines)
    return trimmed_str.prefix(1).uppercased() + trimmed_str.dropFirst().lowercased()
}

var default_training_time = 3
var min_game_words = 2
