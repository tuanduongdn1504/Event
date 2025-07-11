//
//  EventIOSApp.swift
//  EventIOS
//
//  Created by Duong Tuan on 01/07/2025.
//

import SwiftUI
import Firebase

@main
struct EventIOSApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
