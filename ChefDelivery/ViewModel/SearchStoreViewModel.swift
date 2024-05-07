//
//  SearchStoreViewModel.swift
//  ChefDelivery
//
//  Created by ALURA on 03/05/24.
//

import Foundation

class SearchStoreViewModel: ObservableObject {
    
    // MARK: - Attributes
    
    let service: SearchService
    @Published var storesType: [StoreType] = []
    @Published var searchText: String = ""
    
    init(service: SearchService) {
        self.service = service
        fetchData()
    }
    
    // MARK: - Class methods
    
    func fetchData() {
        Task {
            do {
                let result = try await service.fetchData()
                switch result {
                case .success(let stores):
                    self.storesType = stores
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func filteredStores() -> [StoreType] {
        if searchText.isEmpty {
            return storesType
        } else {
            let searchTerms = searchText.lowercased().components(separatedBy: " ")
            
            return storesType.filter { store in
                let nameContainsSearchTerm = searchTerms.allSatisfy { term in
                    store.name.lowercased().contains(term)
                }
                
                let specialtiesContainsSearchTerm = searchTerms.allSatisfy { term in
                    store.specialties?.contains { $0.lowercased().contains(term) } ?? false
                }
                
                return nameContainsSearchTerm || specialtiesContainsSearchTerm
            }
        }
    }
    
}
