//
//  BasketView.swift
//  GroceryShopping
//
//  Created by Ankit Bansal on 2/5/2024.
//

import SwiftUI


struct BasketView: View {
    @ObservedObject var viewModel: GroceryListViewModel
    @State private var showMessage: Bool = false
    var totalAmount: Double {
        return viewModel.basketItems.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }
    
    var totalItems: Int {
        return viewModel.basketItems.reduce(0) { $0 + $1.quantity }
    }
    
    var body: some View {
        VStack {
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
                        Button(action: {
                            viewModel.incrementItemQuantity(at: index)
                        }) {
                            Text("+")
                        }
                        .buttonStyle(BasketButtonStyle())
                        
                        Button(action: {
                            viewModel.decrementItemQuantity(at: index)
                        }) {
                            Text("-")
                        }
                        .buttonStyle(BasketButtonStyle())
                        
                        Button(action: {
                            viewModel.deleteItemsFromBasket(at: IndexSet([index]))
                        }) {
                            Image(systemName: "trash")
                        }
                        .buttonStyle(BasketButtonStyle())
                    }
                }
                .onDelete(perform: viewModel.deleteItemsFromBasket) // Enable swipe-to-delete gesture
            }
            .navigationTitle("Basket")
            .onAppear {
                viewModel.updateBasketItems()
            }
            
            Spacer()
            
            HStack {
                Text("Total Items:")
                Spacer()
                Text("\(totalItems)")
            }
            .padding()
            
            HStack {
                Text("Total Amount:")
                Spacer()
                Text("$\(totalAmount, specifier: "%.2f")")
            }
            .padding()
            
            Button("Checkout") {
                viewModel.createOrder()
                showMessage = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    showMessage = false
                }
            }
            .font(.custom("Poppins-Bold", size: 18))
            .foregroundColor(.white)
            .padding(10)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(Color.mainMintColor)
            .cornerRadius(40)
            .padding()
            if showMessage {
                Text("Order Placed successfully!")
                    .foregroundColor(.green)
                    .padding()
            }
        }
    }
}

struct BasketButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(8)
            .foregroundColor(.white)
            .background(configuration.isPressed ? Color.gray : Color.mainMintColor)
            .cornerRadius(8)
    }
}


#Preview {
    BasketView(viewModel: GroceryListViewModel())
}

