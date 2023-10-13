//
//  ContentView.swift
//  UnitConvert
//
//  Created by Michael Nyland on 10/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var unitFrom = "kg"
    @State private var unitTo = "lb"
    @State private var inputWeight = 0.0
    
    var convertFromUnit = ["kg", "lb", "g", "t", "st"]
    var convertToUnit = ["kg", "lb", "g", "t", "st"]
    
    @FocusState private var amountIsFocused: Bool
    
    var conversionResult : Double {
        
        var inputToKGMultiplier: Double
        var kgToOutputMultiplier: Double
        
        switch unitFrom {
            case "lb":
                inputToKGMultiplier = 0.45359237
            case "g":
                inputToKGMultiplier = 0.001
            case "t":
                inputToKGMultiplier = 907.185
            case "st":
                inputToKGMultiplier = 6.35029
            default:
                inputToKGMultiplier = 1
        }
        
        switch unitTo {
            case "lb":
                kgToOutputMultiplier = 2.20462
            case "g":
                kgToOutputMultiplier  = 1000.0
            case "t":
                kgToOutputMultiplier = 0.001102
            case "st":
                kgToOutputMultiplier = 0.157473
            default:
                kgToOutputMultiplier = 1
        }
        
        var inputToKG = inputWeight * inputToKGMultiplier
        var outputWeight = inputToKG * kgToOutputMultiplier
        var roundedOutput = round(outputWeight)
        
        if (unitFrom == unitTo) {
            return roundedOutput
        } else {
            return outputWeight
        }
        
    }
    
    var body: some View {
        NavigationStack {
            Form {
                
                // Text field to enter a number
                Section ("Convert") {
                    TextField("Amount", value: $inputWeight, format: .number)
                    .focused($amountIsFocused)
                    .keyboardType(.decimalPad)
                    
                    Picker("Selected Unit", selection: $unitFrom) {
                        ForEach(convertFromUnit, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                
                // Segmented control for - kilograms, pounds, grams, tonnes, stones
                Section ("To") {
                    Picker("Selected Unit", selection: $unitTo) {
                        ForEach(convertToUnit, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                
                // Text showing the output
                Section {
                    Text(conversionResult, format: .number)
                }
            }
            .navigationTitle("SBWC Converter")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
    }
}
