//
//  MainViewModel.swift
//  Event Watch App
//
//  Created by Duong Tuan on 01/06/2025.
//

import Foundation
import WatchConnectivity
import RxSwift

enum ViewType {
    case auth
    case splash
}

class MainViewModel: BaseViewModel {

    @Published var currentView: ViewType = .splash

    override init() {
        super.init()
        requestAuthorization()
    }
    
    func requestAuthorization() {
        isLoading = true
        DispatchQueue.main.async {
            // Hard code for response instead of call API
            let isLoggedIn = false
                    
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isLoading = false
                self.currentView = isLoggedIn ? .splash : .auth
            }
            
        }
    }
}
