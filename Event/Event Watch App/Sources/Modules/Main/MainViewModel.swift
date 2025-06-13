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
    case splash
}

class MainViewModel: BaseViewModel {

    @Published var currentView: ViewType = .splash

    override init() {
        super.init()
    }

}
