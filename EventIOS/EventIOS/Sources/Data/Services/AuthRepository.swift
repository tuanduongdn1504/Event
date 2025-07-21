//
//  AuthRepository.swift
//  EventIOS
//
//  Created by Duong Tuan on 04/07/2025.
//

import Foundation
import FirebaseAuth
import AuthenticationServices

// Authentication repository protocol
protocol AuthRepositoryProtocol {
    func signInWithEmail(email: String, password: String) async throws -> User
    func signUpWithEmail(email: String, password: String) async throws -> User
    func signOut() async throws
    func sendPasswordReset(email: String) async throws
    func sendEmailVerification() async throws
    func getCurrentUser() -> User?
    func updateUserProfile(displayName: String?, photoURL: URL?) async throws
    func deleteAccount() async throws
    func reauthenticate(email: String, password: String) async throws
    func updateEmail(email: String) async throws
    func updatePassword(password: String) async throws
}

// Implementation of the repository
class FirebaseAuthRepository: NSObject, AuthRepositoryProtocol {
    private var currentNonce: String?
    private var appleSignInCompletion: ((Result<User, Error>) -> Void)?
    
    func signInWithEmail(email: String, password: String) async throws -> User {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            return result.user
        } catch {
            throw AuthError.signInFailed(description: error.localizedDescription)
        }
    }
    
    func signUpWithEmail(email: String, password: String) async throws -> User {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            // Send email verification
            try await result.user.sendEmailVerification()
            return result.user
        } catch {
            throw AuthError.signUpFailed(description: error.localizedDescription)
        }
    }
    
    func signOut() async throws {
        do {
            try Auth.auth().signOut()
        } catch {
            throw AuthError.signOutFailed(description: error.localizedDescription)
        }
    }
    
    func sendPasswordReset(email: String) async throws {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch {
            throw AuthError.passwordResetFailed(description: error.localizedDescription)
        }
    }
    
    func sendEmailVerification() async throws {
        guard let user = Auth.auth().currentUser else {
            throw AuthError.userNotFound
        }
        
        try await user.sendEmailVerification()
    }
    
    func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    func updateUserProfile(displayName: String?, photoURL: URL?) async throws {
        guard let user = Auth.auth().currentUser else {
            throw AuthError.userNotFound
        }
        
        let changeRequest = user.createProfileChangeRequest()
        
        if let displayName = displayName {
            changeRequest.displayName = displayName
        }
        
        if let photoURL = photoURL {
            changeRequest.photoURL = photoURL
        }
        
        try await changeRequest.commitChanges()
    }
    
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            throw AuthError.userNotFound
        }
        
        try await user.delete()
    }
    
    func reauthenticate(email: String, password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw AuthError.userNotFound
        }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        try await user.reauthenticate(with: credential)
    }
    
    func updateEmail(email: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw AuthError.userNotFound
        }
        
        try await user.sendEmailVerification(beforeUpdatingEmail: email)
    }
    
    func updatePassword(password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw AuthError.userNotFound
        }
        
        try await user.updatePassword(to: password)
    }
}

enum AuthError: Error, LocalizedError {
    case signInFailed(description: String)
    case signUpFailed(description: String)
    case signOutFailed(description: String)
    case userNotFound
    case invalidCredential
    case noRootViewController
    case emailNotVerified
    case passwordResetFailed(description: String)
    case updateProfileFailed(description: String)
    case deleteAccountFailed(description: String)
    case reauthenticationFailed(description: String)
    case updateEmailFailed(description: String)
    case updatePasswordFailed(description: String)
    
    var errorDescription: String? {
        switch self {
        case .signInFailed(let description):
            return "Sign in failed: \(description)"
        case .signUpFailed(let description):
            return "Sign up failed: \(description)"
        case .signOutFailed(let description):
            return "Sign out failed: \(description)"
        case .userNotFound:
            return "User not found"
        case .invalidCredential:
            return "Invalid credentials"
        case .noRootViewController:
            return "Could not find root view controller"
        case .emailNotVerified:
            return "Email not verified"
        case .passwordResetFailed(let description):
            return "Password reset failed: \(description)"
        case .updateProfileFailed(let description):
            return "Failed to update profile: \(description)"
        case .deleteAccountFailed(let description):
            return "Failed to delete account: \(description)"
        case .reauthenticationFailed(let description):
            return "Reauthentication required: \(description)"
        case .updateEmailFailed(let description):
            return "Failed to update email: \(description)"
        case .updatePasswordFailed(let description):
            return "Failed to update password: \(description)"
        }
    }
}
