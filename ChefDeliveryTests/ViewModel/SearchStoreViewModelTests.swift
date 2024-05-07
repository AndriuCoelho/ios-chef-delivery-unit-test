//
//  SearchStoreViewModelTests.swift
//  ChefDeliveryTests
//
//  Created by ALURA on 03/05/24.
//

import XCTest
@testable import ChefDelivery

final class SearchStoreViewModelTests: XCTestCase {
    
    // MARK: - Attributes
    
    var sut: SearchStoreViewModel!
    
    // MARK: - Setup

    override func setUpWithError() throws {
        sut = SearchStoreViewModel(service: SearchService())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Unit tests

    func testFilteredStores() {
        sut.storesType = [StoreType(id: 1,
                                    name: "Monstro Burger",
                                    logoImage: nil,
                                    headerImage: nil,
                                    location: "",
                                    stars: 4,
                                    products: []),
                          StoreType(id: 2,
                                    name: "Food Court",
                                    logoImage: nil,
                                    headerImage: nil,
                                    location: "",
                                    stars: 4,
                                    products: []),
                          StoreType(id: 3,
                                    name: "Carbron",
                                    logoImage: nil,
                                    headerImage: nil,
                                    location: "",
                                    stars: 3,
                                    products: [])
        ]
        
        sut.searchText = "Ca"
        
        let filteredStores = sut.filteredStores()
        
        XCTAssertEqual(1, filteredStores.count)
        XCTAssertEqual("Carbron", filteredStores[0].name)
    }
    
    func testFilteredStoresWithSpecialCharactersInSearchText() {
        sut.storesType = [StoreType(id: 1,
                                    name: "Monstro Burger",
                                    logoImage: nil,
                                    headerImage: nil,
                                    location: "",
                                    stars: 4,
                                    products: []),
                          StoreType(id: 2,
                                    name: "Food Court",
                                    logoImage: nil,
                                    headerImage: nil,
                                    location: "",
                                    stars: 4,
                                    products: []),
                          StoreType(id: 3,
                                    name: "Carbron",
                                    logoImage: nil,
                                    headerImage: nil,
                                    location: "",
                                    stars: 3,
                                    products: [])
        ]
        
        sut.searchText = "!@#$%"
        
        let filteredStores = sut.filteredStores()
        
        XCTAssertTrue(filteredStores.isEmpty)
    }

}
