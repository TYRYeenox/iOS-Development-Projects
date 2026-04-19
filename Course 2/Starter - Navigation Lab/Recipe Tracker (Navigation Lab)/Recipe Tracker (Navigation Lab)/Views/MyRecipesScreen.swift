//
//  MyRecipesScreen.swift
//  Recipe Tracker (Navigation Lab)
//
//  Created by Jane Madsen on 10/8/25.
//

import SwiftUI
import Foundation

struct MyRecipesScreen: View {
    private let storageKey = "saved.recipes"
    @State private var recipes: [Recipe] = []
    @State private var showingAddRecipe = false
    
    var body: some View {
        NavigationStack {
            List(recipes) { recipe in
                NavigationLink(destination: RecipeDetailScreen(recipe: recipe)) {
                    Text(recipe.title)
                }
            }
            .onAppear(perform: loadRecipes)
            .toolbar {
                Button(action: {
                    showingAddRecipe = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddRecipe) {
            AddRecipeSheet(recipes: $recipes, onSave: {
                saveRecipes()
            })
        }
    }
    
    private func saveRecipes() {
        guard let data = try? JSONEncoder().encode(recipes) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }

    private func loadRecipes() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode([Recipe].self, from: data) {
            recipes = decoded
        } else {
            // Fallback to any bundled defaults if nothing saved yet
            recipes = Recipe.savedList
        }
    }
}

struct AddRecipeSheet: View {
    @Environment(\.dismiss) var dismiss
    @Binding var recipes: [Recipe]
    var onSave: () -> Void

    @State private var title = ""
    @State private var ingredients = ""
    @State private var instructions = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Recipe Info") {
                    TextField("Title", text: $title)
                    TextField("Ingredients", text: $ingredients, axis: .vertical)
                    TextField("Instructions", text: $instructions, axis: .vertical)
                }
            }
            .navigationTitle("New Recipe")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !trimmedTitle.isEmpty else { return }
                        let newRecipe = Recipe(
                            title: trimmedTitle,
                            ingredients: ingredients.trimmingCharacters(in: .whitespacesAndNewlines),
                            instructions: instructions.trimmingCharacters(in: .whitespacesAndNewlines)
                        )
                        recipes.append(newRecipe)
                        onSave()
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: dismiss.callAsFunction)
                }
            }
        }
    }
}

#Preview {
    MyRecipesScreen()
}
