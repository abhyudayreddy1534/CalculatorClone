//
//  CalculatorView.swift
//  Calculator
//
//  Created by Sravanthi Chinthireddy on 29/05/24.
//

import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case multiply = "*"
    case divide = "/"
    case percentage = "%"
    case plus_minus = "+/-"
    case decimal = "."
    case cancel = "AC"
    case equal = "="
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return .orange
        case .cancel, .plus_minus, .percentage:
            return Color(.lightGray)
        default:
            return Color(.darkGray)
        }
    }
}

enum Operation {
    case add
    case subtract
    case multiply
    case divide
    case none
}

struct CalculatorView: View {
    @State private var value = "0"
    @State private var prevNumber = 0.0
    @State private var currentOperation: Operation = .none
    @State private var isDecimal: Bool = false
    @State private var isAlreadyDecimal: Bool = false
    
    let buttons: [[CalcButton]] = [[.cancel, .plus_minus, .percentage, .divide],
                                   [.seven, .eight, .nine, .multiply],
                                   [.four, .five, .six, .subtract],
                                   [.one, .two, .three, .add],
                                   [.zero, .decimal, .equal]]
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Spacer()
//                Text for clicked value
                HStack {
                    Spacer()
                    Text(value)
                        .font(.system(size: 50))
                        .foregroundStyle(.white)
                }
                .padding()
//                Buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button {
                                self.didTap(item: item)
                            } label: {
                                Text(item.rawValue)
                                    .font(.system(size: 35))
                                    .frame(width: self.buttonWidth(item: item), height: buttonHeight())
                                    .background(item.buttonColor)
                                    .foregroundStyle(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: buttonHeight()/2))
                            }

                        }
                    }
                    .padding(.vertical, 5)
                }
            }
        }
    }
    
    func didTap(item: CalcButton) {
        switch item {
            
        case .add, .subtract, .multiply, .divide, .equal:
            if item == .add {
                self.currentOperation = .add
                self.prevNumber = Double(self.value) ?? 0
                print("++ \(self.prevNumber)")
            }
            else if item == .subtract {
                self.currentOperation = .subtract
                self.prevNumber = Double(self.value) ?? 0.0
                print("-- \(self.prevNumber)")
            }
            else if item == .multiply {
                self.currentOperation = .multiply
                self.prevNumber = Double(self.value) ?? 0.0
                print("** \(self.prevNumber)")
            }
            else if item == .divide {
                self.currentOperation = .divide
                self.prevNumber = Double(self.value) ?? 0.0
                print("// \(self.prevNumber)")
            }
            else if item == .equal {
//                self.currentOperation = .equal
                let prevValue = self.prevNumber
                let currentValue = Double(self.value) ?? 0.0
                switch self.currentOperation {
                case .add:
                    self.value = displayFinal(value: (currentValue + prevValue))//"\(currentValue + prevValue)"
                case .subtract:
                    self.value = displayFinal(value: (prevValue - currentValue))//"\(prevValue - currentValue)"
                case .multiply:
                    self.value = displayFinal(value: (prevValue * currentValue))//"\(prevValue * currentValue)"
                case .divide:
                    self.value = displayFinal(value: (prevValue / currentValue))//"\(prevValue / currentValue)"
                default:
                    break
                }
            }
            else {
                self.currentOperation = .none
            }
            
            if item != .equal {
                self.value = "0"
                self.isDecimal = false
                self.isAlreadyDecimal = false
            }
        case .cancel:
            self.value = "0"
            self.prevNumber = 0
            break
        case .decimal, .plus_minus, .percentage:
            if item == .decimal {
                self.isDecimal = true
                if self.isDecimal && !self.isAlreadyDecimal {
                    if self.value == "0" {
                        self.value = "0."
                    }
                    else {
                        self.value += "."
                    }
                    
                    self.isAlreadyDecimal = true
                }
                else if item.rawValue != "." {
                    self.value += item.rawValue
                }
                else {}
            }
            else if item == .plus_minus {
                
            }
            else {
                
            }
            break
        default:
            let number = item.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                value = "\(self.value)\(number)"
            }
        }
    }
    
    func performPrevOperation() {
        
    }
    
    func displayFinal(value: Double) -> String  {
        return isDecimal ? "\(value)" : "\(Int(value))"
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
//        var width: CGFloat = 0
//        switch item {
//        case .zero:
//            width = (UIScreen.main.bounds.width - (5*12)) / 2
//        default:
//            width = (UIScreen.main.bounds.width - (5*12)) / 4
//        }
//        return width
        
        if item == .zero {
            return (UIScreen.main.bounds.width - (4*12)) / 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight () -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

#Preview {
    CalculatorView()
}
