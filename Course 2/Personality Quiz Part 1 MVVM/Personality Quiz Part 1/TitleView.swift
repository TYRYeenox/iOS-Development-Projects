//
//  TitleView.swift
//  Personality Quiz Part 1
//
//  Created by TYR on 4/17/26.
//


import SwiftUI

struct TitleView: View {
    @State private var viewModel = TitleViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                Text("Which Video Game Console Are You?")
                    .font(.system(size: 25))
                // Used chatgpt to generate a free use controller image
                Image("chatgptcontrollerglass")
                    .resizable()
                    .frame(width: 200, height: 200)
                NavigationLink(
                    "Wanna find out?",
                    destination: QuestionFlowView(
                        viewModel: viewModel,
                        question: viewModel.question(at: 0)
                    )
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemPink))
        }
        .ignoresSafeArea()
    }
}
