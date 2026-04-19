//
//  Question.swift
//  Personality Quiz Part 1
//
//  Created by TYR on 4/17/26.
//


import SwiftUI

struct Question {
    var text: String
    var type: ResponseType
    var background: Color
    var answers: [Answer]
}