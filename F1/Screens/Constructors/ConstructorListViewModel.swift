//
//  ConstructorsViewModel.swift
//  YourAppName
//
//  Created by You on 4/20/25.
//

import Foundation
import SwiftUI

/// ViewModel for loading and exposing F1 constructor standings—no Combine needed.
final class ConstructorsViewModel: ObservableObject {
    
    // MARK: - Published properties
    
    /// Flat array of individual constructor standings.
    @Published var constructorStandings: [ConstructorStandings] = []
    /// Whether a fetch is in progress.
    @Published  var isLoading: Bool = false
    /// An error message to display if the fetch fails.
    @Published var errorMessage: String?
    
    func fetchConstructorStandings() {
        isLoading = true
        errorMessage = nil
        
        
        NetworkManager.shared.fetchConstructorStandings { [weak self] result in
            // Switch back to the main thread for UI updates
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                
                switch result {
                case .success(let lists):
                    // Flatten the nested arrays into a single list
                    self.constructorStandings = lists.flatMap { $0.constructorStandings }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

