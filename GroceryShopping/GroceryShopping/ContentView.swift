//
//  ContentView.swift
//  GroceryShopping
//
//  Created by Ankit Bansal on 2/5/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = GroceryListViewModel()
    
    var body: some View {
        NavigationView {
            TabView {
                NavigationView {
                    GroceryListView()
                }
                .tabItem {
                    Label("Grocery List", systemImage: "list.bullet")
                }
                
                NavigationView {
                    BasketView(viewModel: viewModel)
                }
                .tabItem {
                    Label("Basket", systemImage: "cart")
                }
            }
        }
        /*.onAppear {
            viewModel.fetchGroceryItems() // Call start() when ContentView appears
        }*/
    }
}

#Preview {
    ContentView()
}
