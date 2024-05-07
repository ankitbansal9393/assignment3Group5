//
//  AddItemView.swift
//  GroceryShopping
//
//  Created by Ankit Bansal on 2/5/2024.
//

import SwiftUI
/*struct AddItemView: View {
    @State private var itemName = ""
    @State private var itemPrice = ""
    @State private var itemCategory = ""
    @ObservedObject var firestoreService = FirestoreService()
    
    var body: some View {
        Form {
            Section(header: Text("Item Details")) {
                TextField("Name", text: $itemName)
                TextField("Price", text: $itemPrice)
                    .keyboardType(.decimalPad)
                TextField("Category", text: $itemCategory)
            }
            
            Button("Add Item") {
                if let price = Double(itemPrice) {
                    let newItem = GroceryItem(id: UUID().uuidString, name: itemName, price: price, category: itemCategory, quantity: 0)
                    firestoreService.addGroceryItem(newItem)
                    clearFields()
                }
            }
        }
        .navigationTitle("Add Item")
    }
    
    private func clearFields() {
        itemName = ""
        itemPrice = ""
        itemCategory = ""
    }
}

*/

/*
#Preview {
    AddItemView()
}*/
