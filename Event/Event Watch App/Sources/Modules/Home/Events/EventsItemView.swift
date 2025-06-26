//
//  EventsItemView.swift
//  Event Watch App
//
//  Created by Duong Tuan on 16/06/2025.
//

import SwiftUI

struct EventsItemView: View {
    
    var item: EventsModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xSmall.rawValue) {
            Text(item.displayStartTimeEndTime)
                .foregroundStyle(Color.primaryColor)
                .font(.avenirNext(size: 10, type: .medium))
            
            Text(item.title)
                .foregroundStyle(Color.mineShaft)
                .font(.avenirNext(size: 12, type: .bold))
            
            Text(item.location ?? "")
                .foregroundStyle(Color.grey600)
                .font(.avenirNext(size: 10, type: .medium))
            
            Divider()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .background(Color(hex: "#E8E8E8"))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, Spacing.large.rawValue)
        .onAppear {
            print(item)
        }
    }
}
