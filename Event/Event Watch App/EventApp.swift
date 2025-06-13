//
//  EventApp.swift
//  Event Watch App
//
//  Created by Duong Tuan on 01/06/2025.
//

import SwiftUI

@main
struct Event_Watch_AppApp: App {
    @StateObject private var mainViewModel = MainViewModel()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(mainViewModel)
        }
    }
}
