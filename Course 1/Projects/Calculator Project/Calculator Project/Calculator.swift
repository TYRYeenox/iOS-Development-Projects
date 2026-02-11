//
//  Calculator.swift
//  Calculator Project
//
//  Created by Jane Madsen on 9/29/25.
//

import SwiftUI

@Observable
class Calculator {
    var displayedString = "0"  // Any time you update this String, it will display on the calculator.
    var stored: Double?
    var pending: CalculatorInput?
    var typing = true
    
    // Add additional variables here.
    
    func handleInput(_ input: CalculatorInput) {
        // Each case below represents a single button pressed on the calculator. Add a function for each; the default case covers the number buttons and has been set up for you, but feel free to change this as you see fit.
        
        print("stop here")
        
        switch input {
        case .backspace:
            backspace()
        case .clear:
            clear()
        case .percent:
            percent()
        case .divide:
            divide()
        case .multiply:
            multiply()
        case .subtract:
            subtract()
        case .add:
            add()
        case .invertSign:
            invertSign()
        case .decimal:
            decimal()
        case .equal:
            equal()
        default:
            number(Int(input.rawValue)!)
        }
    }
    
    func number(_ digit: Int) {
        guard (0...9).contains(digit)
        else {
            return
        }

        if displayedString == "Error" {
            displayedString = "\(digit)"
            typing = true
            return
        }

        if !typing {
            displayedString = "\(digit)"
            typing = true
            return
        }

        if displayedString == "0" {
            displayedString = "\(digit)"
            return
        }

        displayedString += "\(digit)"
    }
    
    func backspace() {
        var back = displayedString
        if back == "0" {
            return
        }
        back.removeLast()
        if back.isEmpty || back == "-" || back == "-0" {
            back = "0"
        }
        displayedString = back
    }
    
    func clear() {
        displayedString = "0"
        stored = nil
        pending = nil
        typing = false
    }
    
    func percent() {
        if let value = Double(displayedString) {
            let result = value / 100
            displayedString = String(result)
            typing = false
        }
    }
    
    func divide() {
        if let value = Double(displayedString) {
            stored = value
            pending = .divide
            typing = false
        }
    }
    
    func multiply() {
        if let value = Double(displayedString) {
            stored = value
            pending = .multiply
            typing = false
        }
    }
    
    func subtract() {
        if let value = Double(displayedString) {
            stored = value
            pending = .subtract
            typing = false
        }
    }
    
    func add() {
        if let value = Double(displayedString) {
            stored = value
            pending = .add
            typing = false
        }
    }
    func invertSign() {
        if let value = Double(displayedString) {
            let inverted = -value
            displayedString = String(inverted)
        }
    }
    
    func decimal() {
        if !typing {
            displayedString = "0."
            typing = true
            return
        }
        if displayedString.contains(".") {
            return
        }
        displayedString.append(".")
    }
    
    func equal() {
        guard let right = Double(displayedString)
            else {
                return
        }
        guard let left = stored, let operation = pending
            else {
                return
        }
        let result: Double
        
        switch operation {
        case .add:
            result = left + right
        case .subtract:
            result = left - right
        case .multiply:
            result = left * right
        case .divide:
            if right == 0 {
                displayedString = "Error"
                stored = nil
                pending = nil
                typing = false
                return
            }
            result = left / right
        default:
            return
        }
        displayedString = String(result)
        stored = result
        pending = nil
        typing = false
    }
}



#Preview {
    ContentView()
}
