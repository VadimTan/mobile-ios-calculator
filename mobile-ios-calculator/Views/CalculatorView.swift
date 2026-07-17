//
//  CalculatorView.swift
//  mobile-ios-calculator
//
//  Created by Vadim on 7/17/26.
//

import SwiftUI

struct CalculatorView: View {
    var body: some View {
        VStack {
            VStack {
                Text("Calculator App")
            }
            .font(.largeTitle)
            .foregroundStyle(Color.white)
            .padding()
            
            Spacer()
            
            ButtonsList()
        }
        .background(Color.black.opacity(0.75))
    }
}
