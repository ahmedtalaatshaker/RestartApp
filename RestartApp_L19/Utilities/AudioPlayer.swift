//
//  AudioPlayer.swift
//  RestartApp_L19
//
//  Created by Ahmed Talaat on 28/11/2022.
//
import AVFoundation
import Foundation

class AudioPlayer {
    
    static var shared = AudioPlayer()
    var audioPlayer: AVAudioPlayer?
    
    private init() { }

    func playSound(sound: String, type: String){
        if let path = Bundle.main.path(forResource: sound, ofType: type){
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            }catch{
                print("could not play the sound file")
            }
        }
    }
}
