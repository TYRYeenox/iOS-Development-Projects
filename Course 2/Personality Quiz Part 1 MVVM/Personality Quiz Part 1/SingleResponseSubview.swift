//
//  SingleResponseSubview.swift
//  Personality Quiz Part 1
//
//  Created by TYR on 4/17/26.
//


import SwiftUI

struct SingleResponseSubview: View {
    @State var viewModel: TitleViewModel
    let question: Question

    var body: some View {
        VStack {
            Toggle(question.answers[0].text, isOn: viewModel.bindingForSingleAnswer(question: question, index: 0))
            Toggle(question.answers[1].text, isOn: viewModel.bindingForSingleAnswer(question: question, index: 1))
            Toggle(question.answers[2].text, isOn: viewModel.bindingForSingleAnswer(question: question, index: 2))
            Toggle(question.answers[3].text, isOn: viewModel.bindingForSingleAnswer(question: question, index: 3))
        }
    }
}