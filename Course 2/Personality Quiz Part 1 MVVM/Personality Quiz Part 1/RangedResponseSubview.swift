//
//  RangedResponseSubview.swift
//  Personality Quiz Part 1
//
//  Created by TYR on 4/17/26.
//


import SwiftUI

struct RangedResponseSubview: View {
    @State var viewModel: TitleViewModel
    let question: Question

    var body: some View {
        VStack {
            Slider(value: viewModel.bindingForRangedAnswer(question: question), in: 0...3, step: 1)

            HStack {
                Text(question.answers[0].text)
                Spacer()
                Text(question.answers[1].text)
                Spacer()
                Text(question.answers[2].text)
                Spacer()
                Text(question.answers[3].text)
            }
        }
        .onAppear {
            viewModel.updateRangedAnswer(for: question)
        }
    }
}