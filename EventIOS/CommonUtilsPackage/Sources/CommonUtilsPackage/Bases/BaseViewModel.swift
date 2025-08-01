//
//  BaseViewModel.swift
//
//
//  Created by Duong Tuan on 20/07/2025.
//

import Foundation
import Combine

/// A base class for all ViewModels to inherit common properties and functionalities.
open class BaseViewModel: ObservableObject {
    /// A collection of cancellables to manage Combine subscriptions.
    public var cancellables = Set<AnyCancellable>()
    
    /// A published property to handle global error messages in the app.
    @Published public var errorMessage: String? = nil
    
    /// A published property to track loading states.
    @Published public var isLoading: Bool = false
    
    /// With an Open class, allowing subclasses overriding the initializer just by Public initializer.
    public init() {
        print("[\(type(of: self))] initialized.")
    }
    
    /// Deinitializes the base ViewModel and clears resources.
    deinit {
        print("[\(type(of: self))] deinitialized.")
    }
    
    public func handleError(_ error: Error) {
        errorMessage = error.localizedDescription
        print("Error occurred: \(error.localizedDescription)")
    }
    
    public func clearCancellables() {
        cancellables.removeAll()
    }
    
    public func clearError() {
        errorMessage = nil
    }
}
