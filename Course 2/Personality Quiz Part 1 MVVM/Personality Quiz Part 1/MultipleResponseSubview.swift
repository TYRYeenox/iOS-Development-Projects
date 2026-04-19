//
//  MultipleResponseSubview.swift
//  Personality Quiz Part 1
//
//  Created by TYR on 4/17/26.
//


import SwiftUI

struct MultipleResponseSubview: View {
    @State var viewModel: TitleViewModel
    let question: Question

    var body: some View {
        VStack {
            Picker("Select an answer", selection: viewModel.bindingForMultipleAnswer()) {
                Text(question.answers[0].text).tag(0)
                Text(question.answers[1].text).tag(1)
                Text(question.answers[2].text).tag(2)
                Text(question.answers[3].text).tag(3)
            }
        }
        .onAppear {
            viewModel.updateMultipleAnswer(for: question)
        }
    }
}