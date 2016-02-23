//
//  ViewController.swift
//  SoundRecording
//
//  Created by Michelle Lee on 2/16/16.
//  Copyright © 2016 Michelle Lee. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate {
    


    
    @IBOutlet weak var Record: UIButton!
    @IBOutlet weak var Text: UILabel!
    @IBOutlet weak var Stop: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    override func viewDidLoad() {

        
    }
    

      
   override func viewWillAppear(animated: Bool) {
        super.viewDidLoad()
        Text.hidden = true
        Stop.hidden = true
        Record.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func RecordingBtn(sender: UIButton) {
        //set the audio path to store in document directory on your device
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        //settings
        //setup the recording file name
        let recordingName = "my_audio.wav"
        //path array variable
        let pathArray = [dirPath, recordingName]
        //setup the file path
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        //set the UIviewcontroller to be the delegate of audioRecorder
        audioRecorder.delegate = self
    
        Text.hidden = false
        Stop.hidden = false
        Record.enabled = false
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
        // step1 - save the recorded audio
        recordedAudio = RecordedAudio()
        recordedAudio.filePathUrl = recorder.url
        recordedAudio.Title = recorder.url.lastPathComponent
        
        //step2 - move to the next scene aka perform segue
        self.performSegueWithIdentifier("StopRecording", sender: recordedAudio)
        }else{
            print("Recording was not successful")
            Record.enabled = true
            Record.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "StopRecording"){
            let playSoundsVC:RecordPlayViewController = segue.destinationViewController as! RecordPlayViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
            
        }
    }
    @IBAction func Stopbtn(sender: UIButton) {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }


}

