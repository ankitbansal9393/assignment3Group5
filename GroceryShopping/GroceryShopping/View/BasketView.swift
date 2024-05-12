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
    @State private var showDetailsSheet: Bool = false
    @State private var userName: String = ""
    @State private var userAddress: String = ""
    @State private var userContactInfo: String = ""
    @State private var orderId: String = ""  // Add orderId state variable
    
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
                showDetailsSheet = true
                orderId = UUID().uuidString  // Generate orderId
            }
            .font(.custom("Poppins-Bold", size: 18))
            .foregroundColor(.white)
            .padding(10)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(Color.mainMintColor)
            .cornerRadius(40)
            .padding()
            .sheet(isPresented: $showDetailsSheet) {
                UserDetailsView(userName: $userName, userAddress: $userAddress, userContactInfo: $userContactInfo, orderId: $orderId) { name, address, contactInfo, orderId in
                    if !name.isEmpty && !address.isEmpty && !contactInfo.isEmpty && !orderId.isEmpty {
                        viewModel.createOrder(orderId: orderId)
                        FirestoreService().saveUserDetails(name: name, address: address, contactInfo: contactInfo, orderId: orderId)  // Save orderId in user details
                        showMessage = true
                        showDetailsSheet = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showMessage = false
                        }
                    }
                }
            }
            
            if showMessage {
                Text("Order Placed successfully!")
                    .foregroundColor(.green)
                    .padding()
            }
        }
    }
}
struct UserDetailsView: View {
    @Binding var userName: String
    @Binding var userAddress: String
    @Binding var userContactInfo: String
    @Binding var orderId: String  // Add orderId binding
    @State private var showMessage: Bool = false
    var onConfirm: (String, String, String, String) -> Void  // Include orderId in the closure
    
    var body: some View {
        VStack {
            TextField("Name", text: $userName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Address", text: $userAddress)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Contact Info", text: $userContactInfo)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack {
                Button("Clear") {
                    userName = ""
                    userAddress = ""
                    userContactInfo = ""
                    orderId = ""  // Clear orderId on clear
                    onConfirm("", "", "", "")  // Include orderId in the closure
                    showMessage = false
                }
                .font(.custom("Poppins-Bold", size: 18))
                .foregroundColor(.white)
                .padding(10)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.red)
                .cornerRadius(40)
                
                Button("Confirm") {
                    if !userName.isEmpty && !userAddress.isEmpty && !userContactInfo.isEmpty {
                        onConfirm(userName, userAddress, userContactInfo, orderId)  // Include orderId in the closure
                        showMessage = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showMessage = false
                        }
                    }
                }
                .font(.custom("Poppins-Bold", size: 18))
                .foregroundColor(.white)
                .padding(10)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.mainMintColor)
                .cornerRadius(40)
            }
            .padding()
        }
        .padding()
        .alert(isPresented: $showMessage) {
            Alert(title: Text("Order Placed Successfully!"), message: Text("Thank you for your purchase."), dismissButton: .default(Text("OK")))
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

