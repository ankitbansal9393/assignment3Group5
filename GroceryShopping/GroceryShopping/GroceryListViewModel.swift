//
//  GroceryListViewModel.swift
//  GroceryShopping
//
//  Created by Ankit Bansal on 2/5/2024.
//
import Foundation
import Combine


class GroceryListViewModel: ObservableObject {
    private var firestoreService = FirestoreService()
  
    @Published var groceryItems: [GroceryItem] = []
    @Published var selectedCategory: String = "All"  // Default category filter
    @Published var basketItems: [GroceryItem] = []
    @Published var orderItems: [OrderItem] = []
    //@Published var order: Order
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // fetchGroceryItems()
        //   firestoreService = FirestoreService()
        groceryItems = []
        selectedCategory = "All"
        basketItems = []
        cancellables = Set<AnyCancellable>()
        orderItems = []
        //   order = ""
        
        fetchGroceryItems()
        //fetchBasketItems()
    }
  /*  func start() {
           fetchGroceryItems()
       }*/
    func fetchGroceryItems() {
        firestoreService.fetchGroceryItems()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { items in
                self.groceryItems = items
            })
            .store(in: &cancellables)
    }
    func updateBasketItems() {
        firestoreService.fetchBasketItems { basketItems in
            DispatchQueue.main.async {
                self.basketItems = basketItems
            }
        }
    }
    
    func shopItem(_ item: GroceryItem) {
        firestoreService.shopItem(item)
    }
    
    func filterItemsByCategory() {
        if selectedCategory == "All" {
            fetchGroceryItems()
        } else {
            groceryItems = groceryItems.filter { $0.category == selectedCategory }
        }
    }
    
    /*func    updateBasketItems() {
        basketItems = groceryItems.filter { $0.quantity > 0 }
    }*/

    func deleteItemsFromBasket(at offsets: IndexSet) {
        // Iterate through the indices in reverse order to avoid index out of range issues
        for index in offsets.sorted(by: >) {
            let item = basketItems[index]
            basketItems.remove(at: index)
            firestoreService.updateItemQuantityInFirestore(item: item, newQuantity: 0) // Update quantity to 0 in Firestore
        }
    }
    func createOrder() {
            let orderItems = basketItems.map { OrderItem(name: $0.name, price: $0.price, quantity: $0.quantity) }
            let totalAmount = basketItems.reduce(0.0) { $0 + ($1.price * Double($1.quantity)) }
            let order = Order(orderItems: orderItems, totalAmount: totalAmount)
            
            firestoreService.saveOrder(order: order)
            basketItems.removeAll() // Clear basket after checkout
        }
}

/*class GroceryListViewModel: ObservableObject {
    private var firestoreService = FirestoreService()
    
    @Published var groceryItems: [GroceryItem] = []
    @Published var basketItems: [GroceryItem] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchGroceryItems()
    }
    
    func fetchGroceryItems() {
        firestoreService.fetchGroceryItems()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { items in
                self.groceryItems = items
            })
            .store(in: &cancellables)
    }
    
    func shopItem(_ item: GroceryItem) {
        firestoreService.shopItem(item)
    }
    
    func updateBasketItems() {
        basketItems = groceryItems.filter { $0.quantity > 0 }
    }
}
*/
