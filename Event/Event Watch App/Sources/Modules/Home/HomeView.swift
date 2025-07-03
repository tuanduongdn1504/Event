//
//  HomeView.swift
//  Event Watch App
//
//  Created by Duong Tuan on 03/06/2025.
//

import SwiftUI

enum HomeSectionType: Hashable {
    case timeSheet
    case actions
    case news
    case events
    
    var title: String {
        switch self {
        case .timeSheet: return "Timesheet"
        case .actions: return "Actions"
        case .news: return "New Timesheet"
        case .events: return "Events"
        default: return ""
        }
    }
    
    var icon: String {
        switch self {
        case .timeSheet: return WatchAppIcon.timeSheet.rawValue
        case .actions: return WatchAppIcon.actions.rawValue
        case .news: return WatchAppIcon.news.rawValue
        case .events: return WatchAppIcon.events.rawValue
        default: return ""
        }
    }
}

struct HomeView: View {
    private let homeSections: [HomeSectionType] = [.timeSheet, .actions, .news, .events]
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var path: [HomeSectionType] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader { geo in
                LazyVGrid(columns: columns) {
                    ForEach(homeSections, id: \.self) { section in
                                            Button {
                                                path.append(section)
                                            } label: {
                                                CircleIconView(iconName: section.icon, title: section.title)
                                            }
                                            .buttonStyle(.borderless)
                                        }
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .background(Color.white)
            }
        }
        
        .navigationDestination(for: HomeSectionType.self) { section in
            switch section {
            case .timeSheet:
                SpashView()
            case .actions:
                SpashView()
            case .news:
                SpashView()
            case .events:
                EventsView()
            }
        }
    }
}

struct CircleIconView: View {
    let iconName: String
    let title: String
    
    var body: some View {
        VStack(alignment: .center) {
            Image(iconName)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 50, height: 50)
                .background(Color.clear)
            Text(title)
                .foregroundColor(.black)
                .font(.footnote).background(Color.clear)
        }
    }
}

