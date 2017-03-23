//
//  ViewController.swift
//  Calculator stanford
//
//  Created by Айнур Самигуллин on 23/03/2017.
//  Copyright © 2017 Айнур Самигуллин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var display: UILabel!  // explicitly unwrapped optional, теперь можно не писать display!, а можно писать только display
    
    
    
    
    var userIsInTheMiddleOfTyping = false
    
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        print("\(digit) was pressed")
        if userIsInTheMiddleOfTyping {
            let textCurrentlyOnDisplay = display.text!
            display.text = textCurrentlyOnDisplay + digit
        } else {
            display?.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    
    
    
    @IBAction func performOperation(_ sender: UIButton) {
        userIsInTheMiddleOfTyping = false  // убираем возможность писать цифры после того как нажали на pi
        
        if let mathematicalSymbol = sender.currentTitle {
            switch mathematicalSymbol {
            case "pi":
                //display.text = String(Double.pi)
                displayValue = Double.pi
            case "√":
//                let operant = Double(display.text!)!
//                display.text = String(sqrt(operant))
                displayValue = sqrt(displayValue)
            default:
                break
            }
            
            
        }
        
    }
    
    
    
    
    
    
}

 
