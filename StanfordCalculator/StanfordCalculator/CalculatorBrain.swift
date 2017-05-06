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
    
    mutating func performOperation(_ symbol: String) {
        switch symbol {
        case "π":
            accumulator = Double.pi
            print("brain.performOperation π")
        case "√":
            if let operand = accumulator {
                print("brain.performOperation √ of displeyValue/ brain.accumulator: \(operand)")
                accumulator = sqrt(operand)
            }
        default:
            break
        }

        
        
    }
    
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    // optional bo w trakcie dodawania operandów do accumulation result może jeszcze nie istnieć np. 5 x ... jeszcze nie istnieje result dopiero jak będzie 5 x 3 =
    var result: Double? {
        
        get {
            return accumulator
        }
        
    }
    
    
    
    
}
