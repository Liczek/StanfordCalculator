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
        } else {
            display.text = digit
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
    
    private var brain = CalculationBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        //Jak ktoś kliknie przycisk operacji:
        //1. wysyłamy dotychczas wprowadzone liczby czyli operand
        
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        //2. przesyłamy rodzaj klikniętego symbolu
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
            print(mathematicalSymbol)
        }
        
        //3. zwracamy wartość na wyświetlacz po dokonaniu obliczeń w brain
        if let result = brain.result {
            displayValue = result
        }
    }
}

