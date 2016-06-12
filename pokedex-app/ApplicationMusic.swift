//
//  appAudio.swift
//  pokedex-app
//
//  Created by Amadeu Andrade on 12/06/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import Foundation
import AVFoundation

class ApplicationMusic {

    // MARK: - Properties
    var audioPlayer: AVAudioPlayer!
    
    
    // MARK: - Initializer
    init() {
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")
        let url = NSURL(fileURLWithPath: path!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: url)
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = -1
            playAudio()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    
    // MARK: - Auxiliary Functions
    
    func playAudio() {
        if audioPlayer.playing {
            stopAudio()
        }
        audioPlayer.play()
    }
    
    func stopAudio() {
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
    }
    
    func isPlaying() -> Bool {
        return audioPlayer.playing
    }
    
    
}