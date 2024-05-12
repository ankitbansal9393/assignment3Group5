//
//  GroceryListView.swift
//  GroceryShopping
//
//  Created by Ankit Bansal on 2/5/2024.
//

import SwiftUI
struct GroceryListView: View {
    @ObservedObject var viewModel = GroceryListViewModel()
    @State private var showMessage: Bool = false
    var body: some View {
        VStack {
            Picker("Category", selection: Binding(
                get: { viewModel.selectedCategory },
                set: { viewModel.selectedCategory = $0; viewModel.filterItemsByCategory() }
            )) {
                Text("All").tag("All")
                Text("Fruits").tag("Fruits")
                Text("Vegetables").tag("Vegetables")
                // Add more categories as needed
            }
            .pickerStyle(SegmentedPickerStyle())
            
            List(viewModel.groceryItems) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                        Text("$\(item.price)")
                        Text(item.category)
                    }
                    Spacer()
                    Button("Shop") {
                        viewModel.shopItem(item)
                        viewModel.updateBasketItems()
                        showMessage = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showMessage = false
                        }
                    }
                }
            }
        }
        .navigationTitle("Grocery List")
        .onAppear {
            viewModel.filterItemsByCategory()
            viewModel.updateBasketItems()
            
        }
        if showMessage {
            Text("Item added successfully to the basket")
                .foregroundColor(.green)
                .padding()
        }
    }
}
#Preview {
    GroceryListView()
}
