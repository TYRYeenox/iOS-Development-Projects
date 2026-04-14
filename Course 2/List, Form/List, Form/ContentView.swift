//
//  ContentView.swift
//  List, Form
//
//  Created by TYR on 3/13/26.
//

//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Text("CLICK IT")
//                NavigationLink("Go to Second") {
//                    SecondView()
//                }
//            }
//            .toolbar {
//                ToolbarItem(placement: .principal) {
//                    Text("🎮 My Top Video Games 🕹️")
//                        .font(.system(size: 30))
//                        .bold()
//                        .lineLimit(2)
//                        .multilineTextAlignment(.center)
//                }
//            }
//        }
//    }
//}
//
//struct SecondView: View {
//    var body: some View {
//        Text("Second View")
//            .toolbar {
//                ToolbarItem(placement: .principal) {
//                    Text("My Three Dogs")
//                        .font(.system(size: 30))
//                        .bold()
//                        .lineLimit(2)
//                        .multilineTextAlignment(.center)
//                }
//            }
//    }
//}
//
//#Preview {
//    ContentView()
//}

import SwiftUI

struct Game: Identifiable {
    let id = UUID()
    var game: String
    var genre: String
    var year: String
}

struct ContentView: View {
    @State private var games = [
        Game(game: "Grand Theft Auto", genre: "Adventure", year: "2013"),
        Game(game: "Rust", genre: "Survival", year: "2018"),
        Game(game: "Halo", genre: "Shooter", year: "2001")
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($games) { $game in
                    NavigationLink {
                        GameDetailView(game: $game)
                    } label: {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(game.game)
                                .font(.headline)
                            
                            Text("Genre: \(game.genre)")
                            
                            Text("Year: \(game.year)")
                        }
                    }
                }
            }
            .navigationTitle("...🎮 My Top Games 🕹️...")
        }
    }
}

struct GameDetailView: View {
    @Binding var game: Game
    
    var body: some View {
        Form {
            Section("Game Info") {
                TextField("Game", text: $game.game)
                TextField("Genre", text: $game.genre)
                TextField("Year", text: $game.year)
            }
        }
        .navigationTitle("Edit Yours!")
    }
}

#Preview {
    ContentView()
}
