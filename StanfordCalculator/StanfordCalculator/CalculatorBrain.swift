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
    
    //enum daje możliwość stworzenia opcji
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "+/-" : Operation.unaryOperation( { -$0 } ),
        "×" : Operation.binaryOperation( { $0 * $1 } ),
        "÷" : Operation.binaryOperation( { $0 / $1 } ),
        "+" : Operation.binaryOperation( { $0 + $1 } ),
        "-" : Operation.binaryOperation( { $0 - $1 } ),
        "=" : Operation.equals
        
    ]
    
    
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
        
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double,Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
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
