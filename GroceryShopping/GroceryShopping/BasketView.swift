//
//  BasketView.swift
//  GroceryShopping
//
//  Created by Ankit Bansal on 2/5/2024.
//

import SwiftUI


//new code
struct BasketView: View {
    @ObservedObject var viewModel: GroceryListViewModel
    //@ObservedObject var viewModel = FirestoreService()
    var body: some View {
        VStack{
            List {
                ForEach(viewModel.basketItems.indices, id: \.self) { index in
                    let item = viewModel.basketItems[index]
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                            Text("$\(item.price)")
                            Text("Quantity: \(item.quantity)")
                        }
                        Spacer()
                        Button("Delete") {
                            viewModel.deleteItemsFromBasket(at: IndexSet([index]))
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteItemsFromBasket) // Enable swipe-to-delete gesture
            }
            .navigationTitle("Basket")
            .onAppear {
                viewModel.updateBasketItems()
            }
            Button("Checkout") {
                         viewModel.createOrder()
                     }
        }
    }
}
#Preview {
    BasketView(viewModel: GroceryListViewModel())
}
