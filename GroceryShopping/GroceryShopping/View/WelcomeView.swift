//
//  WelcomeView.swift
//  GroceryShopping
//
//  Created by Daun Jeong on 4/5/2024.
//

import SwiftUI

struct WelcomeView: View {
    
    @State private var goToLogin: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color(.white)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .background(Circle().fill(Color.mainMintColor))
                    
                    VStack(alignment: .center, spacing: 10) {
                        Text("Welcome to Jade's shop")
                            .font(.custom("Poppins-Medium", size: 25))
                            .foregroundColor(Color.mainTextColor)
                        
                        
                        Text("One stop to purchase all the Grocery needs. Beats all the prices!!")
                            .font(.custom("Poppins-Regular", size: 18))
                            .foregroundColor(Color.mainTextColor)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    .padding()
                    
                    
                    NavigationLink(destination: MainView().navigationBarBackButtonHidden(true), isActive: $goToLogin) { EmptyView() }
                    
                    Button(action: {
                        self.goToLogin = true
                    } ) {
                        Text("Get Started")
                            .font(.custom("Poppins-Bold", size: 18))
                            .foregroundColor(.white)
                            .padding(10)
                        
                    }
                    
                    .frame(width: 300)
                    .padding(5)
                    .background(Color.mainMintColor)
                    .cornerRadius(40)
                    
                    
                    
                }
                
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
    }
}

#Preview {
    WelcomeView()
}
