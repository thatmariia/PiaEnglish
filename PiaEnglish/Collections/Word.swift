//
//  Word.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 25/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import Foundation
import Firebase
import AVFoundation

struct Word : Hashable, Identifiable {
    var id = UUID()
    
    var english: String
    var russian: String
    var learned_by: [String]
}

func get_word(from word_snap: QueryDocumentSnapshot) -> Word{
    let word = Word(english:    word_snap.get("english")    as! String,
                    russian:    word_snap.get("russian")    as! String,
                    learned_by: word_snap.get("learned_by") as! [String])
    return word
}

func get_absolute_audio_path(of word: String) -> String{
    return "words/\(word).m4a"
}

func get_audio_path(of word: String) -> String{
    return "\(word).m4a"
}

func synthesize_audio(of text: String) {
    let utterance = AVSpeechUtterance(string: text)
    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
    let synthesizer = AVSpeechSynthesizer()
    synthesizer.speak(utterance)
    utterance.rate = 0.1
}

func play_audio_of(word: String) {
    
    let path = get_absolute_audio_path(of: word)
    let local_path = get_audio_path(of: word)
    
    let ref = storage.reference()
    
    /// Create a reference to the file you want to download
    let audio_ref = ref.child(path)
    let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(local_path)
    
    /// Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
    audio_ref.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
        if let error = error {
            
            /// Error downloading file - synthesize word
            print(error)
            synthesize_audio(of: word)
            
        } else {
            
            /// Play the recovered audio file
            if let d = data {
                do {
                    try d.write(to: fileURL)
                    player = try AVAudioPlayer(contentsOf: fileURL)
                    player.play()
                } catch {
                    /// Another error - synthesize
                    print("err in playing: ", error)
                    synthesize_audio(of: word)
                }
            }
            
        }
    }
}
