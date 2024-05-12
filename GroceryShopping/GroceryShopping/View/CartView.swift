//
//  CartView.swift
//  GroceryShopping
//
//  Created by Daun Jeong on 4/5/2024.
//

import SwiftUI

struct CartView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel = GroceryListViewModel()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Total \(viewModel.basketItems.count)")
                    .font(.custom("Poppins-Medium", size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(viewModel.basketItems) { item in
                        CartItemView(item: item)
                    }
                }
                
                BottomSumView()
                
                Button(action: {
                    // Add action for checkout
                }) {
                    Text("Check out")
                        .font(.custom("Poppins-Bold", size: 18))
                        .foregroundColor(.white)
                        .padding(10)
                }
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.mainMintColor)
                .cornerRadius(40)
            }
            .padding(20)
        }
        .navigationBarTitle(Text("Cart").font(.custom("Poppins-Bold", size: 18)))
        .background(Color.white)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.backward").tint(Color.mainTextColor).font(.system(size: 25))
                }
            }
        }
    }
}



struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}

struct CartItemView: View {
    var item: GroceryItem
    
    var body: some View {
        HStack(spacing: 20) {
            /* Image(item.imageName) // Placeholder for the actual image file name
             .resizable()
             .scaledToFit()
             .frame(width: 80, height: 80)
             .cornerRadius(10)
             .padding(.leading, 10)*/
            
            VStack(alignment: .leading, spacing: 8) {
                Text(item.name)
                    .font(.custom("Poppins-Bold", size: 16))
                    .foregroundColor(Color.black.opacity(0.7))
                Text("$\(item.price, specifier: "%.2f") | \(item.quantity)KG")
                    .font(.custom("Poppins-Regular", size: 14))
                    .foregroundColor(Color.gray)
            }
            
            Spacer()
            
            // Adjust the increment and decrement buttons if necessary
            HStack(spacing: 10) {
                Button(action: {
                    // Decrement action
                }) {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(Color.red)
                }
                
                Text("1") // This would be dynamically bound to item quantity in a real app
                    .font(.custom("Poppins-Regular", size: 16))
                
                Button(action: {
                    // Increment action
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(Color.green)
                }
            }
            .padding(.trailing, 10)
        }
        .frame(height: 100)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal, 10)
    }
}

struct BottomSumView: View {
    var body: some View {
        HStack {
            VStack (alignment: .leading, spacing: 10) {
                Text("Order")
                    .font(.custom("Poppins-Regular", size: 16))
                    .foregroundColor(.mainTextColor)
                
                Text("Delivery")
                    .font(.custom("Poppins-Regular", size: 16))
                    .foregroundColor(.mainTextColor)
                
                Text("Grand Total")
                    .font(.custom("Poppins-Bold", size: 16))
                    .foregroundColor(.mainTextColor)
                
            }
            
            Spacer()
            
            VStack (alignment: .trailing, spacing: 10) {
                Text("$ 51")
                    .font(.custom("Poppins-Regular", size: 16))
                    .foregroundColor(.mainTextColor)
                
                Text("$ 4.2")
                    .font(.custom("Poppins-Regular", size: 16))
                    .foregroundColor(.mainTextColor)
                
                Text("$ 55.2")
                    .font(.custom("Poppins-Bold", size: 18))
                    .foregroundColor(.mainTextColor)
                
            }
        }
    }
}
