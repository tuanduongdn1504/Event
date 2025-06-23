//
//  EventsView.swift
//  Event Watch App
//
//  Created by Duong Tuan on 15/06/2025.
//

import SwiftUI

struct EventsView: View {
    
    @StateObject private var viewModel = EventsViewModel()
    
    var body: some View {
        BaseView(viewModel: viewModel) {
            ScrollView {
                if !viewModel.events.isEmpty {
                    RefreshHeader(
                        refreshing: $viewModel.headerRefreshing,
                        action: {
                            viewModel.reload()
                        }, label: { _ in
                            if viewModel.headerRefreshing {
                                RefreshingView()
                            }
                        })
                }
                
                ForEach(viewModel.events, id: \.id) { item in
                    EventsItemView(item: item)
                }
                
                if !viewModel.events.isEmpty {
                    RefreshFooter(
                        refreshing: $viewModel.footerRefreshing,
                        action: {
                            viewModel.loadMore()
                        }, label: {
                            if viewModel.noMore {
                                NoMoreView()
                            } else {
                                RefreshingView()
                            }
                        })
                }
            }
            .enableRefresh()
        }
        .background(.white)
        .withToolbar(title: "Company events")
        .onAppear {
            viewModel.fetchEvents()
        }
    }
}
