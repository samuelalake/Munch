//
//  ContentView.swift
//  Munch-RKCK
//
//  Created by Samuel Alake on 4/2/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RecipesViewControllerRepresentable()
                .tabItem {
                    Label("Recipes", systemImage: "list.bullet.rectangle.portrait")
                }
            
            MealPlanViewControllerRepresentable()
                .tabItem {
                    Label("Meal Plan", systemImage: "calendar")
                }
            
            GroceryViewControllerRepresentable()
                .tabItem{
                    Label("Grocery", systemImage: "leaf")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
