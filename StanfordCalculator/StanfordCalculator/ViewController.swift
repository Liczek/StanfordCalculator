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
            print("func touchDigit")
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
            print("func touchDigit")
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
    
    //private bo tylko ten VC ma mieć do niego dostęp
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
            print("getujesz wartość z display.text(poprzez displayeValue): \(displayValue) i zapisujesz do brain.accumulator")
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result {
            displayValue = result
            print("{set} displayValue = String(newValue/brain.result/brain.accumulator)")
        }
        
    }
    
    
    
}

