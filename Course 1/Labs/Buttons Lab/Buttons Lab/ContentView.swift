//
//  ContentView.swift
//  Buttons Lab
//
//  Created by TYR on 3/3/26.
//

import SwiftUI

struct ImageButtonView: View {
    var action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Image("trollface")
                .resizable()
                .frame(width: 100, height: 100)
        }
    }
}

struct ButtonLook: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(configuration.isPressed ? .gray : .blue)
            .foregroundColor(.white)
    }
}

struct VisibleChange: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(configuration.isPressed ? Color.green : Color.red)
    }
}

struct ButtonsLab: View {
    @State private var number = 0
    @State private var text = ""
    @State private var toggle = false

    var body: some View {
        VStack {
            ImageButtonView {
                toggle.toggle()
            }

            Button("boop") {
                text = "boop"
            }
            .buttonStyle(ButtonLook())
            .disabled(toggle)
            
            Button("Toggle Boop") {
                toggle.toggle()
            }
            .buttonStyle(VisibleChange())

            Button("Boop_Pink") {
                toggle = true
            }
            .foregroundColor(.pink)

            Button("Boop_White") {
                toggle = false
            }
            .foregroundColor(.white)

            Button("Boop6") {
                text = "Boop"
            }
            .bold()

            Button("Boop7") {
                text = "Boop"
            }
            .italic()

            Button("Boop8") {
                text = "Boop"
            }
            .strikethrough()

            Button("Boop9") {
                text = "Boop"
            }
            .colorInvert()

            Button("Boop10") {
                text = "Boop"
            }
            .font(.custom("MarkerFelt-Wide", size: 20))
            

            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(toggle ? Color.pink : Color.white)
    }
}

struct ContentView: View {
    var body: some View {
        ButtonsLab()
    }
}

