//
//  UnitTestForCartViewModelClass.swift
//  UnitTestingAssignmentTests
//
//  Created by Luka Gazdeliani on 03.12.23.
//

import XCTest
@testable import UnitTestingAssignment

final class CartViewModelTests: XCTestCase {

    var cartViewModel: CartViewModel!
    
    override func setUpWithError() throws {
        cartViewModel = CartViewModel()
        cartViewModel.viewDidLoad()
    }

    override func tearDownWithError() throws {
        cartViewModel = nil
    }

    func testSelectedProductCountAfterProductsAddition() {
        let expectation = self.expectation(description: "Fetching products from API")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.cartViewModel.addProduct(withID: 1)
            self.cartViewModel.addProduct(withID: 13)
            self.cartViewModel.addProduct(withID: 13)
            self.cartViewModel.addProduct(withID: 13)
            XCTAssertEqual(self.cartViewModel.selectedProducts.count, 2)
        
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5)
    }
    
    func testSelectedItemsQuantityAfterProductsAddition() {
        let expectation = self.expectation(description: "Fetching products from API")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.cartViewModel.addProduct(withID: 4)
            self.cartViewModel.addProduct(withID: 9)
            self.cartViewModel.addProduct(withID: 9)
            self.cartViewModel.addProduct(withID: 9)
            self.cartViewModel.addProduct(withID: 9)
            self.cartViewModel.addProduct(withID: 14)
            self.cartViewModel.addRandomProduct()
            self.cartViewModel.addRandomProduct()
            XCTAssertEqual(self.cartViewModel.selectedItemsQuantity, 8)
        
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5)
    }
    
    func testSelectedProductCountAfterProductRemoval() {
        let expectation = self.expectation(description: "Fetching products from API")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.cartViewModel.addProduct(withID: 3)
            self.cartViewModel.addProduct(withID: 10)
            self.cartViewModel.addProduct(withID: 1)
            self.cartViewModel.addProduct(withID: 10)
            self.cartViewModel.addProduct(withID: 7)
            self.cartViewModel.addProduct(withID: 13)
            self.cartViewModel.addProduct(withID: 13)
            self.cartViewModel.addProduct(withID: 13)
            self.cartViewModel.addProduct(withID: 2)
            self.cartViewModel.removeProduct(withID: 10)
            XCTAssertEqual(self.cartViewModel.selectedProducts.count, 5)
        
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5)
    }
    
    func testSelectedItemsQuantityAfterProductRemoval() {
        let expectation = self.expectation(description: "Fetching products from API")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.cartViewModel.addProduct(withID: 5)
            self.cartViewModel.addProduct(withID: 15)
            self.cartViewModel.addProduct(withID: 11)
            self.cartViewModel.addProduct(withID: 11)
            self.cartViewModel.addProduct(withID: 8)
            self.cartViewModel.addProduct(withID: 1)
            self.cartViewModel.addProduct(withID: 6)
            self.cartViewModel.addProduct(withID: 11)
            self.cartViewModel.removeProduct(withID: 11)
            XCTAssertEqual(self.cartViewModel.selectedItemsQuantity, 5)
        
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5)
    }
    
    func testClearCart() {
        let expectation = self.expectation(description: "Fetching products from API")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.cartViewModel.addProduct(withID: 1)
            self.cartViewModel.addProduct(withID: 6)
            self.cartViewModel.addProduct(withID: 12)
            self.cartViewModel.addProduct(withID: 13)
            self.cartViewModel.addProduct(withID: 4)
            self.cartViewModel.addRandomProduct()
            self.cartViewModel.addRandomProduct()
            self.cartViewModel.addRandomProduct()
            self.cartViewModel.addRandomProduct()
            self.cartViewModel.clearCart()
            XCTAssertEqual(self.cartViewModel.selectedItemsQuantity, 0)
            
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5)
    }
    
    func testTotalPriceOfItemsInCart() {
        let expectation = self.expectation(description: "Fetching products from API")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.cartViewModel.addProduct(withID: 3)
            self.cartViewModel.addProduct(withID: 11)
            self.cartViewModel.addProduct(withID: 11)
            self.cartViewModel.addProduct(withID: 11)
            self.cartViewModel.addProduct(withID: 15)
            self.cartViewModel.addProduct(withID: 1)
            XCTAssertEqual(self.cartViewModel.totalPrice, 1867)
            
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5)
}
    
    func testTotalPriceOfProductsInCart() {
        let expectation = self.expectation(description: "Fetching products from API")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.cartViewModel.addProduct(withID: 7)
            self.cartViewModel.addProduct(withID: 13)
            self.cartViewModel.addProduct(withID: 15)
            self.cartViewModel.addProduct(withID: 4)
            XCTAssertGreaterThan(self.cartViewModel.totalPrice!, 1500)
            XCTAssertTrue(self.cartViewModel.totalPrice! > 1500)
            
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5)
    }
    
    func testTitleOfProductWithSelectedIndex() {
        let expectation = self.expectation(description: "Fetching products from API")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.cartViewModel.addProduct(withID: 2)
            self.cartViewModel.addProduct(withID: 8)
            self.cartViewModel.addProduct(withID: 8)
            self.cartViewModel.addProduct(withID: 11)
            self.cartViewModel.addProduct(withID: 4)
            XCTAssertEqual(self.cartViewModel.selectedProducts[2].title, "perfume Oil")
            
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchProducts() {
        let expectation = self.expectation(description: "Fetching products from API")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.cartViewModel.fetchProducts()
            XCTAssertTrue(self.cartViewModel.allProducts?.count != nil)
            
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5)
    }
}
