//
//  MyModifier.swift
//  ViewModifierExamples
//
//  Created by Toby Youngberg on 9/15/25.
//

import SwiftUI

struct MyModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .padding(5)
            .bold()
            .italic()
            .frame(width:200, height:200)
            .background(.blue)
    }
}

extension View {
    func myModifier() -> some View {
        self.modifier(MyModifier())
    }
}
#Preview() {
    Text("This is my ViewModifier")
        .myModifier()
}

