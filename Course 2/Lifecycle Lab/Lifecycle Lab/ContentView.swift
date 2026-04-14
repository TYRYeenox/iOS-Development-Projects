//
//  ContentView.swift
//  Lifecycle Lab
//
//  Created by TYR on 3/11/26.
//

import SwiftUI

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @State var events: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(events)

                NavigationLink("Tap here for a suprise") {
                    SecondView(events: $events)
                }
            }
            .onAppear {
                events += "\n✅You're Here✅"
            }
            .onDisappear {
                events += "\n❌You're There❌"
            }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .inactive {
                    events += "\nApp Inactive"
                } else if newPhase == .active {
                    events += "\nApp Active"
                } else if newPhase == .background {
                    events += "\nApp Backgrounded"
                }
            }
        }
    }
}

struct SecondView: View {
    @Binding var events: String

    var body: some View {
        VStack {
            Text("Second View")
            Text("Navigate back to test lifecycle events")
        }
        .onAppear {
            events += "\nSecondView Appeared"
        }
        .onDisappear {
            events += "\nSecondView Disappeared"
        }
    }
}

#Preview {
    ContentView()
}
