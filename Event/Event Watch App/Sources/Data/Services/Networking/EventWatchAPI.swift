//
//  EventWatchAPI.swift
//  Event Watch App
//
//  Created by Duong Tuan on 17/06/2025.
//

import Combine

protocol EventWatchAPI {
    func getEvents() -> AnyPublisher<[EventsModel], Error>
}

