//
//  ResultsView.swift
//  Personality Quiz Part 1
//
//  Created by TYR on 4/17/26.
//


import SwiftUI

struct ResultsView: View {
    @State var viewModel: TitleViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Your Result")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(viewModel.resultText)
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.purple.opacity(0.2))
        .ignoresSafeArea()
        .onAppear {
            viewModel.updateResultText()
        }
    }
}