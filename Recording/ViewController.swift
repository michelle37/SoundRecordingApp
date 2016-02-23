//
//  ViewController.swift
//  Recording
//
//  Created by Michelle Lee on 2/15/16.
//  Copyright © 2016 Michelle Lee. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate{

    @IBOutlet var RecodingButton: UIButton!
    @IBOutlet var PlayButton: UIButton!
    
    var soundRecorder : AVAudioRecorder()
    var soundPlayer : AVAudioPlayer()
    var fileName = "audio.m4a"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //setup recorder settings
    func setupRecorder(){
        let recordSettings =
            [
            AVSampleRateKey : NSNumber(float: Float(44100.0)),
            AVFormatIDKey : NSNumber(int: Int32(kAudioFormatMPEG4AAC)),
            AVNumberOfChannelsKey : NSNumber(int: 1),
            AVEncoderAudioQualityKey : NSNumber(int: Int32(AVAudioQuality.Max.rawValue))
            ]
        // test checking errors
        var error : NSError?
        
        soundRecorder = AVAudioRecorder(URL : getFileURL(), settings: [NSObject : AnyObject]!, error: &error)
        if let err = error{
            NSLog("Something wrong")
        }
        else{
            soundRecorder.delegate = self
            soundRecorder.prepareToRecord()
            
        }
    }
    // setup the path for audio file that will be stored
    func getCacheDirectory() -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.UserDomainMask, true) as! [String]

        return paths[0]
    }
    
    func getFileURL() -> NSURL {
        let path = getCacheDirectory().stringByAppendingString(fileName)
        let filePath = NSURL(fileURLWithPath: path)
        return filePath
        
    }


    @IBAction func RecordingButton(sender: UIButton) {
        
        if sender.titleLabel?.text == "Record"{
            soundRecorder.record()
            sender.setTitle("Stop", forState: normal)
    }
    
    @IBAction func PlayButton(sender: UIButton) {
    }

}

