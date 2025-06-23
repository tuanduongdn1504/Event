//
//  WatchServiceContainer.swift
//  Event Watch App
//
//  Created by Duong Tuan on 17/06/2025.
//

import Foundation

class WatchServiceContainer {
    static var shared = WatchServiceContainer()
    
    lazy var watchService: EventWatchAPI = EventWatchRestfulAPI()
}
