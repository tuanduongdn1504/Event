//
//  EventsViewModel.swift
//  Event Watch App
//
//  Created by Duong Tuan on 15/06/2025.
//

import Foundation

class EventsViewModel: BaseViewModel {
    @WatchService(\.watchService)
    private var watchService
    
    @Published var headerRefreshing: Bool = false
    @Published var footerRefreshing: Bool = false
    @Published var noMore: Bool = false
    
    @Published private(set) var events: [EventsModel] = []
    
    func fetchEvents() {
        isLoading = true
        events = []
        getData()
    }
    
    func reload() {
        getData(action: { eventItems in
            self.events = eventItems
            self.headerRefreshing = false
            self.noMore = false
        })
    }
    
    func loadMore() {
        getData(action: { eventItems in
            self.footerRefreshing = false
        })
    }
    
    private func getData(action: (([EventsModel]) -> Void)? = nil) {
        errorMessage = nil
        
        watchService.getEvents()
            .handleEvents(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            })
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] eventItems in
                guard let self = self else { return }
                self.events.append(contentsOf: eventItems)
                action?(eventItems)
                print(eventItems)
            })
            .store(in: &cancellables)
    }
}
