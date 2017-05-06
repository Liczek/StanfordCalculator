//
//  ViewController.swift
//  StanfordCalculator
//
//  Created by Paweł Liczmański on 06.05.2017.
//  Copyright © 2017 Paweł Liczmański. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            
            display.text = textCurrentlyInDisplay + digit
            print(textCurrentlyInDisplay + digit)
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
            print("rozpoczęto wprowadzanie danych")
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
        
        userIsInTheMiddleOfTyping = false
        if let mathematicalSymbol = sender.currentTitle {
            switch mathematicalSymbol {
            case "π":
                displayValue = Double.pi
                case "√":
                displayValue = sqrt(displayValue)
                
            default:
                break
            }
        }
        
    }
    
    
    
}

