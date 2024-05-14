//
//  LoginView.swift
//  GroceryShopping
//
//  Created by Daun Jeong on 4/5/2024.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var goToSignUp: Bool = false
    @State private var goToHome: Bool = false
    
    
    
    //For giving Alert
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    //Binding for HomeView COntroll
    @Binding var isUserCurrentlyLoggedOut: Bool
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                Color(hex: "#FFFFFF")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("logo")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .padding(.bottom, 60)
                    
                    TextField("", text: $email)
                        .placeholder(when: email.isEmpty) {
                            Text("Email").foregroundColor(.gray)
                        }
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(Color.mainTextColor)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .underlineTextField()
                    
                    
                    SecureField("", text: $password)
                        .placeholder(when: email.isEmpty) {
                            Text("Password").foregroundColor(.gray)
                        }
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(Color.mainTextColor)
                        .textContentType(.password)
                        .underlineTextField()
                    
                    Text("Forgot password")
                        .font(.custom("Poppins-Regular", size: 15))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 10)
                        .padding(.bottom, 30)
                        .padding(.top, -10)
                    
                    
                    
                    Button {
                        loginUser()
                    } label: {
                        Text("Login")
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
                    
                    NavigationLink(destination: SignUpView(), isActive: $goToSignUp) { EmptyView() }
                    
                    NavigationLink(destination: HomeView(), isActive: $goToHome) { EmptyView() }
                    
                    Text("Don't have an account? \(Text("Sign up.").foregroundColor(.mainTextColor).font(.custom("Poppins-Bold", size: 15)))")
                        .foregroundColor(.gray)
                        .font(.custom("Poppins-Regular", size: 15))
                        .foregroundColor(.gray)
                        .padding(.top, 30)
                        .padding(.bottom, 30)
                        .onTapGesture {
                            self.goToSignUp = true
                        }
                    
                    
                }
                .padding()
            }
            .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Alert"),
                            message: Text(alertMessage),
                            dismissButton: .default(Text("OK"))
                        )
                    }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.goToSignUp = false
            }
        }
    }
    
    private func loginUser(){
        Auth.auth().signIn(withEmail: email, password: password) {result, err in
            if let err = err {
                print("login error", err)
                self.showAlert = true
                self.alertMessage = "Failed: \(err.localizedDescription)"
                return
            }
            
            print("Succesfully Logged in: \(result?.user.uid ?? "") ")
            
            self.isUserCurrentlyLoggedOut = true
        }
    }

    
}

struct LoginView_Previews: PreviewProvider {
    @State static var isUserCurrentlyLoggedOut = false
    static var previews: some View{
        LoginView(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
    }
}


//#Preview {
//    LoginView()
//}

