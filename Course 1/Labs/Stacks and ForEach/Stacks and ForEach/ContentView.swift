//
//  ContentView.swift
//  Stacks and ForEach
//
//  Created by TYR on 3/4/26.
//

import SwiftUI

struct LayoutView: View {
    let items = ["🍣", "🍣", "🍣", "🍣", "🍣", "🍣"]

    var body: some View {
        VStack(spacing: 20) {

            ZStack {
                Color.blue
                    .frame(height: 200)

                VStack(spacing: 15) {
                    Text("🍥")
                        .font(.title)

                    HStack(spacing: 20) {
                        ForEach(items, id: \.self) { item in
                            Button {
                            } label: {
                                Text(item)
                                    .font(.headline)
                            }
                        }
                    }
                }
            }

            ZStack {
                Color.pink
                    .frame(height: 200)

                VStack(spacing: 15) {
                    Text("🍤")
                        .font(.title)

                    HStack(spacing: 20) {
                        Text("🍙")
                        Text("🍙")
                        Text("🍙")
                        Text("🍙")
                        Text("🍙")
                        Text("🍙")
                    }
                    .font(.headline)
                }
            }

        }
        .padding()
    }
}

#Preview {
    LayoutView()
}
