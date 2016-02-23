//
//  RecordPlayViewController.swift
//  SoundRecording
//
//  Created by Michelle Lee on 2/16/16.
//  Copyright © 2016 Michelle Lee. All rights reserved.
//

import UIKit
import AVFoundation

class RecordPlayViewController: UIViewController {

    var audioPlay : AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var autoEngine:AVAudioEngine!
    
    
    @IBOutlet weak var slow: UIButton!
    @IBOutlet weak var fast: UIButton!
    @IBOutlet weak var stop: UIButton!
    @IBOutlet weak var ChipMonk: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //instance of Avaudioengine
        autoEngine = AVAudioEngine()
        
        //setup the filepath for the audio file
//        if let filePath = NSBundle.mainBundle().pathForResource("ego", ofType: "mp3"){
//            //convert filepath from string to URL
//            let filePathURL = NSURL.fileURLWithPath(filePath)
//            //create an instance of AVAudioPlay
//            
//            
//        }
//        else{
//            print("Something went wrong")
//        }
        audioPlay = try? AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlay.enableRate = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func SlowBtn(sender: UIButton) {
        audioPlay.rate = 0.5
        audioPlay.currentTime = 0.0
        audioPlay.play()
        
    }
    
    @IBAction func Fastbtn(sender: UIButton) {
        audioPlay.rate = 2.0
        audioPlay.currentTime = 0.0
        audioPlay.play()
    }

    @IBAction func Stopbtn(sender: UIButton) {
        audioPlay.stop()
    }

    @IBAction func ChipMonkBtn(sender: UIButton) {
    }

}
