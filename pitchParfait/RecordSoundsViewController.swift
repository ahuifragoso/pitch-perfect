
//
//  RecordSoundsViewController.swift
//  pitchParfait
//
//  Created by Ahui Fragoso Iñiguez on 5/29/15.
//  Copyright (c) 2015 Ahui Fragoso Iñiguez. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordInProgress: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    
    //Declared Globally
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordButton.enabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordButton(sender: UIButton) {
        println("grabación en progreso maifrend")
        //Mostrar el texto de "grabando"
        //Grabar la voz del usuario
        recordInProgress.hidden = false
        stopButton.hidden = false
        recordButton.enabled = false
        //Todo: Grabar
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        //Lo de abajo lo quito para no grabar una y otra vez nuevos, y hacer un solo archivo
        //let currentDateTime = NSDate()
        //let formatter = NSDateFormatter()
        //formatter.dateFormat = "ddMMyyyy-HHmmss"
        
        let recordingName = "myaudio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if (flag)
        {
        //TODO: 1 Save The Recorded Audio
            recordedAudio = RecordedAudio()
            recordedAudio.filePathUrl = recorder.url
            recordedAudio.title = recorder.url.lastPathComponent
        //TODO: 2 Move to the next Scene
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
        else{
            println("No se grabo nada maifrend")
            recordButton.enabled = true
            stopButton.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier=="stopRecording"){
            let playSoundsVC:playSoundViewController=segue.destinationViewController as! playSoundViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }

    @IBAction func stopRecording(sender: UIButton) {
        recordInProgress.hidden = true
        println("ya se termino de grabar maifrend")
        stopButton.hidden = true
        recordButton.enabled = true
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
}

