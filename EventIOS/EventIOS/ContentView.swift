//
//  ContentView.swift
//  EventIOS
//
//  Created by Duong Tuan on 01/07/2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_status") var logStatus: Bool = false
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    // This will check if we have a persisted login
        private var isPersistedLogin: Bool {
            UserDefaults.standard.bool(forKey: "isLoggedIn")
        }
    
    var body: some View {
        // MARK: Redirecting User Based on Log Status
        if logStatus || isPersistedLogin && authViewModel.currentUser != nil {
            Text("\(logStatus ? "true": "false") || \(isPersistedLogin ? "true": "false") && \(authViewModel.currentUser != nil ? "true": "false")")
        }else{
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
