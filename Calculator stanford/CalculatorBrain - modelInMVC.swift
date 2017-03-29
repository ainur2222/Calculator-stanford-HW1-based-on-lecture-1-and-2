//
//  CalculatorBrain - modelInMVC.swift
//  Calculator stanford
//
//  Created by Айнур Самигуллин on 23/03/2017.
//  Copyright © 2017 Айнур Самигуллин. All rights reserved.
//

import Foundation



struct CalculatorBrain {
    
    
    
    var resultIsPending = false
    
    
    private var accumulator: Double? // опциональный тип тк в начале программы аккумулор пуст => nill =) опциональный тип
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperaion((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String,Operation> = [  //set Dictionary
        "pi" : Operation.constant(Double.pi),  // Double.pi,
        "e"  : Operation.constant(M_E),        // M_E
        "√"  : Operation.unaryOperation(sqrt),       // sqrt(accumulator)
        "cos": Operation.unaryOperation(cos),        // cos
        "±"  : Operation.unaryOperation({  -$0    }),
        "×"  : Operation.binaryOperaion({  $0 * $1  }),  // CLOSURES почитать !!!
        "÷"  : Operation.binaryOperaion({  $0 / $1  }),
        "+"  : Operation.binaryOperaion({  $0 + $1  }),
        "-"  : Operation.binaryOperaion({  $0 - $1  }),
        "="  : Operation.equals,
        "x^2": Operation.unaryOperation({ $0 * $0 }),
        "x^5": Operation.unaryOperation({ $0 * $0 * $0 * $0 * $0 }),
//        "C"  : Operation.constant(0),
        "sin": Operation.unaryOperation(sin)
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation5 = operations[symbol] {
            switch operation5 {
            case .constant(let Value):
                accumulator = Value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperaion(let function):
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
            accumulator = pendingBinaryOperation!.perforn(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {   // делаем еще один стракт для решения проблемы с "бо он очень часто будет not set, как в примере "5 *" - не установлен, а потом "5 * 3" и вот теперь только он не nill"
        let function: (Double,Double) -> Double
        let firstOperand: Double
        
        func perforn(with secondOperand:Double) -> Double {
            return function(firstOperand, secondOperand)

        }
    }
    
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        // ставим опциональный ? т.к. мы не можем поставить ! около accumulator ибо он очень часто будет not set, как в примере "5 *" - не установлен, а потом "5 * 3" и вот теперь только он не nill
        get{
            return accumulator
        }
    }
    
    
    mutating func returnToInitialState() {
        accumulator = nil
        //pendingBinaryOperation = nil
    }
    
    
}









//func changeSign(operand:Double) -> Double {
//    return -operand
//}
//func multiply
// делаем не class, а struct так как нам не нужно будет создавать подклассы  и для того, чтобы научится пользоваться struct.  Struct is value type, Class is reference type







// that is a mess)) we cant describe every case? so use swifts language good stuff
//        switch symbol {
//        case "pi":
//            //display.text = String(Double.pi)
//            accumulator = Double.pi
//        case "√":
//            //let operant = Double(display.text!)!
//            //display.text = String(sqrt(operant))
//            if let operand = accumulator {
//                accumulator = sqrt(operand)
//            }
//
//        default:
//            break
//        }
