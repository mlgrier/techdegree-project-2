//
//  GameSounds.swift
//  EnhanceQuizStarter
//
//  Created by Marco Grier on 1/3/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import AVFoundation

var mySoundPlayer = AVAudioPlayer()

func playSoundFile(soundName: String, soundFileType: String) {
    
    let audioFileURL = Bundle.main.url(forResource: soundName, withExtension: soundFileType)
    
    do {
        try mySoundPlayer = AVAudioPlayer(contentsOf: audioFileURL!)
    } catch let error {
        print(error.localizedDescription)
    }
    
    mySoundPlayer.play()
    
}
