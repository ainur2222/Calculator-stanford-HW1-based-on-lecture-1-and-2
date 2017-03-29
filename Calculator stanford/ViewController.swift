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
    var countDots = 0  //считаем кол-во точек в числе. для ввода корректного Double
    
    @IBAction func touchDigit(_ sender: UIButton) {
        if sender.currentTitle == "." {
            countDots = countDots + 1
        }
        if countDots < 2 {
            let digit = sender.currentTitle!
            print("\(digit) was pressed")
            if userIsInTheMiddleOfTyping {
                let textCurrentlyOnDisplay = display.text!
                display.text = textCurrentlyOnDisplay + digit
            } else {
                display?.text = digit
                userIsInTheMiddleOfTyping = true
            }
        } else {
            brain.returnToInitialState()
            display.text = "Illegal number. Press C"
            
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
    
    private var brain = CalculatorBrain()   // brain это наш обьект нашей единственной главной структуры в файле modelInMVC
    
    
    @IBAction func performOperation(_ sender: UIButton) {
        if display.text != "Illegal number. Press C"{
            if userIsInTheMiddleOfTyping {
                brain.setOperand(displayValue)
                userIsInTheMiddleOfTyping = false
            }
            // убираем возможность дописывать цифры после того как нажали на pi
            if let mathematicalSymbol = sender.currentTitle {
                brain.performOperation(mathematicalSymbol)
            }
            if let result = brain.result {   // if brain.result is determined
                displayValue = result
            }
        }
    }
    
    
    //    @IBAction func CButton(_ sender: UIButton) {
    //        display.text = "0"
    //        brain.returnToInitialState()
    //        if userIsInTheMiddleOfTyping {
    //            userIsInTheMiddleOfTyping = false
    //        } else {
    //        }
    //    }
    
    @IBAction func cButton(_ sender: UIButton) {
        display.text = "0"
        countDots = 0
        brain.returnToInitialState()
        if userIsInTheMiddleOfTyping {
            userIsInTheMiddleOfTyping = false
        }
        
    }
    
    
    
}









