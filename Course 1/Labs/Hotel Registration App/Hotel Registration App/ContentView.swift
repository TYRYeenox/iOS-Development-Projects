//
//  ContentView.swift
//  Hotel Registration App
//
//  Created by Jane Madsen on 9/26/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color("backgroundColor")

            HotelRegistrationScreen()
        }
    }
}

struct HotelRegistrationScreen: View {
    var body: some View {
        VStack {

            HStack {
                Image("mountainlandLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)

                Text("Hotel Mountainland")
                    .font(.custom("Rockwell", size: 30))
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.background)
            )

            TextField("First Name", text: $firstName)
                .textFieldStyle(.roundedBorder)

            TextField("Last Name", text: $lastName)
                .textFieldStyle(.roundedBorder)

            SecureField("Door Code", text: $doorCode)
                .textFieldStyle(.roundedBorder)

            Picker("Guests", selection: $numberOfGuests) {
                ForEach(1...10, id: \.self) { num in
                    Text("\(num)")
                }
            }

            Stepper("Length of Stay: \(lengthOfStay)", value: $lengthOfStay, in: 1...10)

            Toggle("Non-Smoking", isOn: $nonSmoking)

            MySpecialCustomStepper(count: $lengthOfStay)
            
            Button("Submit") {
                submitted.toggle()
            }

            if submitted == true {
                Text("Thank you for booking with us! How would you rate your experience?")

                Slider(
                    value: $feedback,
                    in: 1...5,
                    step: 1
                )

                Text("\(Int(feedback))/5 👻s")
            }

            Spacer()
        }
        .padding()
    }
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var doorCode = ""
    @State private var numberOfGuests = 1
    @State private var lengthOfStay = 1
    @State private var nonSmoking = false
    @State private var feedback = 5.0
    @State private var submitted = false
}

#Preview {
    ContentView()
}

struct MySpecialCustomStepper: View {
    @Binding var count: Int
    
    var body: some View {
        HStack {
            Text("\(count)")
            
            Button("-") {
                count -= 1
            }
            
            Button("+") {
                count += 1
            }
        }
    }
}
