//
//  ContentView.swift
//  EventIOS
//
//  Created by Duong Tuan on 01/07/2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_status") var logStatus: Bool = false
    var body: some View {
        // MARK: Redirecting User Based on Log Status
        if logStatus{
            Text("Main View")
        }else{
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
