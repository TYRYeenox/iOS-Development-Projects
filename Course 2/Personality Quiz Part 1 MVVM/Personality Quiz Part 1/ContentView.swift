//
//  ContentView.swift
//  Personality Quiz Part 1
//
//  Created by TYR on 3/10/26.
//

import SwiftUI

#Preview {
    ContentView()
}

enum ResponseType {
    case single, multiple, ranged
}

enum AnimalType: Hashable {
    case Xbox, PS2, PS5, Atari
}

@Observable
class TitleViewModel {
    var questionList: [Question] = [
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
    var resultText: String = ""
    var answerOne = false
    var answerTwo = false
    var answerThree = false
    var answerFour = false
    var selectedAnswer = 0
    var selectedValue = 0.0

    func question(at index: Int) -> Question {
        questionList[index]
    }

    func questionIndex(for question: Question) -> Int {
        questionList.firstIndex { $0.text == question.text } ?? 0
    }

    func hasNextQuestion(after question: Question) -> Bool {
        questionIndex(for: question) + 1 < questionList.count
    }

    func nextQuestion(after question: Question) -> Question {
        questionList[questionIndex(for: question) + 1]
    }

    func setSingleAnswer(_ isOn: Bool, for question: Question, index: Int) {
        switch index {
        case 0:
            answerOne = isOn
        case 1:
            answerTwo = isOn
        case 2:
            answerThree = isOn
        case 3:
            answerFour = isOn
        default:
            break
        }
        updateSingleSelections(for: question)
    }

    func bindingForSingleAnswer(question: Question, index: Int) -> Binding<Bool> {
        Binding(
            get: {
                switch index {
                case 0:
                    return self.answerOne
                case 1:
                    return self.answerTwo
                case 2:
                    return self.answerThree
                case 3:
                    return self.answerFour
                default:
                    return false
                }
            },
            set: { newValue in
                self.setSingleAnswer(newValue, for: question, index: index)
            }
        )
    }

    func updateSingleSelections(for question: Question) {
        removeSelections(for: question)
        var selections: [Answer] = []
        if answerOne { selections.append(question.answers[0]) }
        if answerTwo { selections.append(question.answers[1]) }
        if answerThree { selections.append(question.answers[2]) }
        if answerFour { selections.append(question.answers[3]) }
        selectAnswers(selections)
    }

    func setSelectedAnswer(_ value: Int, for question: Question) {
        selectedAnswer = value
        updateMultipleAnswer(for: question)
    }

    func bindingForMultipleAnswer() -> Binding<Int> {
        Binding(
            get: { self.selectedAnswer },
            set: { newValue in
                self.selectedAnswer = newValue
            }
        )
    }

    func updateMultipleAnswer(for question: Question) {
        removeSelections(for: question)
        selectAnswers([question.answers[selectedAnswer]])
    }

    func setSelectedValue(_ value: Double, for question: Question) {
        selectedValue = value
        updateRangedAnswer(for: question)
    }

    func bindingForRangedAnswer(question: Question) -> Binding<Double> {
        Binding(
            get: { self.selectedValue },
            set: { newValue in
                self.setSelectedValue(newValue, for: question)
            }
        )
    }

    func updateRangedAnswer(for question: Question) {
        removeSelections(for: question)
        selectAnswers([question.answers[Int(selectedValue)]])
    }

    func selectAnswers(_ answers: [Answer]) {
        selectedAnswers.append(contentsOf: answers)
    }

    func removeSelections(for question: Question) {
        selectedAnswers.removeAll { answer in
            question.answers.contains { $0.text == answer.text && $0.type == answer.type }
        }
    }

    func updateResultText() {
        resultText = calculateResults()
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

