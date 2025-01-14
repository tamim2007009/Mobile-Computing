import SwiftUI

struct BMI: View {
    @Environment(\.presentationMode) var presentationMode // For dismissing the current view
    @State private var weight: String = ""
    @State private var heightFeet: String = ""
    @State private var heightInches: String = ""
    @State private var bmi: String = ""
    @State private var bmiCategory: String = ""
    @State private var suggestion: String = ""
    @State private var selectedWeightUnit: String = "kg"
    @State private var selectedHeightUnit: String = "m"

    let weightUnits = ["kg", "lbs"]
    let heightUnits = ["m", "ft", "ft+in"]

    var body: some View {
        NavigationView {
            VStack {
                // Back button
             

                Text("BMI Calculator with Unit Converter")
                    .font(.largeTitle)
                    .padding()

                // Weight input field with unit picker
                HStack {
                    TextField("Enter weight", text: $weight)
                        .keyboardType(.decimalPad)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Picker("Weight Unit", selection: $selectedWeightUnit) {
                        ForEach(weightUnits, id: \.self) { unit in
                            Text(unit).tag(unit)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 100)
                }

                // Height input section
                if selectedHeightUnit == "ft+in" {
                    HStack {
                        TextField("Feet", text: $heightFeet)
                            .keyboardType(.decimalPad)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 80)
                        Text("'")
                        TextField("Inches", text: $heightInches)
                            .keyboardType(.decimalPad)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 80)
                    }
                    .padding()
                } else {
                    HStack {
                        TextField("Enter height", text: $heightFeet)
                            .keyboardType(.decimalPad)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Picker("Height Unit", selection: $selectedHeightUnit) {
                            ForEach(heightUnits, id: \.self) { unit in
                                Text(unit).tag(unit)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 100)
                    }
                    .padding()
                }

                Button(action: calculateBMI) {
                    Text("Calculate BMI")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                // BMI result display
                if !bmi.isEmpty {
                    Text("Your BMI: \(bmi)")
                        .font(.title2)
                        .padding()

                    Text("Category: \(bmiCategory)")
                        .font(.title3)
                        .padding()

                    // Display suggestion based on BMI category
                    Text(suggestion)
                        .font(.body)
                        .foregroundColor(.green)
                        .padding()
                }

                Spacer()
            }
            .padding()
            .navigationBarTitle("BMI Calculator", displayMode: .inline)
        }
    }

    
    func calculateBMI() {
        // Convert weight to kg if it's in lbs
        var weightInKg: Double = 0
        if selectedWeightUnit == "lbs", let weightValue = Double(weight) {
            weightInKg = weightValue * 0.453592  // Convert lbs to kg
        } else if selectedWeightUnit == "kg", let weightValue = Double(weight) {
            weightInKg = weightValue
        }
        
        // Convert height to meters based on the unit and input method
        var heightInMeters: Double = 0
        if selectedHeightUnit == "m", let heightValue = Double(heightFeet) {
            heightInMeters = heightValue
        } else if selectedHeightUnit == "ft", let heightValue = Double(heightFeet) {
            heightInMeters = heightValue * 0.3048  // Convert feet to meters
        } else if selectedHeightUnit == "ft+in", let feetValue = Double(heightFeet), let inchValue = Double(heightInches) {
            let totalHeightInInches = (feetValue * 12) + inchValue
            heightInMeters = totalHeightInInches * 0.0254  // Convert inches to meters
        }
        
        // Validate inputs
        guard heightInMeters > 0 else {
            bmi = "Invalid height input"
            bmiCategory = ""
            suggestion = ""
            return
        }
        
        guard weightInKg > 0 else {
            bmi = "Invalid weight input"
            bmiCategory = ""
            suggestion = ""
            return
        }
        
        // Calculate BMI
        let calculatedBMI = weightInKg / (heightInMeters * heightInMeters)
        bmi = String(format: "%.2f", calculatedBMI)
        bmiCategory = getBMICategory(bmi: calculatedBMI)
        suggestion = getSuggestion(bmiCategory: bmiCategory)
    }
    
    func getBMICategory(bmi: Double) -> String {
        switch bmi {
        case ..<18.5:
            return "Underweight"
        case 18.5..<24.9:
            return "Normal weight"
        case 25..<29.9:
            return "Overweight"
        default:
            return "Obesity"
        }
    }
    
    func getSuggestion(bmiCategory: String) -> String {
        switch bmiCategory {
        case "Underweight":
            return "Your BMI indicates that you are underweight. It's important to consult with a healthcare provider to evaluate your nutrition and overall health. Consider increasing your calorie intake with nutrient-dense foods."
        case "Normal weight":
            return "You have a normal BMI, which means you're at a healthy weight. Keep up the good work! Maintain a balanced diet and regular physical activity to stay healthy."
        case "Overweight":
            return "Your BMI indicates that you're overweight. Consider adopting a healthier eating plan and increasing your physical activity. It's important to consult with a healthcare provider to set realistic goals for your health."
        case "Obesity":
            return "Your BMI falls within the obesity range. It's important to consult a healthcare provider for a personalized plan to manage your weight. Consider making dietary changes and incorporating more physical activity into your daily routine."
        default:
            return ""
        }
    }
}

#Preview {
    BMI()
}




