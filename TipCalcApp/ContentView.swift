//
//  ContentView.swift
//  TipCalcApp
//
//  Created by Tejaswi Bokkisam on 3/29/26.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    // MARK: - State
    @State private var selectedTab = 0
    
    @State private var billAmount: String = ""
    @State private var tipPercentage: Double = 15
    @State private var targetTotal: String = ""
    
    // MARK: - Formatter
    let formatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.maximumFractionDigits = 2
        return f
    }()
    
    // MARK: - Calculations
    var bill: Double {
        Double(billAmount) ?? 0
    }
    
    var tipAmount: Double {
        bill * tipPercentage / 100
    }
    
    var totalAmount: Double {
        bill + tipAmount
    }
    
    var targetBill: Double {
        Double(targetTotal) ?? 0
    }
    
    var calculatedTipFromTarget: Double {
        max(targetBill - bill, 0)
    }
    
    var calculatedTipPercentFromTarget: Double {
        guard bill > 0 else { return 0 }
        return (calculatedTipFromTarget / bill) * 100
    }
    
    // MARK: - Haptics
    func haptic() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    // MARK: - UI
    var body: some View {
        VStack(spacing: 25) {
            
            Text("Tip Calculator")
                .font(.largeTitle.bold())
            
            // Segmented Tabs
            Picker("", selection: $selectedTab) {
                Text("Tip %").tag(0)
                Text("Target Total").tag(1)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .animation(.easeInOut, value: selectedTab)
            
            ZStack {
                if selectedTab == 0 {
                    tipView
                        .transition(.opacity.combined(with: .move(edge: .leading)))
                } else {
                    targetView
                        .transition(.opacity.combined(with: .move(edge: .trailing)))
                }
            }
            .animation(.easeInOut, value: selectedTab)
            
            Spacer()
        }
        .padding(.top)
        .padding(.bottom)
    }
    
    // MARK: - Shared Apple Pay Style Big Total
    func bigTotalView(amount: Double) -> some View {
        VStack(spacing: 8) {
            Text("Total")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(formatter.string(from: NSNumber(value: amount)) ?? "$0.00")
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .animation(.spring(response: 0.3), value: amount)
    }
    
    // MARK: - Tip % View
    var tipView: some View {
        VStack(spacing: 25) {
            
            HStack(spacing: 4) {
                Text("$").foregroundColor(.gray)
                TextField("Enter Amount Pre-Tax", text: $billAmount)
                    .keyboardType(.decimalPad)
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            .padding(.horizontal)
            
            VStack {
                Text("Tip: \(Int(tipPercentage))%")
                    .font(.headline)
                
                Slider(value: $tipPercentage, in: 0...30, step: 1)
                    .padding(.horizontal)
                    .onChange(of: tipPercentage) { _ in
                        haptic()
                        // Sync target total
                        targetTotal = String(format: "%.2f", totalAmount)
                    }
            }
            
            VStack(spacing: 12) {
                row(title: "Tip", value: tipAmount)
            }
            .padding(.horizontal)
            
            bigTotalView(amount: totalAmount)
        }
    }
    
    // MARK: - Target Total View
    var targetView: some View {
        VStack(spacing: 25) {
            
            // Bill Input
            HStack(spacing: 4) {
                Text("$").foregroundColor(.gray)
                TextField("Enter Amount Pre-Tax", text: $billAmount)
                    .keyboardType(.decimalPad)
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            .padding(.horizontal)
            
            // Target Total Input
            HStack(spacing: 4) {
                Text("$").foregroundColor(.gray)
                TextField("Enter Target Total Amount", text: $targetTotal)
                    .keyboardType(.decimalPad)
                    .onChange(of: targetTotal) { _ in
                        tipPercentage = calculatedTipPercentFromTarget
                    }
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            .padding(.horizontal)
            
            VStack(spacing: 12) {
                row(title: "Tip Amount", value: calculatedTipFromTarget)
                
                let tipPercentString = String(format: "%.1f%%", calculatedTipPercentFromTarget)
                row(title: "Tip %", valueText: tipPercentString)
            }
            .padding(.horizontal)
            
            bigTotalView(amount: targetBill)
        }
    }
    
    // MARK: - Row UI
    func row(title: String, value: Double? = nil, valueText: String? = nil, bold: Bool = false) -> some View {
        HStack {
            Text(title)
                .fontWeight(bold ? .bold : .regular)
            
            Spacer()
            
            if let valueText = valueText {
                Text(valueText)
                    .fontWeight(bold ? .bold : .regular)
            } else if let value = value {
                Text(formatter.string(from: NSNumber(value: value)) ?? "$0.00")
                    .fontWeight(bold ? .bold : .regular)
            }
        }
    }
}

#Preview {
    ContentView()
}
