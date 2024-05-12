//
//  HomeView.swift
//  GroceryShopping
//
//  Created by Daun Jeong on 4/5/2024.
//

import SwiftUI

struct HomeView: View {
    
    
    var body: some View {
        NavigationView {
            ZStack {
                
                ScrollView (.vertical, showsIndicators: false) {
                    AppBarView()
                    SearchView()
                    SpecialOfferView()
                    CategoriesView()
                    BigOffersView()
                    RecentlyAddedView()
                    Spacer(minLength: 60)
                }
                
                
                
                BottomNavBar()
            }
            .padding(.all, 10)
            
        }
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct AppBarView: View {
    
    var body: some View {
        HStack {
            
            VStack (alignment: .leading) {
                Text("Hello Jade!")
                    .font(.custom("Poppins-Bold", size: 18))
                    .foregroundColor(Color.mainTextColor)
                
                Text("What do you want?")
                    .font(.custom("Poppins-Medium", size: 14))
                    .foregroundColor(Color.mainTextColor)
                    .padding(.top, 0.5)
                
            }
            
            
            Spacer()
            
        }
        .padding(.horizontal)
    }
}

struct SearchView: View {
    @State private var search = ""
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.leading, 30)
            
            
            
            TextField("Search", text: $search)
                .font(.custom("Poppins-Regular", size: 18))
                .foregroundColor(.mainTextColor)
                .keyboardType(.default)
                .textContentType(.name)
                .padding(10)
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.mainMintColor, lineWidth: 2))
        .padding(10)
        
    }
}

struct SpecialOfferView: View {
    var body: some View {
        ZStack (alignment: .bottomTrailing) {
            
            HStack (alignment: .top)  {
                VStack (alignment: .leading) {
                    Text("Up to 50% off*")
                        .font(.custom("Poppins-Bold", size: 24))
                        .foregroundColor(Color.white)
                    
                    Text("ONLINE SUPER SALE")
                        .font(.custom("Poppins-Regular", size: 24))
                        .foregroundColor(Color.white)
                    
                    Spacer()
                    
                }
                
                Spacer()
            }
            
            Image("banner")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
                .padding(.trailing, -30)
                .padding(.bottom, 10)
            
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.mainMintColor))
        .padding(.horizontal, 10)
    }
}

struct FruitItemView: View {
    
    @State var image = ""
    @State var text = ""
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
                .padding(20)
                .background(Color.init(hex: "#E5EFEB"))
                .clipShape(Circle())
            
            Text(text)
                .font(.custom("Poppins-Regular", size: 13))
                .foregroundColor(Color.mainTextColor)
                .lineLimit(1)
        }
    }
}

struct CategoriesView: View {
    
    @State var productList: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Category")
                        .font(.custom("Poppins-Bold", size: 18))
                        .foregroundColor(Color("TextDarkColor"))
                    
                    
                    Spacer()
                    
                    
                    NavigationLink(
                        "", destination: GroceryListView(),
                        isActive: $productList)
                    
                    Text("View More")
                        .font(.custom("Poppins-Regular", size: 15))
                        .foregroundColor(Color.mainMintColor)
                        .onTapGesture {
                            productList = true
                        }
                    
                }
                
            }
            .padding(.horizontal, 10)
            .padding(.top, 15)
            
            
            HStack (alignment: .center, spacing: 40) {
                FruitItemView(image: "fruit", text: "Fruits")
                FruitItemView(image: "freezer", text: "Freezer")
                FruitItemView(image: "bakery", text: "Bakery")
                FruitItemView(image: "drinks", text: "Drinks")
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.productList = false
            }
        }
    }
}

struct BigOfferItemView: View {
    
    @State var image = ""
    @State var text = ""
    @State var color: Color = .mainMintColor
    
    var body: some View {
        ZStack (alignment: .bottomTrailing) {
            VStack (alignment: .leading) {
                Text(text)
                    .font(.custom("Poppins-Medium", size: 17))
                    .foregroundColor(Color.white)
                
                Spacer()
            }
            
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 60)
                .padding(.bottom, 10)
            
            
        }
        .frame(width: 135, height: 100)
        .padding(.top, 10)
        .padding(.horizontal, 10)
        .background(RoundedRectangle(cornerRadius: 10).fill(color))
        .padding(.horizontal, 10)
    }
}

struct BigOffersView: View {
    
    @State var goToFruitDetails: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Specials")
                        .font(.custom("Poppins-Bold", size: 18))
                        .foregroundColor(Color("TextDarkColor"))
                    
                    
                    Spacer()
                    
                    Text("View More")
                        .font(.custom("Poppins-Regular", size: 15))
                        .foregroundColor(Color.mainMintColor)
                    
                }
                
            }
            .padding(.horizontal, 10)
            .padding(.top, 15)
            
            
            ScrollView (.horizontal, showsIndicators: false) {
                HStack {
                    BigOfferItemView(image: "oranges_big", text: "Fresh oranges \n50% Off", color: Color.init(hex: "#FE6444"))
                    BigOfferItemView(image: "papaya_big", text: "Fresh papaya \n20% Off", color: Color.init(hex: "#41B8A2"))
                    BigOfferItemView(image: "apples_big", text: "Fresh apples \n20% Off")
                }
                
            }
        }
        .padding(.top, 20)
    }
}

struct RecentlyAddedView: View {
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Latest Product")
                        .font(.custom("Poppins-Bold", size: 18))
                        .foregroundColor(Color("TextDarkColor"))
                    
                    
                    Spacer()
                    
                    Text("Show All")
                        .font(.custom("Poppins-Regular", size: 15))
                        .foregroundColor(Color.mainMintColor)
                    
                }
                
            }
            .padding(.horizontal, 10)
            .padding(.top, 15)
            
            
            ScrollView (.horizontal, showsIndicators: false) {
                HStack {
                    BigOfferItemView(image: "apples_big", text: "Awesome apples from locals")
                    BigOfferItemView(image: "oranges_big", text: "New oranges Egypt", color: Color.init(hex: "#FE6444"))
                    BigOfferItemView(image: "papaya_big", text: "Freshly arrived papaya", color: Color.init(hex: "#41B8A2"))
                    
                }
                
            }
        }
        .padding(.top, 20)
    }
}

struct BottomNavBarItem: View {
    
    let image: Image
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            image
                .frame(maxWidth: .infinity)
                .tint(.mainMintColor)
        })
    }
}

struct BottomNavBar: View {
    @State var goToCart: Bool = false
    
    var body: some View {
        HStack {
            
            NavigationLink(
                "", destination: BasketView(viewModel: GroceryListViewModel()),
                isActive: $goToCart)
            
            
            BottomNavBarItem(image: Image(systemName: "house")) {}
            BottomNavBarItem(image: Image(systemName: "cart")) {
                goToCart = true
            }
            BottomNavBarItem(image: Image(systemName: "bell.badge")) {}
            BottomNavBarItem(image: Image(systemName: "person")) {}
        }
        .padding()
        .background(Color.white)
        .clipShape(Capsule())
        .padding(.horizontal)
        .shadow(color: Color.black.opacity(0.15), radius: 8, x: 2, y: 6)
        .frame(maxHeight: .infinity, alignment: .bottom)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.goToCart = false
            }
        }
    }
}



