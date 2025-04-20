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
    @Published var allStandings: [ConstructorStandings] = []
    /// Whether a fetch is in progress.
    @Published  var isLoading: Bool = false
    /// An error message to display if the fetch fails.
    @Published var errorMessage: String?
    
    @Published var topConstructors: [ConstructorStandings] = []
    @Published var bottomConstructors: [ConstructorStandings] = []
    
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
                    // Sort all by points descending
                    self.allStandings = lists.flatMap { $0.constructorStandings }
                    let sortedStandings = self.allStandings.sorted {
                        (Double($0.points)) > (Double($1.points))
                    }
                    // Slice top 3 and the rest
                    self.topConstructors = Array(sortedStandings.prefix(3))
                    self.bottomConstructors = Array(sortedStandings.dropFirst(3))
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }

    }
}

