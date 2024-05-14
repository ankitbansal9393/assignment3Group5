//
//  MainView.swift
//  GroceryShopping
//
//  Created by kundan rayamajhi on 14/5/2024.
//

import SwiftUI

struct MainView: View {
    @State private var isUserCurrentlyLoggedOut: Bool = false
    
    
    var body: some View {
        NavigationStack{
            if self.isUserCurrentlyLoggedOut{
                HomeView()
            }
            else
            {
                LoginView(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
            }
        }
    }
}

#Preview {
    MainView()
}
