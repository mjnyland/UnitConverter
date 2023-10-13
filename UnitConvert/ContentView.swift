//
//  ContentView.swift
//  UnitConvert
//
//  Created by Michael Nyland on 10/12/23.
//

import SwiftUI

struct ContentView: View {
    
    var convertFromUnit = ["kg", "lb", "g", "t", "st"]
    var convertToUnit = ["kg", "lb", "g", "t", "st"]
    
    @State private var unitFrom = "kg"
    @State private var unitTo = "lb"
    @State private var inputWeight = 0.0
    
    @FocusState private var amountIsFocused: Bool
    
    var conversionResult : Double {
        
        var base = inputWeight
        var result = 0.0
        
        switch unitFrom {
            case "kg":
                base = inputWeight
            case "lb":
                base = inputWeight / 2.20462
            case "g":
                base = inputWeight / 1000.0
            case "t":
                base = inputWeight * 907.185
            case "st":
                base = inputWeight * 142.9
            default:
                base = inputWeight
        }
        
        switch unitTo {
            case "kg":
                result = base
            case "lb":
                result = base * 2.20462
            case "g":
                result = base * 1000.0
            case "t":
                result = inputWeight / 907.185
            case "st":
                result = inputWeight / 142.9
            default:
                result = inputWeight
        }
        
        return result
        
    }
    
    var body: some View {
        NavigationStack {
            Form {
                
                // Text field to enter a number
                Section ("Convert") {
                    TextField("Amount", value: $inputWeight, format: .number)
                    .focused($amountIsFocused)
                    
                    Picker("Selected Unit", selection: $unitFrom) {
                        ForEach(convertFromUnit, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .keyboardType(.decimalPad)
                
                
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
