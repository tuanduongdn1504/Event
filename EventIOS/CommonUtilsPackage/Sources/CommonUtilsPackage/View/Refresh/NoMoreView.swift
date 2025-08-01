//
//  NoMoreView.swift
//  
//
//  Created by Duong Tuan on 20/07/2025.
//

import SwiftUI

public struct NoMoreView: View {
    private var title: String
        
    public init (title: String = "No more data !") {
        self.title = title
    }
    
    public var body: some View {
        Text(title)
            .font(.avenirNext(size: 8, type: .regular))
            .foregroundColor(Color.mineShaft)
    }
}
