//
//  ViewController.swift
//  Text To Speech
//
//  Created by Harendra Sharma on 21/02/19.
//  Copyright © 2019 Harendra Sharma. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVSpeechSynthesizerDelegate  {

    // IBOutlets
    @IBOutlet weak var SpeakLbl: UILabel!
    @IBOutlet weak var SpeakBtn: UIButton!
    
    // Data
    
    var arrSpeechCount = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "eight", "nine", "ten"]
    var count : Int = 0
    let speechSynthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speechSynthesizer.delegate = self
        
    }


    //----------------------------------------------------------------
    // MARK:- AVSpeechSynthesixerDelegate
    //----------------------------------------------------------------
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        SpeakLbl.text = utterance.speechString
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        speechSynthesizer.stopSpeaking(at: .word)
        
        count += 1
        if count < arrSpeechCount.count {
            let speechUtterance = AVSpeechUtterance(string: (arrSpeechCount[count]))
            DispatchQueue.main.async {
                self.speechSynthesizer.speak(speechUtterance)
            }
        } else {
            count = 0
            SpeakBtn.isSelected = false
        }
    }
    
    //----------------------------------------------------------------

    
    
    @IBAction func PlayPause(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            Start()
        }else {
            Pause()
        }
    }
    
    
    func Pause()  {
        speechSynthesizer.pauseSpeaking(at: .immediate)
    }
    
    func Start()  {
        // Code to start speech
        if speechSynthesizer.isSpeaking {
            speechSynthesizer.stopSpeaking(at: .immediate)
        } else {
            let speechUtterance = AVSpeechUtterance(string: (arrSpeechCount[count]))
            DispatchQueue.main.async {
                self.speechSynthesizer.speak(speechUtterance)
            }
        }
    }
    
}

