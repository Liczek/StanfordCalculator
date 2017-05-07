//
//  CalculatorBrain.swift
//  StanfordCalculator
//
//  Created by Paweł Liczmański on 06.05.2017.
//  Copyright © 2017 Paweł Liczmański. All rights reserved.
//

import Foundation

struct CalculationBrain {
    
    
    private var accumulator: Double?
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) ->Double)
        case equals
    }
    
    private var operations: [String:Operation] = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "+/-" : Operation.unaryOperation({ -$0 }),
        "×" : Operation.binaryOperation({ $0 * $1 }),
        "÷" : Operation.binaryOperation({ $0 / $1 }),
        "+" : Operation.binaryOperation({ $0 + $1 }),
        "-" : Operation.binaryOperation({ $0 - $1 }),
        "=" : Operation.equals
    ]
        
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol]{
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let unaryFunction):
                if accumulator != nil {
                    accumulator = unaryFunction(accumulator!)
                }
            case .binaryOperation(let binaryFunction):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: binaryFunction, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    mutating func setOperand(_ operand:Double) {
        accumulator = operand
    }
    // pendingBinaryOperation zbiera firstOperand którym jest accumulator oraz symbol którym jest binaryFunction, teraz czekamy na wpisanie secondOperand i klinięcie = wtedy pobierzemy secondOperand i użyjemy funkcji PendingBinaryFunction.perform gdzie secondOperand będzie accumulator = valueDisplayed
    var pendingBinaryOperation: PendingBinaryOperation?
    
    struct PendingBinaryOperation {
        let function: ((Double,Double) -> Double)
        let firstOperand: Double
        
        func perform(with secondOperand:Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }

    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    
    
    
}
