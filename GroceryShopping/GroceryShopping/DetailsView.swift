//
//  DetailsView.swift
//  GroceryShopping
//
//  Created by Daun Jeong on 4/5/2024.
//

import SwiftUI

struct DetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var image = "oranges_big"
    @State var title = ""
    
    
    var body: some View {
        ZStack {
            
            Color("MainMintColor")
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                VStack {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 250)
                }
                .frame(height: 300)
                
                VStack {
                    HStack {
                        VStack (alignment: .leading) {
                            Text(title)
                                .font(.custom("Poppins-Bold", size: 16))
                                .foregroundColor(.mainTextColor)
                            
                            Spacer()
                            
                            Text("$10 | KG")
                                .font(.custom("Poppins-Medium", size: 15))
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            HStack (spacing: 15) {
                                Image(systemName: "minus")
                                    .foregroundColor(.white)
                                    .bold()

                                
                                Text("1")
                                    .font(.custom("Poppins-Regular", size: 16))
                                    .foregroundColor(.white)
                                    .bold()

                                
                                
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .bold()

                            }
                            .frame(width: 90, height: 25)
                            .padding(5)
                            .background(Color.mainMintColor).cornerRadius(40)
                            
                        }
                        .padding(.vertical, 20)
                        
                        Spacer()
                        
                        VStack (alignment: .trailing, spacing: 8) {
                            Image(systemName: "heart")
                                .resizable()
                                .frame(width: 16, height: 16)
                            
                            Spacer()
                            
                            Text("$ 10")
                                .font(.custom("Poppins-Bold", size: 19))
                                .foregroundColor(.mainTextColor)
                                
                        }
                        .padding(.vertical, 30)
                    }
                    .frame(maxHeight: 150)
                    
                    VStack (alignment: .leading) {
                        Text(title)
                            .font(.custom("Poppins-Medium", size: 16))
                            .foregroundColor(.mainTextColor)
                            .padding(.top, 10)
                            .padding(.bottom, 3)
                        
                        
                        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                            .font(.custom("Poppins-Medium", size: 15))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Button {} label: {
                      Text("Check out")
                            .font(.custom("Poppins-Bold", size: 18))
                            .foregroundColor(.white)
                            .padding(10)
                    }
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(5)
                    
                    .background(Color.mainMintColor)
                    .cornerRadius(40)
                    
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                .background(Color.white)
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .frame(maxWidth: .infinity)
                .edgesIgnoringSafeArea(.bottom)
                
                
                
            }
            
            
            
            
        
        }
        .navigationBarTitle(Text("Fruits").font(.custom("Poppins-Bold", size: 18)).foregroundColor(.white))
        .background(Color.mainBackgroundColor)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                   
                Image(systemName: "arrow.backward")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }
            
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView()
    }
}
