//
//  GameSounds.swift
//  EnhanceQuizStarter
//
//  Created by Marco Grier on 1/3/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation
import AudioToolbox

var gameSound: SystemSoundID = 0
var buzzerSound: SystemSoundID = 0
var currectSound: SystemSoundID = 0

func loadGameSounds() {
    let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
    let soundUrl = URL(fileURLWithPath: path!)
    AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    
    let path2 = Bundle.main.path(forResource: "CorrectAnswer", ofType: "mp3")
    let soundUrl2 = URL(fileURLWithPath: path2!)
    AudioServicesCreateSystemSoundID(soundUrl2 as CFURL, &currectSound)
    
    let path3 = Bundle.main.path(forResource: "buzzersound", ofType: "mp3")
    let soundUrl3 = URL(fileURLWithPath: path3!)
    AudioServicesCreateSystemSoundID(soundUrl3 as CFURL, &buzzerSound)
}


func playGameStartSound() {
    AudioServicesPlaySystemSound(gameSound)
}

func currectAnswerSound() {
    AudioServicesPlaySystemSound(currectSound)
}

func wrongAnswerSound() {
    AudioServicesPlaySystemSound(buzzerSound)
}
