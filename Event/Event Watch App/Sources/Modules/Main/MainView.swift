//
//  MainView.swift
//  Event Watch App
//
//  Created by Duong Tuan on 01/06/2025.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var mainViewModel: MainViewModel
    
    var body: some View {
        Group {
            switch mainViewModel.currentView {
            case .splash:
                SpashView()
            case .auth:
                RequestAuthenticationView()
                    .environmentObject(mainViewModel)
            case .home:
                ZStack {
                    NavigationStack {
                        HomeView()
                    }
                   
                }
            }
            
        }
    }
}
