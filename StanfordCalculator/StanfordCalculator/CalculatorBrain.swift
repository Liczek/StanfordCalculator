//
//  CalculatorBrain.swift
//  StanfordCalculator
//
//  Created by Paweł Liczmański on 06.05.2017.
//  Copyright © 2017 Paweł Liczmański. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    // optional bo na początku nie mamy żadnych wartości dodanych przez operand
    private var accumulator: Double?
    
    func performOperation(_ symbol: String) {
        switch mathematicalSymbol {
        case "π":
            displayValue = Double.pi
            print("performOperation π")
        case "√":
            print("performOperation √ of displeyValue: \(displayValue)")
            displayValue = sqrt(displayValue)
        default:
            break
        }

        
        
    }
    
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
        print("brain.accumulator: \(accumulator)")
        
        
        print("func brain.setOperand")
    }
    
    // optional bo w trakcie dodawania operandów do accumulation result może jeszcze nie istnieć np. 5 x ... jeszcze nie istnieje result dopiero jak będzie 5 x 3 =
    var result: Double? {
        
        get {
            return accumulator
        }
        
    }
    
    
    
    
}
