//
//  ContentView.swift
//  Personality Quiz Part 1
//
//  Created by TYR on 3/10/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TitleView()
    }
}

#Preview {
    ContentView()
}

struct TitleView: View {
    @State private var quizManager = QuizManager()

    var body: some View {
        NavigationStack {
            VStack {
                Text("Which Video Game Console Are You?")
                    .font(.system(size: 25))
                Image("chatgptcontrollerglass")
                    .resizable()
                    .frame (width: 200, height: 200)
                NavigationLink(
                    "Wanna find out?",
                    destination: QuestionFlowView(
                        question: quizManager.questionList[0]
                    )
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemPink))
        }
        .ignoresSafeArea()
        .environment(quizManager)
    }
}

struct QuestionFlowView: View {
    let question: Question
    @Environment(QuizManager.self) var quizManager

    var body: some View {
        let currentIndex = quizManager.questionList.firstIndex { $0.text == question.text } ?? 0
        let nextIndex = currentIndex + 1

        VStack {
            Text(question.text)

            switch question.type {
            case .single:
                SingleResponseSubview(question: question)
            case .multiple:
                MultipleResponseSubview(question: question)
            case .ranged:
                RangedResponseSubview(question: question)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(question.background)
        .ignoresSafeArea()
        .toolbar {
            if nextIndex < quizManager.questionList.count {
                NavigationLink(
                    "Next",
                    destination: QuestionFlowView(
                        question: quizManager.questionList[nextIndex]
                    )
                )
            } else {
                NavigationLink(
                    "Results",
                    destination: ResultsView()
                )
            }
        }
    }
}

struct SingleResponseSubview: View {
    let question: Question
    @Environment(QuizManager.self) var quizManager

    @State private var answerOne = false
    @State private var answerTwo = false
    @State private var answerThree = false
    @State private var answerFour = false

    var body: some View {
        VStack {
            Toggle(question.answers[0].text, isOn: $answerOne)
            Toggle(question.answers[1].text, isOn: $answerTwo)
            Toggle(question.answers[2].text, isOn: $answerThree)
            Toggle(question.answers[3].text, isOn: $answerFour)
        }
        .onChange(of: answerOne) {
            var selections: [Answer] = []
            if answerOne { selections.append(question.answers[0]) }
            if answerTwo { selections.append(question.answers[1]) }
            if answerThree { selections.append(question.answers[2]) }
            if answerFour { selections.append(question.answers[3]) }
            quizManager.selectAnswers(selections)
        }
        .onChange(of: answerTwo) {
            var selections: [Answer] = []
            if answerOne { selections.append(question.answers[0]) }
            if answerTwo { selections.append(question.answers[1]) }
            if answerThree { selections.append(question.answers[2]) }
            if answerFour { selections.append(question.answers[3]) }
            quizManager.selectAnswers(selections)
        }
        .onChange(of: answerThree) {
            var selections: [Answer] = []
            if answerOne { selections.append(question.answers[0]) }
            if answerTwo { selections.append(question.answers[1]) }
            if answerThree { selections.append(question.answers[2]) }
            if answerFour { selections.append(question.answers[3]) }
            quizManager.selectAnswers(selections)
        }
        .onChange(of: answerFour) {
            var selections: [Answer] = []
            if answerOne { selections.append(question.answers[0]) }
            if answerTwo { selections.append(question.answers[1]) }
            if answerThree { selections.append(question.answers[2]) }
            if answerFour { selections.append(question.answers[3]) }
            quizManager.selectAnswers(selections)
        }
    }
}

struct MultipleResponseSubview: View {
    let question: Question
    @Environment(QuizManager.self) var quizManager

    @State private var selectedAnswer = 0

    var body: some View {
        VStack {
            Picker("Select an answer", selection: $selectedAnswer) {
                Text(question.answers[0].text).tag(0)
                Text(question.answers[1].text).tag(1)
                Text(question.answers[2].text).tag(2)
                Text(question.answers[3].text).tag(3)
            }
        }
        .onChange(of: selectedAnswer) {
            quizManager.selectAnswers([question.answers[selectedAnswer]])
        }
    }
}

struct RangedResponseSubview: View {
    let question: Question
    @Environment(QuizManager.self) var quizManager

    @State private var selectedValue = 0.0

    var body: some View {
        VStack {
            Slider(value: $selectedValue, in: 0...3, step: 1)

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
        .onChange(of: selectedValue) {
            quizManager.selectAnswers([question.answers[Int(selectedValue)]])
        }
    }
}

struct ResultsView: View {
    @Environment(QuizManager.self) var quizManager
    @State private var resultText: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Your Result")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(resultText)
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.purple.opacity(0.2))
        .ignoresSafeArea()
        .onAppear {
            resultText = quizManager.calculateResults()
        }
    }
}

struct Question {
    var text: String
    var type: ResponseType
    var background: Color
    var answers: [Answer]
}
enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: AnimalType
}
enum AnimalType {
    case Xbox, PS2, PS5, Atari
}

@Observable
class QuizManager {
    let questionList: [Question] = [
        Question(
            text: "Which drink do you like the most?",
            type: .single,
            background: .mint,
            answers: [
                Answer(text: "Monster", type: .Xbox),
                Answer(text: "Surge", type: .PS2),
                Answer(text: "Apple Juice", type: .PS5),
                Answer(text: "Coffee", type: .Atari)
            ]
        ),
        Question(
            text: "You wake your parents up at 3am gaming, what do you do?",
            type: .multiple,
            background: .green,
            answers: [
                Answer(text: "I am the adult/parent", type: .Atari),
                Answer(text: "Beg for 5 more min", type: .PS2),
                Answer(text: "Tell them to go back to bed", type: .PS5),
                Answer(text: "Argue and make a controller shaped hole in the wall", type: .Xbox)
            ]
        ),
        Question(
            text: "Whats the better achievment?",
            type: .ranged,
            background: .orange,
            answers: [
                Answer(text: "That platinum trophy.", type: .PS2),
                Answer(text: "A gold star in class.", type: .PS5),
                Answer(text: "Your 401k.", type: .Atari),
                Answer(text: "Not running out of minuits texting on your motorola razor.", type: .Xbox)
            ]
        )
    ]

    var selectedAnswers: [Answer] = []

    func selectAnswers(_ answers: [Answer]) {
        selectedAnswers.append(contentsOf: answers)
    }

    func calculateResults() -> String {
        var counts: [AnimalType: Int] = [:]
        for answer in selectedAnswers {
            counts[answer.type, default: 0] += 1
        }

        guard let resultType = counts.max(by: { $0.value < $1.value })?.key else {
            return "No result."
        }

        switch resultType {
        case .Xbox:
            return "You are an Xbox! The birthplace of modern console FPS!"
        case .PS2:
            return "You are a PS2! You are the best selling video game console of all time! You enjoy rich story!"
        case .PS5:
            return "You are a PS5! The latest tech and the youngest generation. You live for speed!"
        case .Atari:
            return "You are an Atari! Classics and simplicity are your speed!"
        }
    }
}

