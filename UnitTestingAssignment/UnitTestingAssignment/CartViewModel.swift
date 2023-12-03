//
//  CartViewModel.swift
//  UnitTestingAssignment
//
//  Created by Baramidze on 02.12.23.
//

import Foundation

final class CartViewModel {
    
    var allProducts: [Product]?
    
    var selectedProducts = [Product]()
    
    var selectedItemsQuantity: Int? {
        selectedProducts.reduce(0) { $0 + ($1.selectedQuantity ?? 0) }
    }
    
    var totalPrice: Double? {
        selectedProducts.reduce(0.0) { $0 + Double($1.selectedQuantity ?? 0) * ($1.price ?? 0)  }
    }
    
    func viewDidLoad() {
        fetchProducts()
    }
    
    func fetchProducts() {
        
//        self.allProducts = ProductsResponse.dummyProducts

        NetworkManager.shared.fetchProducts(completion: { [weak self] result in
            switch result {
            case .success(let products):
                self?.allProducts = products!
            case .failure(_):
                break
            }
        })
    }
    
    func addProduct(withID: Int?) {
        if let productForAdd = allProducts?.first(where: { $0.id == withID }) {
            addProduct(product: productForAdd)
        }
    }
    
    func addProduct(product: Product?) {
        guard let product else { return }
        if let index = selectedProducts.firstIndex(where: { $0.id == product.id }) {
            selectedProducts[index].selectedQuantity! += 1 // selected quantity must be increased by 1, not by product.selectedQuantity!
        } else {
            product.selectedQuantity = 1 //this line was absent, so product quantity was always zero, even if it was previously added to cart.
            selectedProducts.append(product)
        }
    }
    
    func addRandomProduct() {
        addProduct(product: allProducts?.randomElement())
    }
    
    func removeProduct(withID: Int) {
        selectedProducts.removeAll(where: { $0.id == withID })
    }
    
    func clearCart() {
        selectedProducts.removeAll()
    }
}
