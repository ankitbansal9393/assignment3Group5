//
//  Service.swift
//  GroceryShopping
//
//  Created by Ankit Bansal on 2/5/2024.
//
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class FirestoreService: ObservableObject {
    private var db = Firestore.firestore()
    
    
    private var listenerRegistration: ListenerRegistration?
    @Published var groceryItems: [GroceryItem] = [] // Local storage for grocery items
    @Published var basketItems: [GroceryItem] = [] // Local storage for basket items
    private var cancellables = Set<AnyCancellable>()
       
    

    
    func updateItemQuantityInFirestore(item: GroceryItem, newQuantity: Int) {
        // let db = Firestore.firestore()
        let itemRef = db.collection("groceryItems").document(item.id)
        
        itemRef.updateData([
            "quantity": newQuantity
        ]) { error in
            if let error = error {
                print("Error updating item quantity: \(error.localizedDescription)")
            } else {
                print("Item quantity updated successfully in Firestore")
            }
        }
    }
    func saveOrder(order: Order) {
        do {
            let _ = try db.collection("orders").addDocument(from: order)
        } catch {
            print("Error saving order to Firestore: \(error.localizedDescription)")
        }
    }

    
    func fetchGroceryItems() -> AnyPublisher<[GroceryItem], Error> {
        let subject = PassthroughSubject<[GroceryItem], Error>()
        
        db.collection("groceryItems")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error fetching grocery items: \(error.localizedDescription)")
                    subject.send(completion: .failure(error))
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents found or unexpected data")
                    subject.send(completion: .finished)
                    return
                }
                
                var groceryItems: [GroceryItem] = []
                
                for document in documents {
                    let rawDocumentData = document.data()
                    
                    guard let name = rawDocumentData["name"] as? String else {
                        print("Name is missing or invalid for document: \(document.documentID)")
                        continue // Skip this document and move to the next one
                    }
                    
                    guard let category = rawDocumentData["category"] as? String else {
                        print("Category is missing or invalid for document: \(document.documentID)")
                        continue // Skip this document and move to the next one
                    }
                    
                    let quantity = rawDocumentData["quantity"] as? Int ?? 0
                    let price = rawDocumentData["price"] as? Double ?? 0.0
                    
                    let groceryItem = GroceryItem(id: document.documentID, name: name, price: price, category: category, quantity: quantity)
                    groceryItems.append(groceryItem)
                }
                
                subject.send(groceryItems)
                subject.send(completion: .finished)
            }
        
        return subject.eraseToAnyPublisher()
    }
    func fetchBasketItems(completion: @escaping ([GroceryItem]) -> Void) {
        print("Fetching basket items...")
        
        db.collection("groceryItems")
            .whereField("quantity", isGreaterThan: 0) // Filter items with quantity greater than 0
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error fetching basket items: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents found or unexpected data")
                    return
                }
                
                var basketItems: [GroceryItem] = []
                for document in documents {
                    if let groceryItem = try? document.data(as: GroceryItem.self) {
                        basketItems.append(groceryItem)
                    } else {
                        print("Error decoding document as GroceryItem")
                    }
                }
                
                print("Fetched \(basketItems.count) basket items.")
                completion(basketItems) // Call the completion handler with fetched basket items
            }
    }


    func shopItem(_ item: GroceryItem) {
        var newItem = item
        newItem.quantity += 1
        updateGroceryItem(newItem)
    }
    
    private func updateGroceryItem(_ item: GroceryItem) {
        do {
            try db.collection("groceryItems").document(item.id).setData(from: item)
        } catch {
            // Handle error
        }
    }
}
