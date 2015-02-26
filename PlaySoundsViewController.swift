//
//  PlaySoundsViewController.swift
//  SoundEffect
//
//  Created by Innocenzo Tremamondo on 02/01/15.
//  Copyright (c) 2015 LabNova. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

       override func viewDidLoad() {
        super.viewDidLoad()
        
//        if var filePath = NSBundle.mainBundle().pathForResource("magnifico", ofType: "mp3") {
//           var filePathUrl = NSURL.fileURLWithPath(filePath)
//       
//        } else {
//             println("il percorso del file è vuoto")
//        }
        
        
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        //creare l'object AVAudioEngine
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error:nil)
        
    }
    
    @IBAction func stopAudio(sender: AnyObject) {
        audioPlayer.stop()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        //creare l'object AVAudioPlayerNode
        var audioPlayerNode = AVAudioPlayerNode()
        
        //attaccare "AVAudioPlayerNode" con "AVAudioEngine"
        audioEngine.attachNode(audioPlayerNode)
        
        //creare AVAudioTimePitch
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        
        //attaccare AVAudioPlayerNode con AVAudioUnitTimePitch
        audioEngine.attachNode(changePitchEffect)
        
        //connettere AVAudioUnitTimePitch con l'output
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format:nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format:nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime:nil, completionHandler:nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
   
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 1.5
        //far cominciare l'audio da zero
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
