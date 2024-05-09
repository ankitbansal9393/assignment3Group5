//
//  ContentView.swift
//  GroceryShopping
//
//  Created by Ankit Bansal on 2/5/2024.
//

import SwiftUI


struct ContentView: View {
    @State private var isActive = false
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#8CBDB9")
                    .edgesIgnoringSafeArea(.all)
                
                
                VStack {
                    Image("logo2")
                        .resizable()
                        .frame(width: 300, height: 300)
                    
                }
                
                
                
                NavigationLink(destination: WelcomeView(),
                               isActive: $isActive,
                               label: {  })
                
            }
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.isActive = true
                }
            })
        }
        .background(Color.mainMintColor)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
    }
}

#Preview {
    ContentView()
        .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
}
