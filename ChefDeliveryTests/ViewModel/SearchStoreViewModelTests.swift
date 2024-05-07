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
                                    products: [], specialties: ["tacos", "mexicana"])
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
    
    func testFilteredStoresUsingTerm() {
        
        sut.storesType = [StoreType(id: 1,
                                    name: "Monstro Burger",
                                    logoImage: nil,
                                    headerImage: nil,
                                    location: "Rua Principal, 123, São Paulo, SP",
                                    stars: 4,
                                    products: [],
                                    specialties: ["hamburguer", "lanchonete"]),
                          StoreType(id: 2,
                                    name: "Food Court",
                                    logoImage: nil,
                                    headerImage: nil,
                                    location: "Avenida Secundária, 456, São Paulo, SP",
                                    stars: 4,
                                    products: [],
                                    specialties: ["pizza", "lanchonete"]),
                          StoreType(id: 3,
                                    name: "Carbron",
                                    logoImage: nil,
                                    headerImage: nil,
                                    location: "Rua Terceira, 789, São Paulo, SP",
                                    stars: 4,
                                    products: [],
                                    specialties: ["tacos", "mexicana"]),
                          StoreType(id: 4,
                                    name: "Casa do Sushi",
                                    logoImage: nil,
                                    headerImage: nil,
                                    location: "Av. dos Sushis, 456, São Paulo, SP",
                                    stars: 4,
                                    products: [],
                                    specialties: ["sushi", "Japonês"]),
                          StoreType(id: 5,
                                    name: "Sabor da Índia",
                                    logoImage: nil,
                                    headerImage: nil,
                                    location: "Av. dos Sushis, 456, São Paulo, SP",
                                    stars: 4,
                                    products: [],
                                    specialties: ["Indiana", "curries"]),
                          StoreType(id: 6,
                                    name: "Sabor Tailandês",
                                    logoImage: nil,
                                    headerImage: nil,
                                    location: "Av. dos Sushis, 456, São Paulo, SP",
                                    stars: 4,
                                    products: [],
                                    specialties: ["Cozinha tailandesa", "comida apimentada"]),
                          StoreType(id: 7,
                                    name: "Sabores Mediterrâneos",
                                    logoImage: nil,
                                    headerImage: nil,
                                    location: "Av. dos Sushis, 456, São Paulo, SP",
                                    stars: 4,
                                    products: [],
                                    specialties: ["Cozinha mediterrânea", "Grego"])
        ]
        
        sut.searchText = "pizza"
        
        let filteredStores = sut.filteredStores()
        
        XCTAssertEqual(1, filteredStores.count)
        XCTAssertEqual("Food Court", filteredStores[0].name)
    }

}
