//
//  BaseViewModel.swift
//  Event Watch App
//
//  Created by Duong Tuan on 01/06/2025.
//

import Foundation
import Combine

/// A base class for all ViewModels to inherit common properties and functionalities.
class BaseViewModel: ObservableObject {
    /// A collection of cancellables to manage Combine subscriptions.
    var cancellables = Set<AnyCancellable>()
    
    /// A published property to handle global error messages in the app.
    @Published var errorMessage: String? = nil
    
    /// A published property to track loading states.
    @Published var isLoading: Bool = false
    
    /// Initializes the base ViewModel.
    init() {
        print("[\(type(of: self))] initialized.")
    }
    
    /// Deinitializes the base ViewModel and clears resources.
    deinit {
        print("[\(type(of: self))] deinitialized.")
    }
    
    func handleError(_ error: Error) {
        errorMessage = error.localizedDescription
        print("Error occurred: \(error.localizedDescription)")
    }
    
    func clearCancellables() {
        cancellables.removeAll()
    }
    
    func clearError() {
        errorMessage = nil
    }
}
