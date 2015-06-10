//
//  playSoundViewController.swift
//  pitchParfait
//
//  Created by Ahui Fragoso Iñiguez on 5/30/15.
//  Copyright (c) 2015 Ahui Fragoso Iñiguez. All rights reserved.
//

import UIKit
import AVFoundation

class playSoundViewController: UIViewController {
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    //Inicializamos una variable como local
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        if var filePath = NSBundle.mainBundle().pathForResource("loquenofue", ofType: "mp3")
//        {
//            var filePathUrl = NSURL.fileURLWithPath(filePath)
//            
//        }
//        else {
//            println("el path no existe maifren")
//        }
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        // aqui tenía el var, se lo quitamos porque estamos inicializando la variable como local, por eso no vamos a poner eso
        audioPlayer.enableRate = true
        //inicializamos el objeto audioEngine
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    @IBAction func playSlowAudio(sender: UIButton) {
        //Play Audio bieeeeen lento aquí
        audioPlayer.stop()
        println("Reproduciendo como muero, lento")
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0
        audioPlayer.play()
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        audioPlayer.stop()
        println("Reproduciendo rapido y furioso")
        audioPlayer.currentTime = 0
        audioPlayer.rate = 1.5
        audioPlayer.play()
        
        
    }
    
    
    @IBAction func playChipMunk(sender: UIButton) {
        playAudioWithVariablePitch(1000)
        
        
        
    }
    
    func playAudioWithVariablePitch(pitch:Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()

        
    }
    
    
    
    @IBAction func playDarthVader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
        
    }
    
    
    
    
    @IBAction func stopPlaying(sender: UIButton) {
        audioPlayer.stop()
        
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
