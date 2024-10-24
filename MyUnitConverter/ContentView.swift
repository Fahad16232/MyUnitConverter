
//  ContentView.swift
//  MyUnitConverter
//
//  Created by Dev Reptech on 07/03/2024.


import SwiftUI

enum ConversionType: String, CaseIterable {
    case length = "Length"
    case weight = "Weight"
    case volume = "Volume"
    case temperature = "Temperature"
}

struct ContentView: View {
    @State private var selectedConversionType = ConversionType.length
    @State private var selectedSubConversionType = ""
    @State private var inputValue = ""
    @State private var outputUnit = ""
    @State private var outputValue = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select Conversion Type")) {
                    Picker("Conversion Type", selection: $selectedConversionType) {
                        ForEach(ConversionType.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Select Sub-Conversion Type")) {
                    Picker("Sub-Conversion Type", selection: $selectedSubConversionType) {
                        ForEach(units(for: selectedConversionType), id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Input")) {
                    TextField("Enter Value", text: $inputValue)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("Output")) {
                    Text("Converted Value: \(outputValue)")

                    Picker("Unit", selection: $outputUnit) {
                        ForEach(units(for: selectedConversionType), id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Button("Convert", action: convert)
            }
            .navigationTitle("Unit Converter")
        }
    }

    func units(for type: ConversionType) -> [String] {
        switch type {
        case .length:
            return ["meters", "kilometers", "feet", "yards", "miles"]
        case .weight:
            return ["grams", "kilograms", "ounces", "pounds"]
        case .volume:
            return ["milliliters", "liters", "fluid ounces", "cups", "pints", "gallons"]
        case .temperature:
            return ["Celsius", "Fahrenheit", "Kelvin"]
        }
    }

    func convert() {
        guard let inputValue = Double(inputValue) else {
            outputValue = "Invalid input"
            return
        }

        switch selectedConversionType {
        case .length:
            outputValue = convertLength(inputValue: inputValue, inputUnit: selectedSubConversionType, outputUnit: outputUnit)
        case .weight:
            outputValue = convertWeight(inputValue: inputValue, inputUnit: selectedSubConversionType, outputUnit: outputUnit)
        case .volume:
            outputValue = convertVolume(inputValue: inputValue, inputUnit: selectedSubConversionType, outputUnit: outputUnit)
        case .temperature:
            outputValue = convertTemperature(inputValue: inputValue, inputUnit: selectedSubConversionType, outputUnit: outputUnit)
        }
    }

    func convertLength(inputValue: Double, inputUnit: String, outputUnit: String) -> String {
        let lengthUnits: [String: Double] = [
            "meters": 1.0,
            "kilometers": 0.001,
            "feet": 3.28084,
            "yards": 1.09361,
            "miles": 0.000621371
        ]

        guard let inputMultiplier = lengthUnits[inputUnit],
              let outputMultiplier = lengthUnits[outputUnit] else {
            return "Invalid units"
        }

        let convertedValue = inputValue * inputMultiplier / outputMultiplier
        return String(format: "%.2f", convertedValue)
    }

    func convertWeight(inputValue: Double, inputUnit: String, outputUnit: String) -> String {
        let weightUnits: [String: Double] = [
            "grams": 1.0,
            "kilograms": 0.001,
            "ounces": 0.035274,
            "pounds": 0.00220462
        ]

        guard let inputMultiplier = weightUnits[inputUnit],
              let outputMultiplier = weightUnits[outputUnit] else {
            return "Invalid units"
        }

        let convertedValue = inputValue * inputMultiplier / outputMultiplier
        return String(format: "%.2f", convertedValue)
    }

    func convertVolume(inputValue: Double, inputUnit: String, outputUnit: String) -> String {
        let volumeUnits: [String: Double] = [
            "milliliters": 1.0,
            "liters": 0.001,
            "fluid ounces": 0.033814,
            "cups": 0.00422675,
            "pints": 0.00211338,
            "gallons": 0.000264172
        ]

        guard let inputMultiplier = volumeUnits[inputUnit],
              let outputMultiplier = volumeUnits[outputUnit] else {
            return "Invalid units"
        }

        let convertedValue = inputValue * inputMultiplier / outputMultiplier
        return String(format: "%.2f", convertedValue)
    }

    func convertTemperature(inputValue: Double, inputUnit: String, outputUnit: String) -> String {
        switch (inputUnit, outputUnit) {
        case ("Celsius", "Fahrenheit"):
            let fahrenheitValue = (inputValue * 9 / 5) + 32
            return String(format: "%.2f", fahrenheitValue)
        case ("Fahrenheit", "Celsius"):
            let celsiusValue = (inputValue - 32) * 5 / 9
            return String(format: "%.2f", celsiusValue)
        case ("Celsius", "Kelvin"):
            let kelvinValue = inputValue + 273.15
            return String(format: "%.2f", kelvinValue)
        case ("Kelvin", "Celsius"):
            let celsiusValue = inputValue - 273.15
            return String(format: "%.2f", celsiusValue)
        case ("Fahrenheit", "Kelvin"):
            let kelvinValue = (inputValue - 32) * 5 / 9 + 273.15
            return String(format: "%.2f", kelvinValue)
        case ("Kelvin", "Fahrenheit"):
            let fahrenheitValue = (inputValue - 273.15) * 9 / 5 + 32
            return String(format: "%.2f", fahrenheitValue)
        default:
            return "Invalid units"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
