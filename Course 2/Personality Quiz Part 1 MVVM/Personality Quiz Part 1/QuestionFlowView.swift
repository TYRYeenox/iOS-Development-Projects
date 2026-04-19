//
//  QuestionFlowView.swift
//  Personality Quiz Part 1
//
//  Created by TYR on 4/17/26.
//


import SwiftUI

struct QuestionFlowView: View {
    @State var viewModel: TitleViewModel
    let question: Question

    var body: some View {
        VStack {
            Text(question.text)

            switch question.type {
            case .single:
                SingleResponseSubview(viewModel: viewModel, question: question)
            case .multiple:
                MultipleResponseSubview(viewModel: viewModel, question: question)
            case .ranged:
                RangedResponseSubview(viewModel: viewModel, question: question)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(question.background)
        .ignoresSafeArea()
        .toolbar {
            if viewModel.hasNextQuestion(after: question) {
                NavigationLink(
                    "Next",
                    destination: QuestionFlowView(
                        viewModel: viewModel,
                        question: viewModel.nextQuestion(after: question)
                    )
                )
            } else {
                NavigationLink(
                    "Results",
                    destination: ResultsView(viewModel: viewModel)
                )
            }
        }
    }
}