//
//  ViewController.swift
//  retroCalculatorNew
//
//  Created by skwong on 12/3/16.
//  Copyright © 2016 fedup. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController
    {
    
    @IBOutlet weak var outpulLabel: UILabel!
    
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var currentOperation = Operation.Empty
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    enum Operation: String
    {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Equal = "="
        case Empty = "Empty"
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
   //set path to sound file
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do
        {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        }
        catch let err as NSError
        {
            print(err.debugDescription)
        }

    }
    
    @IBAction func numberPressed(sender: UIButton)
    {
        playSound()
        
        runningNumber = runningNumber + "\(sender.tag)"
        outpulLabel.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject)
    {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject)
    {
        processOperation(operation: .Multiply)
    }
    @IBAction func onSubtractPressed(sender: AnyObject)
    {
        processOperation(operation: .Subtract)
    }
    @IBAction func onAddPressed(sender: AnyObject)
    {
        processOperation(operation: .Add)
    }
    @IBAction func onEqualPressed(sender: AnyObject)
    {
        processOperation(operation: currentOperation)
    }
    
    
    
    func playSound()
    {
        if btnSound.isPlaying
        {
            btnSound.stop()
        }
        btnSound.play()
        
    }
    
    func processOperation(operation: Operation)
    {
        if currentOperation != Operation.Empty
        {
            if runningNumber != ""
            {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply
                {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }
                
                else if currentOperation == Operation.Divide
                {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"                }
                
                else if currentOperation == Operation.Subtract
                {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                
                else if currentOperation == Operation.Add
                {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outpulLabel.text = result
                
            }
            
            currentOperation = operation
            }
            else
            {//this is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
            }
    }
}
