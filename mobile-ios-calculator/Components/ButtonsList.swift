//
//  CalcButton.swift
//  mobile-ios-calculator
//
//  Created by Vadim on 7/17/26.
//

import SwiftUI

// 1. Создаем структуру для описания каждой кнопки
struct CalcButton: Identifiable {
    let id = UUID()
    let title: String
    let backgroundColor: Color
    let foregroundColor: Color
}

struct ButtonsList: View {
    @State private var displayText: String = "0"
        
    // Новые переменные для хранения состояния калькулятора
    @State private var storedValue: Double? = nil      // Первое число
    @State private var currentOperation: String? = nil // Знак операции (+, −, ×, ÷)
    @State private var isTypingNumber = false          // Сбрасывать ли экран при вводе новой цифры
    
    // 2. Описываем колонки сетки. Нам нужно 4 колонки одинаковой (flexible) ширины
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // 3. Массив со всеми кнопками калькулятора по порядку
    private let buttons: [CalcButton] = [
        CalcButton(title: "C", backgroundColor: Color(.lightGray), foregroundColor: .black),
        CalcButton(title: "±", backgroundColor: Color(.lightGray), foregroundColor: .black),
        CalcButton(title: "%", backgroundColor: Color(.lightGray), foregroundColor: .black),
        CalcButton(title: "÷", backgroundColor: .purple, foregroundColor: .white),
        
        CalcButton(title: "7", backgroundColor: Color(.darkGray), foregroundColor: .white),
        CalcButton(title: "8", backgroundColor: Color(.darkGray), foregroundColor: .white),
        CalcButton(title: "9", backgroundColor: Color(.darkGray), foregroundColor: .white),
        CalcButton(title: "×", backgroundColor: .purple, foregroundColor: .white),
        
        CalcButton(title: "4", backgroundColor: Color(.darkGray), foregroundColor: .white),
        CalcButton(title: "5", backgroundColor: Color(.darkGray), foregroundColor: .white),
        CalcButton(title: "6", backgroundColor: Color(.darkGray), foregroundColor: .white),
        CalcButton(title: "−", backgroundColor: .purple, foregroundColor: .white),
        
        CalcButton(title: "1", backgroundColor: Color(.darkGray), foregroundColor: .white),
        CalcButton(title: "2", backgroundColor: Color(.darkGray), foregroundColor: .white),
        CalcButton(title: "3", backgroundColor: Color(.darkGray), foregroundColor: .white),
        CalcButton(title: "+", backgroundColor: .purple, foregroundColor: .white),
        
        CalcButton(title: "0", backgroundColor: Color(.darkGray), foregroundColor: .white),
        CalcButton(title: ",", backgroundColor: Color(.darkGray), foregroundColor: .white),
        CalcButton(title: "=", backgroundColor: .purple, foregroundColor: .white)
    ]
    
    var body: some View {
        VStack(spacing: 12) {
            
            // Экран вывода цифр
            HStack {
                Spacer()
                Text(displayText)
                    .font(.system(size: 64, weight: .light))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .padding(.horizontal, 24)
            }
            
            // Сетка с кнопками
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(buttons) { button in
                    Button(action: {
                        // Логика при нажатии на кнопку
                        handleTap(button: button)
                    }) {
                        Text(button.title)
                            .font(.title)
                            .bold()
                            .foregroundColor(button.foregroundColor)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fit) // Делает кнопку идеально квадратной
                            .background(button.backgroundColor)
                            .clipShape(Circle()) // Обрезает до круга
                    }
                }
            }
            .padding(.horizontal, 12)
        }
    }
    
    // Простая функция для демонстрации ввода
    private func handleTap(button: CalcButton) {
            switch button.title {
            
            case "C":
                // Полный сброс
                displayText = "0"
                storedValue = nil
                currentOperation = nil
                isTypingNumber = false
                
            case "+", "−", "×", "÷":
                // Заменяем запятую на точку для расчетов Swift
                let cleanText = displayText.replacingOccurrences(of: ",", with: ".")
                // Сохраняем текущее число
                storedValue = Double(cleanText)
                // Запоминаем операцию
                currentOperation = button.title
                // Говорим, что следующее нажатие цифры должно заменить текст на экране
                isTypingNumber = false
                
            case "=":
                // Выполняем расчет, если есть первое число и операция
                guard let firstValue = storedValue, let operation = currentOperation else { return }
                
                let cleanText = displayText.replacingOccurrences(of: ",", with: ".")
                guard let secondValue = Double(cleanText) else { return }
                
                var result: Double = 0
                
                // Проверяем, какая именно операция была выбрана
                switch operation {
                case "+": result = firstValue + secondValue
                case "−": result = firstValue - secondValue
                case "×": result = firstValue * secondValue
                case "÷": result = firstValue / secondValue // Тут в будущем можно добавить проверку на ноль
                default: return
                }
                
                // Форматируем результат, чтобы убрать ".0" у целых чисел
                displayText = formatResult(result)
                
                // Сбрасываем операцию
                storedValue = nil
                currentOperation = nil
                isTypingNumber = false
                
            case ",":
                // Не даем поставить две запятые в одно число
                if !displayText.contains(",") {
                    displayText += ","
                }
                
            default:
                // Сюда попадают обычные цифры от 0 до 9
                if displayText == "0" || !isTypingNumber {
                    // Если был ноль или мы только что нажали на знак операции — заменяем текст
                    displayText = button.title
                    isTypingNumber = true
                } else {
                    // Иначе просто приписываем цифру в конец
                    displayText += button.title
                }
            }
        }
    
        
        // Вспомогательная функция, чтобы "5.0" превращалось в "5", а "5.5" оставалось "5.5"
        private func formatResult(_ value: Double) -> String {
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 8 // Округлим до 8 знаков после запятой max
            formatter.decimalSeparator = ","     // Возвращаем красивую запятую для UI
            return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
        }
}
