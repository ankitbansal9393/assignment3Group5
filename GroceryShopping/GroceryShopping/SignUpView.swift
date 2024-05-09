//
//  SignUpView.swift
//  GroceryShopping
//
//  Created by Daun Jeong on 4/5/2024.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var password: String = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color(hex: "#FFFFFF")
                    .edgesIgnoringSafeArea(.all)
                
                
                VStack {
                    Image("logo")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .padding(.bottom, 60)
                    
                    TextField("", text: $name)
                        .placeholder(when: name.isEmpty) {
                                Text("Name").foregroundColor(.gray)
                        }
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(Color("TextDarkColor"))
                        .keyboardType(.default)
                        .textContentType(.name)
                        .underlineTextField()
                    
                    TextField("", text: $email)
                        .placeholder(when: email.isEmpty) {
                                Text("Email Address").foregroundColor(.gray)
                        }
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(Color("TextDarkColor"))
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .underlineTextField()
                    
                    TextField("", text: $phone)
                        .placeholder(when: phone.isEmpty) {
                                Text("Phone Number").foregroundColor(.gray)
                        }
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(Color("TextDarkColor"))
                        .keyboardType(.phonePad)
                        .textContentType(.telephoneNumber)
                        .underlineTextField()
                    
                    
                    SecureField("", text: $password)
                        .placeholder(when: password.isEmpty) {
                                Text("Password").foregroundColor(.gray)
                        }
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(Color("TextDarkColor"))
                        .textContentType(.password)
                        .underlineTextField()
                    
                    Button {} label: {
                      Text("Sign up")
                            .font(.custom("Poppins-Bold", size: 18))
                            .foregroundColor(.white)
                            .padding(10)
                            
                    }
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(5)
                    .background(Color.mainMintColor)
                    .cornerRadius(30)
                    
                    
                    Text("Or Continue With")
                        .font(.custom("Poppins-Regular", size: 15))
                        .foregroundColor(.gray)
                        .padding(.top, 30)
                        .padding(.bottom, 30)
                    
                    HStack (alignment: .center) {
                        Image("google")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .padding(.horizontal, 5)
                        
                        Image("twitter")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .padding(.horizontal, 10)
                        
                        Image("facebook")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .padding(.horizontal, 5)
                    }
                    
                    Text("Already have an account? \(Text("Sign in.").foregroundColor(.mainTextColor).font(.custom("Poppins-Bold", size: 15)))")
                        .foregroundColor(.gray)
                        .font(.custom("Poppins-Regular", size: 15))
                        .foregroundColor(.gray)
                        .padding(.top, 30)
                        .padding(.bottom, 30)
                    
                }
                .padding()

            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
    
                Image(systemName: "arrow.backward")
                    .tint(.mainTextColor)
                    .font(.system(size: 25))
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }

                
                
              
            }
        }
    }
}
#Preview {
    SignUpView()
}

