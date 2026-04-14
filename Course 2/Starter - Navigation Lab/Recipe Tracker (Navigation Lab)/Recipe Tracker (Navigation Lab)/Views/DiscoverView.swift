import SwiftUI

struct DiscoverView: View {
    @State private var recipes = Recipe.savedList

    var body: some View {
        NavigationStack {
            List(recipes) { recipe in
                NavigationLink(destination: RecipeDetailScreen(recipe: recipe)) {
                    Text(recipe.title)
                }
            }
            .navigationTitle("Discover")
        }
    }
}

#Preview {
    DiscoverView()
}
