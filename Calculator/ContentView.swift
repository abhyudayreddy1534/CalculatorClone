//
//  ContentView.swift
//  Calculator
//
//  Created by Sravanthi Chinthireddy on 20/05/24.
//

import SwiftUI

enum ButtonType: Hashable {
    case digit(Int)
    case operator_selected(Operator)
    case equal
    case clear
    case other(String)
    
    var foregroundColor: Color {
        switch self {
        case .digit( _):
            return .white
        case .operator_selected( _):
            return .white
        case .equal:
            return .white
        case .clear:
            return .black
        case .other( _):
            return .black
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .digit( _):
            return .black
        case .operator_selected( _):
            return .orange
        case .equal:
            return .orange
        case .clear:
            return .gray
        case .other( _):
            return .gray
        }
    }
    
    var title: String {
        switch self {
        case .digit(let int):
            return "\(int)"
        case .operator_selected(let op):
//            return op.title
            switch op {
            case .add:
                return "+"
            case .subtract:
                return "-"
            case .multiply:
                return "*"
            case .divide:
                return "/"
            case .percentage:
                return "%"
            }
//            switch op {
//            case .add, .subtract, .multiply, .divide, .percentage:
//                return
//            default:
//                <#code#>
//            }
        case .equal:
            return "="
        case .clear:
            return "AC"
        case .other(let string):
            return string
        }
    }
}

enum Operator {
    case add
    case subtract
    case multiply
    case divide
    case percentage
    
    var title: String {
        switch self {
        case .add:
            return "+"
        case .subtract:
            return "-"
        case .multiply:
            return "*"
        case .divide:
            return "/"
        case .percentage:
            return "%"
        }
    }
}

struct ContentView: View {
    @State var numEntered: String = ""
    var body: some View {
        VStack(spacing: 20, content: {
            Spacer()
            displayBox
            ButtonGrid(text: $numEntered)
        })
    }
    
    var displayBox: some View {
        Text(numEntered)
            .font(.system(size: 50, weight: .medium))
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(3)
        
    }
}

struct ButtonGrid: View {
    @Binding var text: String
    let items: [[ButtonType]] = [[.clear, .other("+/-"), .other("%"), .operator_selected(Operator.divide)],
                                 [.digit(7), .digit(8), .digit(9), .operator_selected(Operator.multiply)],
                                 [.digit(4), .digit(5), .digit(6), .operator_selected(Operator.subtract)],
                                 [.digit(1), .digit(2), .digit(3), .operator_selected(Operator.add)],
                                 [.digit(0), .other("."), .equal]]
    var body: some View {
        VStack(spacing: 10) {
            ForEach (items, id:\.self) { rowItems in
                HStack(spacing: 10) {
                    ForEach(rowItems, id: \.self) { buttonItem in
                        CalculatorButton(text: $text, title: buttonItem.title, type: buttonItem)
                    }
                }
            }
        }
        .padding()
    }
}

struct CalculatorButton: View {
    @Binding var text: String
    var prevValue: String = ""
    var currValue: String = ""
    var operation: String = ""
    let title: String
    let type: ButtonType
    
    var body: some View {
        Button(action: {
            switch type {
            case .digit(let int):
                self.text.append(title)
            case .operator_selected(let string):
                
                //self.prevValue = title
                self.text = title
            case .equal:
                self.text = title
            case .clear:
                self.text = "0"
            case .other(let string):
                self.text = title
            }
        },
               label: {
            Text(title)
//                .padding(.leading, 10)
        })
        .buttonStyle(
            CalculatorButtonStyle(
                backgroundColor: type.backgroundColor,
                foregroundColor: type.foregroundColor,
                isZeroButton: type == .digit(0)
            )
        )
    }
    
    func performOperation() {
//        if let operation = self.operation, let prev = Double(self.prevValue), let current = Double(self.title) {
//            
//        }
    }
    
}

struct CalculatorButtonStyle: ButtonStyle {
    let backgroundColor: Color
    let foregroundColor: Color
    var isZeroButton: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: isZeroButton ? 160 : 60, height: 60, alignment: isZeroButton ? .leading : .center)
            .font(.system(size: 40, weight: .medium))
            .padding()
            .background(backgroundColor)
            .foregroundStyle(foregroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 45.0))
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

#Preview {
    Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
    }
    .buttonStyle(
        CalculatorButtonStyle(
            backgroundColor: .black,
            foregroundColor: .white
        )
    )
}

#Preview {
    ContentView()
}
